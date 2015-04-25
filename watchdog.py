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
from contextlib import contextmanager
from multiprocessing.dummy import Pool as ThreadPool 
from time import sleep
 
#comment this to turn socket messages (to the TCP watchdog server) off 
USE_SOCKETS = 1

if (USE_SOCKETS):
    #create an INET, STREAMing socket
    try:
        watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error:
        print 'Failed to create socket'
        #put retry here
    print "Socket created..."

# ensures we can kill the script with ctrl-C for testing
# I took this out because once I added pool.map() it just WILL NOT DIE. 
# kill -9 it if using more than one Arduino...

def signal_handler(signal, frame):
    print('Exiting...')
    os._exit(0) 

signal.signal(signal.SIGINT, signal_handler)

#wrapper function to pass into pool.map()
def call_scan(obj): 
    obj.scan ()
    return obj

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
        self.set_failstart = 0
        self.textln = ""
        self.not_open = 1
        self.last_len = 0
        self.send_ok = 0;
        try:
            self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
        except Exception, e:
            print "Failed to open %s!" % self.port
        self.openPort()
        self.watchdog()
        self.scan()
        self.send_ok_now()

    def openPort(self):
        if (self.not_open):
            try:
                self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
            except Exception, e:
                print "Failed to open %s!" % self.port
            else:
                self.not_open = 0;

    def send_ok_now(self):
         if (USE_SOCKETS):
             try:
                 message = "WATCHDOG >>clear<< on: " + str(socket.gethostname()) + " " + self.port + " " + str(datetime.datetime.now())
                 watchsock.sendall(message)
             except socket.error:
                 print "Send failed!"
                 #put retry here

    def watchdog(self):
        print("Watchdog called on port " + self.port + " Time since last dog: " + str(time.time() - self.wdtimerstart))
        if (time.time() - self.wdtimerstart > self.dogtime):
            #for now, all this does is print. In future it'll write out to a 
            #Pi pin to cause the attached Arduino to reset.
            
            #reset code goes here
            self.wdtimerstart = time.time();
            self.send_ok = 1;
            print("WATCHDOG ACTIVE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+ self.port + " " + str(datetime.datetime.now()))
            if (USE_SOCKETS):
                try:
                    message = "WATCHDOG ACTIVE on: " + str(socket.gethostname()) + " " + self.port + " " + str(datetime.datetime.now())
                    watchsock.sendall(message)
                except socket.error:
                    print "Send failed!"
                    #put retry here

    def scan(self):
        #while 1:
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
                        if (self.send_ok == 1):
                            self.send_ok_now()
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
                    self.watchdog()
                    #break
            #From here down, we got a read-success    
            self.set_failstart = 0  # clears the failure code in case we failed earlier 
            if (self.last_len != 0):
                print "Got data on port " + self.port + " in sec:" + str(time.time() - self.start) + " " + self.textln + "at " + str(datetime.datetime.now())
                self.start = time.time()
                print "self.start reset to " + str(self.start) + "at " + str(datetime.datetime.now())
            else: 
                 #print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
                #likewise, if it's been too long since we saw data, pop the watchdog
                 if (time.time() - self.start > self.wdtime):
#                     print "start time was " + str(self.start)
#                     print "bottom dog on " + self.port + " " + "at " + str(datetime.datetime.now())
                     self.watchdog()


print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

#set up serial connection...
if (USE_SOCKETS):
 
    host = 'localhost';
    port = 6666;
 
    try:
        remote_ip = socket.gethostbyname( host )
 
    except socket.error:
    #could not resolve
        print 'Hostname could not be resolved. Try again later'
        #put retry here
 
#Connect to remote server
    watchsock.connect((remote_ip , port))
 
    print 'Socket Connected to ' + host + ' on ip ' + remote_ip

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

# this creates a thread pool and assigns each working loop its own thread.
print len(arduinolist)

while 1:
    if (len(arduinolist) == 1):
        arduino1.scan()
    else:
        for l in arduinolist:
            l.scan()

#    pool = ThreadPool(len(arduinolist))
#    arduinolist = pool.map(call_scan, arduinolist)

# fifth version. Uses named pipes rather than serial comms!


