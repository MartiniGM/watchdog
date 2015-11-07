#!/usr/bin/python
import subprocess
import socket
from time import sleep
from select import select
import sys
import signal 
import time

PORT = 6666 # port number to watch
SOCKET_TIMEOUT = .005 # timeout in seconds
periodic_timer = time.time() #initialize timer
reboot_timer = time.time() #initialize timer
incoming_socket_timer = time.time() #initialize timer
periodic_period = 1
incoming_socket_period = 5
reboot_in = 0
data = ""
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

def rebootscript():
    if sys.platform == 'linux' or sys.platform == 'linux2':
        print "rebooting system"
        command = "sudo /sbin/reboot"
        subprocess.call(command, shell = True)
    else:
        print "platform not yet supported"

def parse_reboot_command(data):
    global reboot_in
    try:
    # at this point we got data, so do something with it
        if ("reboot now" in data):
            print "reboot rec'd"
            rebootscript()
        else:
            if ("reboot" in data):
                    #reboot in X seconds
                datas = data.split()
                print datas
                if len(datas) < 3:
                    print "too short!"
                    print "Badly formatted message?"
                    return
                if "reboot" not in datas[0]:
                    print "didn't see 'reboot' in %s" % datas[0]
                    print "Badly formatted message?"
                    return
                if "in" not in datas[1]:
                    print "didn't see 'in' in %s" % datas[1]
                    print "Badly formatted message?"
                    return
                time_val = float(datas[2]) 
                print "time: " + str(time_val)
                resolution = datas[3]
                if "seconds" in resolution:
                    print "sleep %s seconds, then reboot..." % str(time_val)
                    reboot_in = time_val
                else:
                    if "minute" in resolution:
                        print "sleep %s minutes, then reboot..." % str(time_val)
                        reboot_in = (time_val * 60)
                    else:
                        print "unknown resolution. sleep %s seconds, then reboot..." % time_val
                        reboot_in = (time_val)
            else:
                print "Unknown command"
    except Exception, e:
        print "error in parse_reboot_command"

if __name__ == '__main__':
     ##################
    # SOCKET SETUP
    ##################
    
    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_socket.setblocking(0)
        server_socket.bind(("0.0.0.0", PORT))
        server_socket.settimeout(SOCKET_TIMEOUT)
        input = [server_socket]
    except socket.error, e:
        print "socket error: %s" % e

    while 1:
        try:
            if (time.time() - periodic_timer > periodic_period):
                print "."
                if (reboot_in != 0):
                    if (time.time() - reboot_timer > reboot_in):
                        print "rebooting"
                        reboot_in = 0
                        rebootscript()
                periodic_timer = time.time()
        except Exception, e:
            print "timing/reboot error %s" % e
        try:
            sleep(0.005) #otherwise it eats every CPU :3
#            if (time.time() - incoming_socket_timer > incoming_socket_period):
#                incoming_socket_timer = time.time()
#                print "before udp check"
#                data, address = server_socket.recvfrom(1024)
#                print "after udp check"
#                print data

            data = ""
            r,w,x = select([server_socket],[],[],0)
            if server_socket in r:
                data, address = server_socket.recvfrom(1024)
            if (data):
                print "-----Client (%s) connected, sent %s" % (address, data)
            #######################
            # DATA RECEIVED
            #######################
                parse_reboot_command(data)
            else:
                continue
        except socket.timeout:
            continue


