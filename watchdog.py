#!/usr/bin/python
import serial
from sys import exit
import os, fcntl
import time
import signal
import time    
import select
from contextlib import contextmanager
from multiprocessing.dummy import Pool as ThreadPool 
from time import sleep
 
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
        try:
            self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
        except Exception, e:
            print "Failed to open %s!" % self.port

    def openPort(self):
        if (self.not_open):
            try:
                self.pipein = os.open(self.port, os.O_RDONLY | os.O_NONBLOCK)
            except Exception, e:
                print "Failed to open %s!" % self.port
            else:
                self.not_open = 0;

    def watchdog(self):
        #print("Watchdog called on port " + self.port + " Time since last dog: " + str(time.time() - self.wdtimerstart))
        if (time.time() - self.wdtimerstart > self.dogtime):
            #for now, all this does is print. In future it'll write out to a 
            #Pi pin to cause the attached Arduino to reset.
            print("WATCHDOG ACTIVE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
            #reset code goes here
            self.wdtimerstart = time.time();

    def scan(self):
        while 1:
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
                    self.watchdog()
                    break
            #From here down, we got a read-success    
            self.set_failstart = 0  # clears the failure code in case we failed earlier 
            if (self.last_len != 0):
                print "Got data on port " + self.port + " in sec:" + str(time.time() - self.start) + " " + self.textln
                self.start = time.time()
            else: 
                 #print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
                #likewise, if it's been too long since we saw data, pop the watchdog
                 if (time.time() - self.start > self.wdtime):
                    self.watchdog()


print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

#use serial2pipe to split the Arduino output into two named pipes, then attach
#the following to one of the pipes, and the other to the program to be 
#monitored!

#                  input filename,             pin,timeout, wdtime, dogtime
arduino1 = Arduino("serial2pipe/watchdog_pipe", 1, 0.0, 10.0, 40.0)
#arduino1 = Arduino("/dev/arduino1", "/dev/pts/4", 1, 0.0, 10.0, 40.0)
arduino2 = Arduino("serial2pipe/watchdog_pipe2", 1, 0.0, 10.0, 40.0)
#arduino3 = None

# builds a list to step through the arduinos
arduinolist = []
arduinolist.append(arduino1)
arduinolist.append(arduino2)
#arduinolist.append(arduino3)

# this creates a thread pool and assigns each working loop its own thread.
print len(arduinolist)
if (len(arduinolist) == 1):
    arduino1.scan()
else:
    pool = ThreadPool(len(arduinolist))
    arduinolist = pool.map(call_scan, arduinolist)

# fifth version. Uses named pipes rather than serial comms!


