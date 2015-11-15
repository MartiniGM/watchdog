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
from time import sleep
import subprocess
import traceback

##############################
# INSTRUCTIONS 
##############################
# To monitor programs on linux or mac os: run "ps aux", find your process in the list, and then cut-n-paste it like so:
# ps aux 
#...
# root      2156  0.0  0.1   3808  1760 ?        Ss   18:08   0:00 /usr/sbin/cron
# pi        2201  0.0  0.0   3352   880 ?        S    18:08   0:00 /home/pi/RUNNING/builds/piezo
# pi        2202  1.7  0.8  10868  7872 ?        S    18:08   0:04 /usr/bin/python /home/pi/RUNNING/scripts/watchdog.py
# pi        2203  0.5  0.6  17112  6328 ?        Sl   18:08   0:01 /usr/bin/python /home/pi/RUNNING/scripts/do-audio.py
# pi        2204  0.0  0.0   3348   908 ?        S    18:08   0:00 /home/pi/RUNNING/builds/laser
#...
# Copy the last part of the output above for the program you want to monitor, and paste it below like so:
# softwarelist.append("/home/pi/RUNNING/builds/piezo")
# softwarelist.append("/home/pi/RUNNING/builds/laser")
# Then just save this file and run it ("python /path/to/watchdog.py &")!
#
# on Windows:
# Hit ctrl-alt-del and choose Task Manager, then look on the Applications tab to find the program name.
# Then copy/paste or enter it as shown:   
# softwarelist.append("Max.exe")
# softwarelist.append("NV-DVR.exe")
# Then just save this file and run it (run "cmd" to get a command window, then enter "python /path/to/watchdog.py")!
#

##############################
# ADD MONITORED SOFTWARE HERE
##############################
softwarelist = []
softwarelist.append("/home/pi/RUNNING/builds/piezo")
softwarelist.append("/home/pi/RUNNING/builds/laser")
softwarelist.append("/home/pi/RUNNING/builds/chest")
softwarelist.append("/home/pi/RUNNING/scripts/do-audio.py")

####################
# GLOBALS & SETTINGS
####################

send_ok_period = 30 #sends ERRPI_ACKCLEAR every 30s
send_ok_timer = time.time()
send_ok_timer_pi = time.time()
send_ok_timer_software = time.time()

#stuff for the remote reboot feature 
incoming_socket_timer = time.time() #initialize timer for remote restart msgs
reboot_timer = time.time() #initialize timer
incoming_socket_period = 5 #checks for msg on incoming socket every 5 seconds
reboot_in = 0 #if this is not zero, reboot the machine in N seconds
PORT = 6666 #UDP port to listen for reboot commands
data = ""

# change to 0 to turn off outgoing socket messages (to the TCP watchdog server)
USE_SOCKETS = 1

# set TCP watchdog IP and port here
host = '10.42.16.17'
remote_ip = ""
this_ip = ""
port = 6666

# creates a socket up-front, just to initialize it 
if (USE_SOCKETS):
    #create an INET, STREAMing socket
    try:
        watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
        print 'Failed to create outgoing socket: %s' % e

    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_socket.setblocking(0)
        server_socket.bind(("0.0.0.0", PORT))
#        server_socket.settimeout(SOCKET_TIMEOUT)
    except socket.error as e:
        print 'Failed to create incoming socket: %s' % e
            
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
# rebootscript()
############################################################
#causes the machine to reboot. You better be sure! :3
def rebootscript():
    print "rebooting system!"
    try:
        if sys.platform == 'linux' or sys.platform == 'linux2':
            import subprocess
            command = "sudo /sbin/reboot"
            subprocess.call(command, shell = True)
        else:
            if os.name == 'nt':
            #this gives people 30 seconds to log off/close programs,
            #then forces a reboot
                import subprocess
                subprocess.call(["shutdown", "-r", "-f", "-t", "30"])
            else:
            #not Linux or Windows so it's probably Mac OS X
                import subprocess
                subprocess.call(['osascript', '-e',
                                 'tell app "System Events" to shut down'])
    except Exception, e:
        print "Couldn't reset system: %s" % e

############################################################
# parse_reboot_command()
############################################################
# takes a string, parses it for commands like:
# "reboot now"
# or
# "reboot in N [second|seconds|minute|minutes]"
# calls rebootscript() to reboot the machine if the command is valid
def parse_reboot_command(data):
    global reboot_in
    try:
    # at this point we got data, so do something with it
        if ("reboot now" in data):
            rebootscript()
        else:
            if ("reboot" in data):
                    #reboot in X seconds
                datas = data.split()
                print datas
                if len(datas) < 3:
                    print "Bad msg format, should be 'reboot now' or 'reboot in X [seconds|minutes]'"
                    print "too short!"
                    return
                if "reboot" not in datas[0]:
                    print "Bad msg format, should be 'reboot now' or 'reboot in X [seconds|minutes]'"
                    print "didn't see 'reboot' in %s" % datas[0]
                    return
                if "in" not in datas[1]:
                    print "Bad msg format, should be 'reboot now' or 'reboot in X [seconds|minutes]'"
                    print "didn't see 'in' in %s" % datas[1]
                    return
                time_val = float(datas[2]) 
#                print "time: " + str(time_val)
                resolution = datas[3]
                if "seconds" in resolution:
                    print "wait for %s seconds, then reboot..." % str(time_val)
                    reboot_in = time_val
                else:
                    if "minute" in resolution:
                        print "wait for %s minutes, then reboot..." % str(time_val)
                        reboot_in = (time_val * 60)
                    else:
                        print "unknown time resolution. sleep %s seconds, then reboot..." % time_val
                        reboot_in = (time_val)
            else:
                print "Unknown command"
    except Exception, e:
        print "error in parse_reboot_command"
        
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
        except socket.error as e:
            print 'Failed to create socket: %s' % e
            return 0
        else:
            print ('Socket created. Messages will be sent to: ' + remote_ip),
            sys.stdout.flush()
            return 1

############################################################
# print_startup_message()
############################################################
# prints the ID name of every device to be monitored, so the user can copy it to the Master Doc
def print_startup_message(software_list):
    global this_ip
    print "Now monitoring:"
    print this_ip
    for (proc_name) in software_list:
        if (proc_name[0] == '/'):
            print this_ip + str(proc_name)
        else:
            print this_ip + "/" + str(proc_name)

############################################################
# send_ok_now()
############################################################ 
# this sends an OK message (ERRDUINO_ACKCLEAR or ERRPI_ACKCLEAR) via TCP
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
# Receives "reboot in X [seconds | minutes] messages from Max or the server
def pi_scan():
    global send_ok_timer_pi
    global send_ok_period
    global reboot_in
    global reboot_timer
    sleep(0.005) #otherwise it eats every CPU :3
     #delete/tweak this if you're getting lag
    
    try:
        if reboot_in != 0:
            if (time.time() - reboot_timer > reboot_in):
                print "rebooting"
                reboot_in = 0
                reboot_timer = time.time()
                rebootscript()
    except Exception, e:
        print "timing/reboot error %s" % e
        
    try:
        if (time.time() - send_ok_timer_pi > send_ok_period + 30):
            send_ok_now("PI", "ERRPI_ACKCLEAR", "")
            send_ok_timer_pi = time.time()
    except Exception, e:
        print "FAILURE in pi_scan! %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
    try:
        data = ""
        r,w,x = select.select([server_socket],[],[],0)
        if server_socket in r:
            data, address = server_socket.recvfrom(1024)
            if (data):
                print "-----Server (%s) connected, sent %s" % (address, data)
            #######################
            # DATA RECEIVED
            #######################
                parse_reboot_command(data)
    except socket.timeout:
        return
    except Exception, e:
        print "FAILURE in pi_scan for server socket! %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
    
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
             for (proc_name) in software_list:
                 #print "Scanning " + proc_name 
                 if (process_exists(proc_name)):
                    # print "Exists!"
                     send_ok_now("PI", "ERRPI_ACKCLEAR", proc_name)
                 else:
                     send_ok_now("PI", "ERRPI_NOREPLY", proc_name)
#                     print proc_name + " is down!"
             send_ok_timer_software = time.time()
     except Exception, e:
         for frame in traceback.extract_tb(sys.exc_info()[2]):
             fname,lineno,fn,text = frame
             print "     in %s on line %d" % (fname, lineno)
             print "Error in software_scan(): %s" % e

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

this_ip = get_ip_address('eth0')
print "from: " + this_ip
sys.stdout.flush()

print_startup_message(softwarelist)

while 1:
    pi_scan()
    software_scan(softwarelist)
    print_startup_message = 0

# eighth version. removed serial2pipe, improved output
