#!/usr/bin/python
import socket 
import sys
import os, re
import time
import signal
import select
import datetime
import struct
from time import sleep
import subprocess
import traceback

# set TCP watchdog IP and port here
host = '10.42.16.17'
# set this machine's default IP in case the network goes down & it forgets :l  
this_default_ip = "10.42.34.14"

msg_to_send = "NONRESPONSIVE" # messages should be "OKAY" or "NONRESPONSIVE"
this_ups = "ups1" # ID to send
remote_ip = ""
this_ip = ""
port = 6666
USE_SOCKETS = 1

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
        print( "error getting uptime, %s" % e)
        return ("", 0)

############################################################
# send_ok_now()
############################################################ 
# this sends an OK message (ERRDUINO_ACKCLEAR or ERRPI_ACKCLEAR) via UDP
# moved this up because for now watchdog.py doesn't send OK msgs for
# connected devices -- serial2pipe does that
def send_ok_now(pi_or_arduino, status, append_string):
    global this_ip

    print ('.'),
    sys.stdout.flush()
    if (USE_SOCKETS):
        try:
            if (pi_or_arduino == "PI"):
                ip = this_ip
                uptime_string , uptime_seconds = get_uptime()
                if (len(str(append_string)) == 0):
                    message = status + " " + ip + " " + str(uptime_seconds) + " " + str(uptime_string)                         
                else:
                    if append_string[0] != '/':
                        message = status + " " + ip + "/" + str(append_string) + " " + str(uptime_seconds) + " " + str(uptime_string)
                    else:
                        message = status + " " + ip + str(append_string) + " " + str(uptime_seconds) + " " + str(uptime_string)
                watchsock.sendto(message, (remote_ip, port))
        except socket.error as e:
            print( "Send failed! %s" % e)
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
            print( "failed to send %s " % e)
                 #put retry here

############################################################
# get_ip_address()
############################################################
# gets IP address of eth0 as a string
def get_ip_address(ifname):
    try:
        if os.name == 'nt':
            import socket
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
        print ("error in get_ip_address: %s" % e)
        return this_default_ip

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
        except socket.error as e:
            print( 'Failed to create socket: %s' % e)
            return 0
        else:
            print ('Socket created. Messages will be sent to: ' + remote_ip),
            sys.stdout.flush()
            return 1
    
###################################
# main() 
###################################  
                 
this_ip = get_ip_address('eth0')
socket_connect()
#sends a trio of messages via UDP, either OKAY or NONRESPONSIVE
send_ok_now("PI", msg_to_send, this_ups)
time.sleep(1)
send_ok_now("PI", msg_to_send, this_ups)
time.sleep(1)
send_ok_now("PI", msg_to_send, this_ups)
time.sleep(1)
