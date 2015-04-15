import serial
from sys import exit
import os
import time
import signal
import time    
from contextlib import contextmanager
from multiprocessing.dummy import Pool as ThreadPool 
from time import sleep

# ensures we can kill the script with ctrl-C for testing
# I took this out because once I added pool.map() it just WILL NOT DIE. 
# kill -9 it...

#def signal_handler(signal, frame):
#    print('Exiting...')
#    os._exit(0) 

#signal.signal(signal.SIGINT, signal_handler)


#wrapper function to pass into pool.map()
def call_scan(obj): 
    obj.scan ()
    return obj

class Arduino:
    
    def __init__(self, port, outport, pin, timeout, wdtime, dogtime):

 # port: input portname string, from Arduino (i.e. "/dev/arduino1", "/dev/ttyACM0", "/dev/pts/4")
 # outport: output portname string, to Max etc (i.e. "/dev/arduino1", "/dev/ttyACM0", "/dev/pts/5")
 # pin: GPIO output pin number to connect to Arduino reset (i.e. 1, 20)
 # timeout: seconds to serial timeout. set to 0 for non-blocking.
 # wdtime: seconds to firing watchdog (i.e. 10.0)
 # dogtime: seconds between subsequent watchdogs, to prevent reset loops (60)
 
        print "new Arduino object with port: " + port + " pin: " + str(pin) + " serial timeout: " + str(timeout) 
        print "                        watchdog sec: " + str(wdtime) + " watchdog timeout: " + str(dogtime)
        self.port = port
        self.outport = outport
        self.pin = pin
        self.timeout = timeout
        self.wdtime = wdtime
        self.dogtime = dogtime
        self.start = time.time()
        self.failstart = time.time()
        self.wdtimerstart = time.time()
        self.set_failstart = 0
        self.port_opened = 0
        self.textln = ""
        self.ser = serial.Serial()
        self.outser = serial.Serial()

    def openOutPort(self):
        if (self.outser.isOpen() == False):
            self.outser.baudrate = 9600
            self.outser.port = self.outport
            self.outser.timeout = self.timeout
            try:
                self.outser.open() 
            except Exception, e:
                print "Failed to open port " + self.outport + " : %s" % e       

    def openPort(self):
        if (self.ser.isOpen() == False):
            self.ser.baudrate = 9600
            self.ser.port = self.port
            self.ser.timeout = self.timeout
            try:
                self.ser.open() 
            except Exception, e:
                print "Failed to open port " + self.port + " : %s" % e

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
                self.openOutPort()
                self.textln = self.ser.read(1)
                if (len(self.textln) != 0):
                    print "write " + self.textln
                    self.outser.write(self.textln)
            except Exception, e:
                print "SERIAL FAILURE! %s" % e
                self.ser.close()
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
            if (len(self.textln) != 0):
                print "Got data on port " + self.port + " in sec:" + str(time.time() - self.start) + " " + self.textln
                self.start = time.time()
            else: 
                # print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
                #likewise, if it's been too long since we saw data, pop the watchdog
                if (time.time() - self.start > self.wdtime):
                    self.watchdog()


print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

# builds a list to step through the arduinos
# use "socat -d -d PTY: PTY:" twice, then attach the other end to (or use cat)
# "/dev/pts/5" and "/dev/pts/7" to listen in on the other end of these 
# virtual ports. See attached "watch_serial.sh" script.

#                  input port, output port, pin, timeout, wdtime, dogtime
arduino1 = Arduino("/dev/arduino1", "/dev/pts/4", 1, 0.0, 10.0, 40.0)
arduino2 = Arduino("/dev/arduino2", "/dev/pts/6", 2, 0.0, 10.0, 40.0)
#arduino3 = None
arduinolist = []
arduinolist.append(arduino1)
arduinolist.append(arduino2)
#arduinolist.append(arduino3)

# this creates a thread pool and assigns each working loop its own thread.
print len(arduinolist)
pool = ThreadPool(len(arduinolist))
arduinolist = pool.map(call_scan, arduinolist)

# fourth version. Now it's a wrapper which writes input as soon as it arrives.


