#!/usr/bin/python 
import socket
import sqlite3 as lite
import datetime
import time
import os
import re
import logging
import logging.handlers
import sys
import signal
import psutil
import traceback
from collections import defaultdict
# to install the three below:
# "pip install gspread; pip install oauth2client; pip install PyOpenSSL"
# install pip first if you don't have it, on windows just google "get-pip.py".
# on Mac OS use "easy_install pip"
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

PORT = 9999 # port number to watch
max_noreply_period = 60 #seconds
lastmax_timer = time.time() #initialize timer

max_command = ["/Applications/Max.app/Contents/MacOS/Max", "/Users/Aesir/Documents/Max\ 7/Library/velostat/dataLogging.maxpat"]

####################
# EXIT HANDLER
####################                

# upon exit, log exit msg, disconnect from sqlite and close sockets
def exit_func():
    server_socket.close()
    sys.exit(0)
    
# exits the program cleanly, logging exit time
def signal_handler(signal, frame):
    print ""
    exit_func()

signal.signal(signal.SIGINT, signal_handler)

def restart_max():
    import subprocess
    cmd = 'open -a %s --args %s' % (max_command[0], max_command[1])
    os.system(cmd)
#    subprocess.Popen(max_command)

def kill_max():

    import subprocess
    subprocess.call(["pkill", "Max"])

##################
# SOCKET SETUP
##################

if __name__ == "__main__":

    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_socket.bind(("0.0.0.0", PORT))
        server_socket.settimeout(1.0)
    except socket.error, e:
        print "socket error: %s" % e
        
    print "started"
    #######################
    # MAIN LOOP
    #######################
    while 1:
        try:
#            print "time " + str(time.time())
            if (time.time() - lastmax_timer > max_noreply_period):
                print "Can't contact Max. Kill and restart" 
                kill_max()
                time.sleep(10)
                restart_max()
                lastmax_timer = time.time()
            time.sleep(1)
            data, address = server_socket.recvfrom(1024)
            #print data
            if (data):
                lastmax_timer = time.time()
                print "got data %s" % data
        except socket.timeout:
#            print "socket timeout"
            continue
        except Exception, e:
            print "oops error"
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
