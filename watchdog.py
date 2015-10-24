#!/usr/bin/python
import serial
import socket 
import sys
import os, re
import time
import signal
import time    
import select
import datetime
import struct
#from contextlib import contextmanager
#from multiprocessing.dummy import Pool as ThreadPool 
from time import sleep
import subprocess
import traceback

####################
# GLOBALS & SETTINGS
####################

send_ok_period = 30 #sends ERRPI_ACKCLEAR every 30s
send_ok_timer = time.time()
send_ok_timer_pi = time.time()
send_ok_timer_software = time.time()

# comment this to turn socket messages (to the TCP watchdog server) off 
USE_SOCKETS = 1

# set TCP watchdog IP and port here
host = '10.42.16.222'
remote_ip = ""
this_ip = ""
port = 6666

# creates a socket up-front, just to initialize it 
if (USE_SOCKETS):
    #create an INET, STREAMing socket
    try:
            watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
            print 'Failed to create socket: %s' % e

####################
# EXIT HANDLER
####################
# ensures we can kill the script with ctrl-C for testing
def signal_handler(signal, frame):
    print('Exiting...')
    watchsock.close()
    os._exit(0) 

signal.signal(signal.SIGINT, signal_handler)
            
####################
# FUNCTIONS
####################

############################################################
# get_ip_address()
############################################################
# gets IP address of eth0 as a string
def get_ip_address(ifname):
    try:
        if os.name == 'nt':
#        hostname = socket.gethostname()
#        IP = socket.gethostbyname(hostname)
#        print IP
#        return(IP)
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(('8.8.8.8', 0))  # connecting to a UDP address doesn't send packets
            local_ip_address = s.getsockname()[0]
            #        print local_ip_address
            return local_ip_address
        else:
            if sys.platform == 'linux' or sys.platform == 'linux2':
                import fcntl
                import socket
                s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
                return socket.inet_ntoa(fcntl.ioctl(
                        s.fileno(),
                        0x8915,  # SIOCGIFADDR
                        struct.pack('256s', ifname[:15])
                        )[20:24])
            else: #mac os probably
                import socket
                local_ip_address = socket.gethostbyname(socket.gethostname())
            #            print local_ip_address
                return local_ip_address
    except Exception, e:
        print "error in get_ip_address: %s" % e
        return ""

############################################################
# get_uptime()
############################################################
# returns this Pi's uptime in seconds and as formatted string
def get_uptime():
    try:
        if sys.platform == 'linux' or sys.platform == 'linux2':
            with open('/proc/uptime', 'r') as f:
                uptime_seconds = float(f.readline().split()[0])
                uptime_string = str(datetime.timedelta(seconds = uptime_seconds))
                uptime_string = uptime_string.split('.')[0]
                #            print "UPTIME STR: " + uptime_string
                return (uptime_string, uptime_seconds)
        else:
            if os.name == 'nt':
                import win32api
                uptime_seconds = win32api.GetTickCount() / 1000
                uptime_string = str(datetime.timedelta(seconds = uptime_seconds))
                uptime_string = uptime_string.split('.')[0]
                #print uptime_string
                return (uptime_string, uptime_seconds)
            else: # mac os probably
                output = subprocess.check_output(['sysctl', '-n', 'kern.boottime']).strip()
                boottime = re.search('sec = (\d+),', output).group(1)
                uptime_seconds = datetime.timedelta(seconds=float(boottime)).seconds
#                print uptime_seconds
                uptime_string = str(datetime.timedelta(seconds = uptime_seconds))
                uptime_string = uptime_string.split('.')[0]
#                print uptime_string
                return (uptime_string, uptime_seconds)
    except Exception, e:
        print "error getting uptime, %s" % e 
        return ("", 0)

############################################################
# socket_connect()
############################################################   
# connects to the TCP watchdog. See host/port above. Run in a loop to retry
def socket_connect():
    global watchsock
    global host
    global remote_ip
    global port
    global this_ip
    if (USE_SOCKETS):
        try:
            watchsock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
            remote_ip = socket.gethostbyname( host )
            this_ip = get_ip_address('eth0')
            print "send from " + this_ip
        except socket.error as e:
            print 'Failed to create socket: %s' % e
            return 0
        else:
            print 'Socket created: ' + host + ' on ip ' + remote_ip
            return 1

############################################################
# send_ok_now()
############################################################ 
# this sends an OK message (ERRDUINO_ACKCLEAR or ERRPI_ACKCLEAR) via TCP
# moved this up because for now watchdog.py doesn't send OK msgs for
# connected devices -- serial2pipe does that
def send_ok_now(pi_or_arduino, status, append_string):
    global this_ip
    if (USE_SOCKETS):
        try:
            if (pi_or_arduino == "PI"):
                ip = this_ip
                uptime_string , uptime_seconds = get_uptime()
                if (len(str(append_string)) == 0):
                    message = status + " " + ip + " " + str(uptime_seconds) + " " + str(uptime_string)                         
                else:
                    message = status + " " + ip + "/" + str(append_string) + " " + str(uptime_seconds) + " " + str(uptime_string)
                print message
                watchsock.sendto(message, (remote_ip, port))
        except socket.error as e:
            print "Send failed! %s" % e
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
                if (status == 1):
                    print message
                    watchsock.sendto(message, (remote_ip, port))
                else:
                    print "failed to send"
                 #put retry here
        except IOError as e:
            print "failed to send %s " % e
                 #put retry here
        
############################################################
# process_exists()
############################################################   
# returns True if this process is running, False if not.
def process_exists(proc_name):
    if (os.name != 'nt'):
#linux or mac type
        ps = subprocess.Popen("ps ax -o pid= -o args= ", shell=True, stdout=subprocess.PIPE)
        ps_pid = ps.pid
        output = ps.stdout.read()
        ps.stdout.close()
        ps.wait()

        for line in output.split("\n"):
            res = re.findall("(\d+) (.*)", line)
            if res:
                pid = int(res[0][0])
                if proc_name in res[0][1] and pid != os.getpid() and pid != ps_pid:
                    return True
        return False
    else:
#windowsish
        import wmi
        c = wmi.WMI ()

        for process in c.Win32_Process ():
            #print process.ProcessId, process.Name
            if proc_name in process.Name:
                return True
        return False

############################################################
# pi_scan()
############################################################
# Sends OKAY messages every N seconds for this Pi/PC
def pi_scan():
     global send_ok_timer_pi
     global send_ok_period
     sleep(0.005) #otherwise it eats every CPU :3
     #delete/tweak this if you're getting lag
     try:
         if (time.time() - send_ok_timer_pi > send_ok_period + 30):
             send_ok_now("PI", "ERRPI_ACKCLEAR", "")
             send_ok_timer_pi = time.time()
     except Exception, e:
         for frame in traceback.extract_tb(sys.exc_info()[2]):
             fname,lineno,fn,text = frame
             print "     in %s on line %d" % (fname, lineno)
         print "FAILURE in pi_scan! %s" % e

############################################################
# software_scan()
############################################################
# checks software on this Pi or PC, sends OKAY or NONRESPONSIVE
def software_scan(software_list):
     global send_ok_timer_software
     global send_ok_period
     sleep(0.005) #otherwise it eats every CPU :3
     try:
         if (time.time() - send_ok_timer_software > send_ok_period + 15):
             for (proc_name, proc_path ) in software_list:
                 print "Scanning " + proc_name 
                 if (process_exists(proc_name)):
                     print "Exists!"
                     send_ok_now("PI", "ERRPI_ACKCLEAR", proc_name)
                 else:
                     send_ok_now("PI", "ERRPI_NOREPLY", proc_name)
                     print "Is Down!"
             send_ok_timer_software = time.time()
     except Exception, e:
         for frame in traceback.extract_tb(sys.exc_info()[2]):
             fname,lineno,fn,text = frame
             print "     in %s on line %d" % (fname, lineno)
             print "Error in software_scan(): %s" % e

############################################################
# class Arduino:
############################################################        
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
            if os.name != 'nt':
                self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
            else:
                self.pipein = os.open(self.port, os.O_RDONLY)
        except Exception, e:
            print "Failed to open %s : %s!" % (self.port, e)

####################
# openPort()
####################  
# this opens the named pipe
    def openPort(self):
        if (self.not_open):
            try:
                if os.name != 'nt':
                    self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
                else:
                    self.pipein = os.open(self.port, os.O_RDONLY)           
            except Exception, e:
                print "Failed to open %s : %s!" % (self.port, e)
            else:
                self.not_open = 0;

####################
# watchdog()
####################   
# this sends the watchdog message (errcode) via TCP
    def watchdog(self, errcode):
        global this_ip
#        print("Watchdog called on port " + self.port + " Time since last dog: " + str(time.time() - self.wdtimerstart))
        if (time.time() - self.wdtimerstart > self.dogtime):
            self.wdtimerstart = time.time();
            self.send_ok = 1; #this tells the watchdog to send an ACKCLEAR
                              #on the next good read
            uptime_string, uptime_seconds = get_uptime()
            print("^^^^^WATCHDOG ACTIVE^^^^^:"+ os.path.basename(self.port) + " " + str(uptime_seconds) + " " + uptime_string)
#str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S")))
            if (USE_SOCKETS):
                try:
                    ip = this_ip
                    message = errcode + " " + ip + "/" + os.path.basename(self.port) + " " + str(uptime_seconds) + " " + uptime_string
                    print message
                    watchsock.sendto(message, (remote_ip, port))
                except socket.error as e:
                    # tries to reconnect every time round the loop
                    print "Send failed! %s" % e
                    try:
                        if (status == 1):
                            print message
                            watchsock.sendto(message, (remote_ip, port)) 
                        else:
                            print "failed to send 1" + message
                    except Exception, e:
                        # tries to reconnect every time round the loop
                        print "Send failed! %s" % e

####################
# scan()
####################                          
# this is the main scan loop for each arduino. Gets data over the pipe, and 
# either resets the watchdog timer due to good data, or waits til it expires
# and triggers the watchdog.
    def scan(self):
            global send_ok_timer
            global send_ok_timer_pi
            global send_ok_period
            sleep(0.005) #otherwise it eats every CPU :3
                         #delete/tweak this if you're getting lag
            try:
# try block creates, opens, and reads serials. if any failures, retry.
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
                        if (len(self.textln) != 0):
                        #sends the OK message for the connected Arduino
#                            if (self.send_ok == 1):
#                                print "timer " + str(time.time() - self.send_ok_timer) + " period " + str(send_ok_period)
#                                if (time.time() - self.send_ok_timer > send_ok_period):
#                                    self.send_ok_now("ARDUINO")
#                                    self.send_ok_timer = time.time()
#                                    self.send_ok = 0;
                            self.last_len = len(self.textln)
                        else:
                            self.last_len = 0
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
#                    self.watchdog("ERRDUINO_DISCON")
#                    DISCON isn't used now so change this to BROKENPIPE
                    self.watchdog("ERRDUINO_BROKENPIPE")

            #From here down, we got a read-success    
            self.set_failstart = 0  # clears the failure code in case we failed earlier 
            if (self.last_len != 0):
#                print "Got data on port " + os.path.basename(self.port) + " in sec:" + str(time.time() - self.start).split('.')[0] + "  " + self.textln 
                self.start = time.time()
                if (USE_SOCKETS):
                #sends ERRPI_ACKCLEAR every X seconds
                    if (time.time() - send_ok_timer_pi > send_ok_period + 30):
                        send_ok_now("PI", "ERRPI_ACKCLEAR", "")
                        send_ok_timer_pi = time.time()
            else: 
                    # because the Pi itself is still up even when its arduinos are not, we need to duplicate this here or we will never hear back from the pi is all arduinos are down
                if (time.time() - send_ok_timer_pi > send_ok_period + 30):
                    send_ok_now("PI", "ERRPI_ACKCLEAR", "")
                    send_ok_timer_pi = time.time()
                 #print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
                #likewise, if it's been too long since we saw data, pop the watchdog
                if (time.time() - self.start > self.wdtime):
                    self.watchdog("ERRDUINO_NOREPLY")

###################################
# main() - main scan loop
###################################     

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

# builds a list to step through the arduinos.
# Leave this list blank (as below) to monitor only this Pi.
arduinolist = []
arduino1 = Arduino("./watchdog_pipe1", 1, 0.0, 40.0, 100.0)
arduino2 = Arduino("./watchdog_pipe2", 1, 0.0, 40.0, 100.0)
#arduino3 = Arduino("./chest_wd_pipe", 1, 0.0, 40.0, 100.0)
arduinolist.append(arduino1)
arduinolist.append(arduino2)
#arduinolist.append(arduino3)

# builds a list to step through the software on this Pi.
# Leave this list blank to skip software monitoring.
softwarelist = []
softwarelist.append(("GV-VMS.exe", ""))
softwarelist.append(("Max.exe", ""))

while 1:
    # if there's nothing connected we still want to monitor this Pi or PC. send OKAY every N seconds.
    if (len(arduinolist) == 0):
        pi_scan()
    # otherwise go through the list and monitor each connected arduino.
    else:
        if (len(arduinolist) == 1):
            arduino1.scan()
        else:
            for l in arduinolist:
                l.scan()

    #same for the list of software. treat software just like a device!
    software_scan(softwarelist)

# seventh version. sends UDP messages
