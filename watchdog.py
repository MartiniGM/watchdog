import serial
from sys import exit
import os
import time
import signal

#ensures we can kill the script with ctrl-C for testing
def signal_handler(signal, frame):
    print('Exiting...')
    os._exit(0) #dirty, but that gnarly try-except loop won't exit otherwise

signal.signal(signal.SIGINT, signal_handler)


class Arduino:
    
    def __init__(self, port, pin, timeout, wdtime, dogtime):

 #port: portname string (i.e. "/dev/arduino1", "/dev/ttyACM0")
 #pin: GPIO output pin number to connect to Arduino reset (i.e. 1, 20)
 #timeout: seconds to serial timeout. set to 0 for non-blocking. 1 seems to work
 #wdtime: seconds to firing watchdog (i.e. 10.0)
 #dogtime: seconds between subsequent watchdogs, to prevent reset loops (60)
 
        print "new Arduino object with port: " + port + " pin: " + str(pin) + " serial timeout: " + str(timeout) 
        print "                        watchdog sec: " + str(wdtime) + " watchdog timeout: " + str(dogtime)
        self.port = port
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

    def watchdog(self):
        print("Watchdog called on port " + self.port + " Time since last dog: " + str(time.time() - self.wdtimerstart))
        if (time.time() - self.wdtimerstart > self.dogtime):
            print("WATCHDOG ACTIVE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
            #reset code goes here
            self.wdtimerstart = time.time();

    def scan(self):
        try:
            #try block creates, opens, and reads serial. if any failures, retry.
            self.ser = serial.Serial(self.port, 9600)
            self.ser.timeout = self.timeout
            self.ser.open()
            self.textln = self.ser.read(100)
        except:
            print "warning: SERIAL FAILURE!!"
            if (self.set_failstart == 0):
                self.failstart = time.time() # records time of failure
                self.set_failstart = 1 
    # ^ sets a failure code to keep from rewriting the failure time over & over
            try:
                self.ser.open()
            except:
                print "warning: still can't re-open serial port. retrying..."
            if (time.time() - self.failstart > self.wdtime):
                # if it's been so long since serial failure, pop the watchdog
                self.watchdog()
        self.set_failstart = 0  # clears the failure code in case we failed earlier 
        if (len(self.textln) != 0):
            print "Got data on port " + self.port + " in sec:" + str(time.time() - self.start) + " " + self.textln
            self.start = time.time()
        else: 
           # print "Warning! no data on port " + self.port + " in sec: " + str(time.time() - self.start)
            if (time.time() - self.start > self.wdtime):
               self.watchdog()
        try:
            self.ser.close()
        except:
            pass

print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

 # build a list to step through the arduinos
arduino1 = Arduino("/dev/arduino1", 1, 1.0, 10.0, 40.0)
arduino2 = Arduino("/dev/arduino2", 2, 1.0, 10.0, 40.0)
arduino3 = None
arduinolist = []
arduinolist.append(arduino1)
arduinolist.append(arduino2)
arduinolist.append(arduino3)

while 1:

    for count in xrange(3): 
        if arduinolist[count] != None:
            arduinolist[count].scan()

 #I didn't give each arduino its own thread, so each object blocks for the
 #given timeout during scan()... but given the amount of time before 
 #we'll want to reboot (minutes, most likely!) serial timeouts should be OK.
 #At 1 sec timeout it'll poll 3 Arduinos, each patting every 4 sec, etc... if we
 #decide we want to use large pat times (1 min or more), threads may be needed
