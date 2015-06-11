#!/usr/bin/python
import serial
import socket 
from sys import exit
import os, fcntl
import time
import signal
import time    
import select
import datetime
import struct
from contextlib import contextmanager
from multiprocessing.dummy import Pool as ThreadPool 
from time import sleep
 
send_ok_period = 120 #sends ERRPI_ACKCLEAR every 2 minutes
send_ok_timer = time.time()
send_ok_timer_pi = time.time()

#comment this to turn socket messages (to the TCP watchdog server) off 
USE_SOCKETS = 1

#set TCP watchdog IP and port here
#host = '192.168.1.66';
host = '192.168.1.17';
port = 6666;

#creates a socket up-front, just to initialize it 
if (USE_SOCKETS):
    #create an INET, STREAMing socket
    try:
            watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
            print 'Failed to create socket: %s' % e

#gets IP address of eth0 as a string
def get_ip_address(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

#connects to the TCP watchdog. See host/port above. Run in a loop to retry
def socket_connect():
    global watchsock
    global host
    global port
    if (USE_SOCKETS):
        try:
            watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
            remote_ip = socket.gethostbyname( host )
            watchsock.connect((remote_ip , port))
 
        except socket.error as e:
            print 'Failed to create socket: %s' % e
            return 0
        else:
            print 'Socket Connected to ' + host + ' on ip ' + remote_ip
            return 1

# ensures we can kill the script with ctrl-C for testing
def signal_handler(signal, frame):
    print('Exiting...')
    os._exit(0) 

signal.signal(signal.SIGINT, signal_handler)

#class with all internal variables & its own named pipe for each Arduino
class Arduino:
    
    def __init__(self, port, pin, timeout, wdtime, dogtime):

 # port: input pipe filename, from Arduino (i.e. "/path/to/watchdog_pipe")
 # pin: GPIO output pin number to connect to Arduino reset (i.e. 1, 20)
 # timeout: seconds to serial timeout. set to 0 for non-blocking.
 # wdtime: seconds to firing watchdog (i.e. 10.0)
 # dogtime: seconds between subsequent watchdogs, to prevent reset loops (60)
 
        print "new Arduino object with port: " + port + " pin: " + str(pin) + " serial timeout: " + str(timeout) 
        print "                        watchdog sec: " + str(wdtime) + " watchdog timeout: " + str(dogtime)
        self.port = port
        self.pin = pin
        self.wdtime = wdtime
        self.dogtime = dogtime
        self.start = time.time()
        self.failstart = time.time()
        self.wdtimerstart = time.time()
        self.send_ok_timer = time.time()
        self.set_failstart = 0
        self.textln = ""
        self.not_open = 1
        self.last_len = 0
        self.send_ok = 1;
        try:
            self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
        except Exception, e:
            print "Failed to open %s : %s!" % (self.port, e)

#this opens the named pipe
    def openPort(self):
        if (self.not_open):
            try:
                self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
            except Exception, e:
                print "Failed to open %s : %s!" % (self.port, e)
            else:
                self.not_open = 0;

    def get_uptime(self):

        with open('/proc/uptime', 'r') as f:
            uptime_seconds = float(f.readline().split()[0])
            uptime_string = str(datetime.timedelta(seconds = uptime_seconds))

            print(uptime_string)
            return (uptime_string, uptime_seconds)

#this sends an OK message (ERRDUINO_ACKCLEAR or ERRPI_ACKCLEAR) via TCP
    def send_ok_now(self, pi_or_arduino):
         if (USE_SOCKETS):
             try:
                 if (pi_or_arduino == "PI"):
                     ip = get_ip_address('eth0')

                     uptime_string , uptime_seconds = self.get_uptime()
                     message = "ERRPI_ACKCLEAR " + ip + " " + str(uptime_seconds) + " " + uptime_string
#str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))   
                 else:
                     uptime_string , uptime_seconds = self.get_uptime()
                     message = "ERRDUINO_ACKCLEAR " + str(socket.gethostname()) + "/" + self.port + " " + str(uptime_seconds) + " " + uptime_string
# str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))

                 watchsock.sendall(message)
             except socket.error as e:
                 print "Send failed! %s" % e
                 status = socket_connect()
                 if (status == 1):
                     watchsock.sendall(message)
                 else:
                     print "failed to send " + message
                 #put retry here
 
#this sends the watchdog message (errcode) via TCP
    def watchdog(self, errcode):
#        print("Watchdog called on port " + self.port + " Time since last dog: " + str(time.time() - self.wdtimerstart))
        if (time.time() - self.wdtimerstart > self.dogtime):
            self.wdtimerstart = time.time();
            self.send_ok = 1; #this tells the watchdog to send an ACKCLEAR
                              #on the next good read
            uptime_string, uptime_seconds = self.get_uptime()
            print("WATCHDOG ACTIVE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+ self.port + " " + str(uptime_seconds) + " " + uptime_string)
#str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S")))
            if (USE_SOCKETS):
                try:
                    message = errcode + " " + str(socket.gethostname()) + "/" + self.port + " " + str(uptime_seconds) + " " + uptime_string
#str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
                    watchsock.sendall(message)
                except socket.error as e:
                    # tries to reconnect every time round the loop
                    print "Send failed! %s" % e
                    status = socket_connect() 
                    if (status == 1):
                        watchsock.sendall(message)
                    else:
                        print "failed to send " + message

#this is the main scan loop for each arduino. Gets data over the pipe, and 
#either resets the watchdog timer due to good data, or waits til it expires
#and triggers the watchdog.
    def scan(self):
            sleep(0.005) #otherwise it eats every CPU :3
                         #delete/tweak this if you're getting lag
            try:
#try block creates, opens, and reads serials. if any failures, retry.
                self.openPort()
                #it's difficult to get non-blocking pipes in Python, but the 
                #following works!
                r,w,x = select.select([self.pipein],[],[],0)
                if self.pipein in r:
                    self.textln=os.read(self.pipein, 1)
                    #ignore 0xFFs sent by serial line failure
                    if (self.textln == 0xFF):
                        print "Ignoring 0xFF"
                        self.last_len = 0
                    else:
                        #sends the OK message for the connected Arduino
                        if (self.send_ok == 1):
                            self.send_ok_now("ARDUINO")
                            self.send_ok = 0;
                        self.last_len = len(self.textln)
                else:
                    self.last_len = 0
            except Exception, e:
                print "PIPE FAILURE! %s" % e
                self.not_open = 1
                if (self.set_failstart == 0):
                    self.failstart = time.time() # records time of failure
                    self.set_failstart = 1 
                # ^ sets a failure code to keep from rewriting the failure time over & over
                if (time.time() - self.failstart > self.wdtime):
                    # if it's been so long since serial failure, pop the watchdog
                    print "top dog on " + self.port
                    self.watchdog("ERRDUINO_DISCON")

            #From here down, we got a read-success    
            self.set_failstart = 0  # clears the failure code in case we failed earlier 
            if (self.last_len != 0):
                print "Got data on port " + self.port + " in sec:" + str(time.time() - self.start) + "  " + self.textln 
                self.start = time.time()
                if (USE_SOCKETS):
                #sends ERRPI_ACKCLEAR every X seconds
                    global send_ok_timer
                    global send_ok_timer_pi
                    global send_ok_period
                    #print "timer " + str(time.time() - send_ok_timer) + " period " + str(send_ok_period)
                    if (time.time() - send_ok_timer_pi > send_ok_period + 30):
                        print "time's up, send update"
                        self.send_ok_now("PI")
                        send_ok_timer_pi = time.time()
                    if (time.time() - self.send_ok_timer > send_ok_period):
                        print "time's up, send update"
                        self.send_ok_now("ARDUINO")
                        self.send_ok_timer = time.time()

 #               print "self.start reset to " + str(self.start) + "at " + str(datetime.datetime.now())
            else: 
                    #because the Pi itself is still up even when its arduinos are not, we need to duplicate this here or we will never hear back from the pi is all arduinos are down
                if (time.time() - send_ok_timer_pi > send_ok_period + 30):
                    print "time's up, send update"
                    self.send_ok_now("PI")
                    send_ok_timer_pi = time.time()
                 #print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
                #likewise, if it's been too long since we saw data, pop the watchdog
                if (time.time() - self.start > self.wdtime):
                    self.watchdog("ERRDUINO_NOREPLY")
#main starts here

print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

#set up serial connection...
if (USE_SOCKETS):
    status = 0
    while (status == 0):
        status = socket_connect()
    
#use serial2pipe to split the Arduino output into two named pipes, then attach
#the following to one of the pipes, and the other to the program to be 
#monitored!

#note: wdtime should be at least 2x patting-time to prevent spurious watchdogs
#                  input filename,             pin,timeout, wdtime, dogtime
arduino1 = Arduino("serial2pipe/watchdog_pipe1", 1, 0.0, 40.0, 100.0)
arduino2 = Arduino("serial2pipe/watchdog_pipe2", 1, 0.0, 43.0, 103.0)
#arduino3 = None

# builds a list to step through the arduinos
arduinolist = []
arduinolist.append(arduino1)
arduinolist.append(arduino2)
#arduinolist.append(arduino3)

print len(arduinolist)

while 1:
    if (len(arduinolist) == 1):
        arduino1.scan()
    else:
        for l in arduinolist:
            l.scan()

# fifth version. Uses named pipes rather than serial comms!


