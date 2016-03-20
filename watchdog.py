#!/usr/bin/python
#import serial
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
import logging
import logging.handlers

##############################
# INSTRUCTIONS 
##############################
# ON LINUX / PIS:
# watchdog.py will autodetect programs added to crontab ("crontab -l" to list or "crontab -e" to edit). Add additional programs by hand below if you want (via "ps aux") like so:
# softwarelist.append("/home/pi/RUNNING/builds/piezo")
# softwarelist.append("/home/pi/RUNNING/builds/laser")
# Then just save this file and run it ("python /path/to/watchdog.py &")!
#
# OR ON WINDOWS:
# Hit ctrl-alt-del and choose Task Manager, then look on the Applications tab to find the program name.
# Then copy/paste or enter it as shown:   
# softwarelist.append("Max.exe")
# softwarelist.append("NV-DVR.exe")
#
#To monitor a UPS on linux or windows, enter the path to the UPS status (upcstatus.txt) file, like so:
#upslist = []
#upslist.append("/Users/Aesir/Documents/watchdog/tcp_watchdog_server/upcstatus.txt")
# Then just save this file and run it (run "cmd" to get a command window, then enter "python /path/to/watchdog.py")!
#

##############################
# ADD MONITORED SOFTWARE HERE. leave the list empty by default
##############################
softwarelist = []
#softwarelist.append("/home/pi/RUNNING/builds/piezo")
#softwarelist.append("/home/pi/RUNNING/builds/laser")
#softwarelist.append("/home/pi/RUNNING/builds/chest")
#softwarelist.append("/home/pi/RUNNING/scripts/do-audio.py")

#############################
# ADD UPS FILE (apcupsd.status) here. leave the list empty by default
#############################
upslist = []
#upslist.append("/var/log/apcupsd.status")

########################################################################
# SET HOST IP & OUR IP, plus msg send frequency and a filename for the log file
########################################################################
# set watchdog server's IP and port here
host = '10.42.16.17'
port = 6666
# set this machine's IP in case the network goes down & it forgets :l  
this_default_ip = "x.x.x.x"
send_ok_period = 30 #sends OKAY every N seconds

# give a filename for the watchdog's log file here
if os.name == 'nt':
    LOG_FILENAME = 'c:\watchdog\watchdog.out'
else:
    LOG_FILENAME = '/home/pi/RUNNING/scripts/watchdog.out'
LOCAL_LOG_FILENAME = 'watchdog.out' #if the above doesn't work, we'll use this

# give a filename for the optional software list file.
# file should have one line per piece of software to be monitored, like so:
# /home/pi/RUNNING/builds/piezo
# Max.exe
#
SOFTWARELIST_FILENAME = 'watchdog_softwarelist.txt'

##################################################################
# OTHER GLOBALS & SETTINGS (don't change these)
##################################################################

#initializes timers
send_ok_timer_pi = time.time()
send_ok_timer_software = time.time()
send_ok_timer_ups = time.time()

#stuff for the remote reboot feature 
reboot_timer = time.time() #initialize timer
reboot_in = 0 #if this is not zero, reboot the machine in N seconds
reboot_cmd = "" #either 'reboot' or 'halt'
PORT = 6666 #UDP port to listen for reboot commands
data = ""

# give the size for each rolling log segment, in bytes
LOG_SIZE = 2000000 #2 MB, in bytes
# give the number of rolling log segments to record before the log rolls over
LOG_NUM_BACKUPS = 2 # two .out files before they roll over

# change to 0 to turn off outgoing socket messages (to the UDP watchdog server)
USE_SOCKETS = 1

#variables for IP addresses
remote_ip = ""
this_ip = ""

# creates a socket up-front, just to initialize it 
if (USE_SOCKETS):
    #create an INET, STREAMing socket
    try:
        watchsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
        print( 'Failed to create outgoing socket: %s' % e )

    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_socket.setblocking(0)
        server_socket.bind(("0.0.0.0", PORT))

    except socket.error as e:
        print( 'Failed to create incoming socket: %s' % e )
            
####################
# EXIT HANDLER
####################
# ensures we can kill the script with ctrl-C for testing
def signal_handler(signal, frame):
    logger.info('Exiting...')
    watchsock.close()
    os._exit(0) 

signal.signal(signal.SIGINT, signal_handler)
            
####################
# FUNCTIONS
####################

####################
# setup_logger()
####################
# sets up circular error logging
def setup_logger():
    global logger
    # defines log levels for the log file. Default is 'info' and above.
    # Run program with "debug" on the command line for extra debugging output
    LEVELS = { 'debug':logging.DEBUG,
               'info':logging.INFO,
               'warning':logging.WARNING,
               'error':logging.ERROR,
               'critical':logging.CRITICAL,
               }

    # default log level is info (prints info, warning, error, etc).
    # run with "watchdog.py debug" to print/log debug messages
    if len(sys.argv) > 1:
        level_name = sys.argv[1]
        level = LEVELS.get(level_name, logging.NOTSET)
        logging.basicConfig(level=level)
    else:
        level = LEVELS.get('info', logging.NOTSET)
        logging.basicConfig(level=level)
    
    # creates our logger with the settings above/below
    logger = logging.getLogger('WDLog')
    try:
    # Add the log message handler to the logger. Creates a rolling/circular log
    # with LOG_NUM_BACKUPS backups, each of size LOG_SIZE bytes
        handler = logging.handlers.RotatingFileHandler(LOG_FILENAME,
                                                   maxBytes=LOG_SIZE,
                                                   backupCount=LOG_NUM_BACKUPS)
    except:
        handler = logging.handlers.RotatingFileHandler(LOCAL_LOG_FILENAME,
                                                       maxBytes=LOG_SIZE,
                                                       backupCount=LOG_NUM_BACKUPS)
        # sets the message & timestamp format for the log, if exception
        frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
        handler.setFormatter(frmt)
        logger.addHandler(handler)
    # sets the message & timestamp format for the log, normal completion
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
    handler.setFormatter(frmt)
    logger.addHandler(handler)

####################
# read_softwarelist_file()
####################
# reads the software list file (one line per software to be monitored).
# this ensures that 'git pull' won't clobber the custom software list.
def read_softwarelist_file():
    global softwarelist
    endl = os.linesep;
    try:
        if os.path.exists(SOFTWARELIST_FILENAME):
            try:
                with open(SOFTWARELIST_FILENAME, 'r') as infile:
                    for line in infile:
                        #don't include newline
                        softwarelist.append(line.rstrip(endl))
            except Exception, e:
                logger.warning( "optional softwarelist error: %s" % e, exc_info=True)
    except:
        logger.warning( "no optional softwarelist found? %s" % e, exc_info=True)   
####################
# autodetect_this_ip()
####################
#checks /etc/network/interfaces and gets the default ip address, if any
def autodetect_this_ip():
    global this_default_ip
    if sys.platform == 'linux' or sys.platform == 'linux2':
        try:
            command = ["cat", "/etc/network/interfaces"]
            p = subprocess.Popen(command, stdout=subprocess.PIPE)
            for line in p.stdout:
                line_entries = line.split()
                if len(line_entries) >= 1:
                    if line_entries[0] == "address":
                        if len(line_entries) >= 2:
                            this_default_ip = line_entries[1]
        except Exception, e:
            logger.error( "autodetect_this_ip error: %s" % e, exc_info=True)

####################
# autodetect_softwarelist()
####################       
def autodetect_softwarelist():
    #runs crontab -l, adds everything with "@reboot" to the monitored list
    #only autodetects on linux/pis -- set up PCs by hand.
    global softwarelist
    if sys.platform == 'linux' or sys.platform == 'linux2':
        try:
            command = ["crontab", "-l"]
            p = subprocess.Popen(command, stdout=subprocess.PIPE)
            for line in p.stdout:
                line_entries = line.split()
                #add program to monitored list if it starts at reboot
                if len(line_entries) >= 1:
                    if line_entries[0] == "@reboot":
                    #but don't add yourself
                        if len(line_entries) >= 2:
                            if "watchdog.py" not in line_entries[1]:
                        #and don't add duplicate entries
                                if line_entries[1] not in softwarelist:
                                    softwarelist.append(line_entries[1])

        except Exception, e:
            logger.error( "autodetect_softwarelist error: %s" % e, exc_info=True)

############################################################
# kill_proc and start_proc
############################################################
# starts or kills the specified program remotely.
# kill_proc takes a string to be passed to
# pkill -f, so it'll do pattern matching (warning: use with caution,
# pkill will kill ALL processes containing this string!)
# start_proc takes an exact program to be started, including full path

def kill_proc(process_name):
    try:
        if sys.platform == 'linux' or sys.platform == 'linux2': 
            os.system('pkill -f ' + process_name)
        else:
            if os.name == 'nt':
                os.system('taskkill /im ' + process_name)
    except Exception, e:
        print "error in kill-proc: can't kill %s: %s" % (process_name, e)

def start_proc(process_name):
    if sys.platform == 'linux' or sys.platform == 'linux2': 
        try:
        # preexec_fn=os.setsid, close_fds=True is the key to not killing the
        # process when the watchdog dies or is ctrl-c'd, and not letting
        # child processes hold onto the watchdog's own ports
            tmp_process = subprocess.Popen(process_name, preexec_fn=os.setsid, close_fds=True)
        except Exception, e:
            print "error in start-proc: can't start %s: %s" % (process_name, e)
    else:
        if os.name == 'nt':
            try:
        # preexec_fn=os.setsid, close_fds=True is the key to not killing the
        # process when the watchdog dies or is ctrl-c'd, and not letting
        # child processes hold onto the watchdog's own ports
                tmp_process = subprocess.Popen(process_name, close_fds=True)
            except Exception, e:
                print "error in start-proc: can't start %s: %s" % (process_name, e)
############################################################
# rebootscript()
############################################################
#causes the machine to reboot. You better be sure! :3
def rebootscript():
    global reboot_cmd
    if ("reboot" in reboot_cmd):
        logger.info( "rebooting system!" )
    else:
        if ("halt" in reboot_cmd):
            logger.info( "halting system!" )
    try:
        if sys.platform == 'linux' or sys.platform == 'linux2':
            import subprocess
            if ("reboot" in reboot_cmd): 
                command = "sudo /sbin/reboot"
            else:
                if ("halt" in reboot_cmd):
                    command = "sudo /sbin/poweroff"
                else:
                    logger.error("Didn't recognize %s in rebootscript" % reboot_cmd)
            subprocess.call(command, shell = True)
        else:
            if os.name == 'nt':
            #this gives people 15 seconds to log off/close programs,
            #then forces a reboot
                import subprocess
                if ("reboot" in reboot_cmd):
                    subprocess.call(["shutdown", "-r", "-f", "-t", "15", "-c", "MEOW WOLF"])
                else:
                    if ("halt" in reboot_cmd):
                        subprocess.call(["shutdown", "-s", "-f", "-t", "15", "-c", "MEOW WOLF"])
                    else:
                        logger.error("Didn't recognize %s in rebootscript" % reboot_cmd)
            else:
            #not Linux or Windows so it's probably Mac OS X
                import subprocess
                if ("reboot" in reboot_cmd):
                    subprocess.call(['osascript', '-e',
                                     'tell app "System Events" to restart'])
                    if ("halt" in reboot_cmd):
                        subprocess.call(['osascript', '-e',
                                         'tell app "System Events" to shut down'])
                    else:
                        logger.error("Didn't recognize %s in rebootscript" % reboot_cmd)
    except Exception, e:
        logger.error( "Couldn't reset system: %s" % e, exc_info=True )

############################################################
# parse_command()
############################################################
# takes a string, parses it for commands like:
# "reboot now" / "halt now"
# or
# "reboot/halt in N [second|seconds|minute|minutes]"
# or
# "kill_proc <process name string, to be passed to pkill -f>"
# or
# "start_proc <process name, including full path, to be started>"
#
# calls rebootscript() to reboot/halt the machine if a reboot command is valid
def parse_command(data):
    global reboot_in
    global reboot_timer
    global reboot_cmd
    print "got a command " + str(data)
    try:
    # at this point we got data, so do something with it
        if ("reboot now" in data or "halt now" in data):
            datas = data.split()
            reboot_cmd = datas[0]
            rebootscript()
        else:
            #processes the start_proc and kill_proc commands
            if ("start_proc" in data):
                datas = data.split()
                process_name = ""
                if len(datas) < 1:
                    print "Bad msg format, should be 'start_proc /path/to/looping-audio/sh'"
                    print "too short!"
                    return
                #adding this silences output & disconnects children from parent
                data2 = []
                for item in datas[1:]:
                    #rip out extra stuff from Max, if present
                    item = item.replace('\x00', '')
                    item = item.replace(',', '')
                    data2.append(item)
                process_name = data2
                logger.info( "starting: " + str(process_name))
                start_proc(process_name)
                return
            
            if ("kill_proc" in data):
                datas = data.split()
                process_name = ""
                if len(datas) < 1:
                    print "Bad msg format, should be 'kill_proc looping-audio'"
                    print "too short!"
                    return
                for item in datas[1:]:
                    process_name = process_name + item
                #rip out extra stuff from Max
                process_name = process_name.replace('\x00', '')
                process_name = process_name.replace(',', '')
                logger.info( "killing " + process_name)
                kill_proc(process_name)
                return
            if ("reboot" in data or "halt" in data):
                #reboot in X seconds
                datas = data.split()
                print datas
                if len(datas) < 3:
                    print "Bad msg format, should be 'reboot now' or 'reboot in X [seconds|minutes]'"
                    print "too short!"
                    return
                if "reboot" not in datas[0] and "halt" not in datas[0]:
                    print "Bad msg format, should be '[reboot|halt] now' or '[reboot|halt] in X [seconds|minutes]'"
                    print "didn't see 'reboot' or 'halt' in %s" % datas[0]
                    return
                if "in" not in datas[1]:
                    print "Bad msg format, should be '[reboot|halt] now' or '[reboot|halt] in X [seconds|minutes]'"
                    print "didn't see 'in' in %s" % datas[1]
                    return
                reboot_cmd = datas[0]
                time_val = float(datas[2]) 
                resolution = datas[3]
                if "seconds" in resolution:
                    logger.info("wait for %s seconds, then reboot..." % str(time_val))
                    print "wait for %s seconds, then reboot..." % str(time_val)
                    if (reboot_in == 0):
                        #only reset timer if it's not already going
                        reboot_timer = time.time() #initialize timer
                    reboot_in = time_val
                else:
                    if "minute" in resolution:
                        print "wait for %s minutes, then reboot..." % str(time_val)
                        logger.info("wait for %s minutes, then reboot..." % str(time_val))
                        if (reboot_in == 0):
                        #only reset timer if it's not already going
                            reboot_timer = time.time() #initialize timer
                        reboot_in = (time_val * 60)
                    else:
                        logger.info("unknown time resolution. sleep %s seconds, then reboot..." % str(time_val))
                        print "unknown time resolution. sleep %s seconds, then reboot..." % str(time_val)
                        if (reboot_in == 0):
                        #only reset timer if it's not already going
                            reboot_timer = time.time() #initialize timer
                        reboot_in = (time_val)
            else:
                print "Unknown command"
                logger.info("Unknown command")
    except Exception, e:
        logger.error( "error in parse_command", exc_info=True)
        
############################################################
# get_ip_address()
############################################################
# gets IP address of eth0 as a string
def get_ip_address(ifname):
    try:
        if os.name == 'nt':
            import socket
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(('8.8.8.8', 0))  # connecting to a UDP address doesn't send packets
            local_ip_address = s.getsockname()[0]
            if local_ip_address == None or local_ip_address == "":
                return this_default_ip
            else:
                return local_ip_address
        else:
            if sys.platform == 'linux' or sys.platform == 'linux2':
                import fcntl
                import socket
                s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
                local_ip_address = socket.inet_ntoa(fcntl.ioctl(
                        s.fileno(),
                        0x8915,  # SIOCGIFADDR
                        struct.pack('256s', ifname[:15])
                        )[20:24])
                if local_ip_address == None or local_ip_address == "":
                    return this_default_ip
                else:
                    return local_ip_address
            else: #mac os probably
                import socket
                local_ip_address = socket.gethostbyname(socket.gethostname())
                if local_ip_address == None or local_ip_address == "":
                    return this_default_ip
                else:
                    return local_ip_address
    except Exception, e:
        logger.error ("error in get_ip_address: %s" % e, exc_info=True)
        return this_default_ip

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
                return (uptime_string, uptime_seconds)
        else:
            if os.name == 'nt':
                import win32api
                uptime_seconds = win32api.GetTickCount() / 1000
                uptime_string = str(datetime.timedelta(seconds = uptime_seconds))
                uptime_string = uptime_string.split('.')[0]
                return (uptime_string, uptime_seconds)
            else: # mac os probably
                output = subprocess.check_output(['sysctl', '-n', 'kern.boottime']).strip()
                boottime = re.search('sec = (\d+),', output).group(1)
                uptime_seconds = datetime.timedelta(seconds=float(boottime)).seconds
                uptime_string = str(datetime.timedelta(seconds = uptime_seconds))
                uptime_string = uptime_string.split('.')[0]
                return (uptime_string, uptime_seconds)
    except Exception, e:
        logger.error( "error getting uptime, %s" % e, exc_info=True)
        return ("", 0)

############################################################
# socket_connect()
############################################################   
# connects to the UDP watchdog. See host/port above. Run in a loop to retry
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
            logger.error( 'Failed to create socket: %s' % e, exc_info=True)
            return 0
        else:
            print ('Socket created. Messages will be sent to: ' + remote_ip),
            sys.stdout.flush()
            return 1

############################################################
# print_startup_message()
############################################################
# prints the ID name of every device to be monitored, so the user can copy it to the Master Doc
def print_startup_message(software_list, ups_list):
    global this_ip
    logger.info("Now monitoring:")
    logger.info(this_ip)
    for (proc_name) in software_list:
        if (proc_name[0] == '/'):
            logger.info(this_ip + str(proc_name))
        else:
            logger.info(this_ip + "/" + str(proc_name))
    i = 0
    for (ups_name) in ups_list:
        i = i + 1
        if (ups_list[0] == '/'):
            logger.info(this_ip + "ups" + str(i))
        else:
            logger.info(this_ip + "/" + "ups" + str(i))

############################################################
# send_ok_now()
############################################################ 
# this sends an OK message ("OKAY" or "NONRESPONSIVE") via UDP
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
            logger.error( "Send failed! %s" % e, exc_info=True)
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
                if (status == 1):
                    print message
                    watchsock.sendto(message, (remote_ip, port))
                else:
                    print "failed to send"
        except IOError as e:
            logger.error( "failed to send %s " % e, exc_info=True)
        
############################################################
# process_exists()
############################################################   
# returns True if proc_name is a running process, False if not.
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
                logger.info("rebooting")
                reboot_in = 0
                reboot_timer = time.time()
                rebootscript()
    except Exception, e:
        logger.error( "timing/reboot error %s" % e, exc_info=True)
        
    try:
        if (time.time() - send_ok_timer_pi > send_ok_period + 30):
            send_ok_now("PI", "OKAY", "")
            send_ok_timer_pi = time.time()
    except Exception, e:
        logger.error( "FAILURE in pi_scan! %s" % e, exc_info=True)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
    try:
        data = ""
        r,w,x = select.select([server_socket],[],[],0)
        if server_socket in r:
            data, address = server_socket.recvfrom(1024)
            if (data):
                logger.info("-----Server (%s) connected, sent %s" % (address, data))
            #######################
            # DATA RECEIVED
            #######################
                parse_command(data)
    except socket.timeout:
        return
    except Exception, e:
        logger.error( "FAILURE in pi_scan for server socket! %s" % e, exc_info=True)
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
                 if (process_exists(proc_name)):
                     send_ok_now("PI", "OKAY", proc_name)
                 else:
                     send_ok_now("PI", "NONRESPONSIVE", proc_name)
             send_ok_timer_software = time.time()
     except Exception, e:
         for frame in traceback.extract_tb(sys.exc_info()[2]):
             fname,lineno,fn,text = frame
             print "     in %s on line %d" % (fname, lineno)
             logger.error( "Error in software_scan(): %s" % e, exc_info=True)

############################################################
# ups_ok()
############################################################
# checks the UPS on this PC. returns True (UPS is ONLINE) or false (not ONLINE)
def ups_ok(ups_file):
    try:
        with open(ups_file, 'r') as infile:
            for line in infile:
                if 'STATUS' in line:
                    line_split = line.split()
                    if line_split[2] != 'ONLINE':
#                        print "BAD STATUS: " + line_split[2]
                        return False
                    else:
#                        print "HAPPY STATUS: " + line_split[2]
                        return True
    except Exception, e:
        logger.error( "ups check error: %s" % e, exc_info=True)
        return False

############################################################
# ups_scan()
############################################################
# checks UPSes on this PC, sends OKAY to the watchdog server for each UPS if it's online, otherwise sends NONRESPONSIVE  
def ups_scan(ups_list):    
    global send_ok_timer_ups
    global send_ok_period
    sleep(0.005) #otherwise it eats every CPU :3
    try:
        if (time.time() - send_ok_timer_ups > send_ok_period + 15):
            i = 0
            for (ups_file) in ups_list:
                i = i + 1
                if (ups_ok(ups_file)):
                    send_ok_now("PI", "OKAY", "ups" + str(i))
                else:
                    send_ok_now("PI", "NONRESPONSIVE", "ups" + str(i))
            send_ok_timer_ups = time.time()
    except Exception, e:
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
            logger.error( "Error in ups_scan(): %s" % e, exc_info=True)
             
###################################
# main() - main scan loop
###################################     

print "starting in 2 seconds..."
time.sleep(2); # give arduinos time to start

setup_logger() # sets up watchdog log file
autodetect_softwarelist() #autogens monitored list from "crontab -l"
read_softwarelist_file() #appends to monitored list from optional file 
autodetect_this_ip() #sets the default IP in case we don't get one below

#set up serial connection...
if (USE_SOCKETS):
    status = 0
    while (status == 0):
        status = socket_connect()

this_ip = get_ip_address('eth0') #grabs current IP address
print "from: " + this_ip
sys.stdout.flush()

print_startup_message(softwarelist, upslist) #prints the stuff to be monitored

while 1:
    pi_scan() #sends OK messages for this machine
    software_scan(softwarelist) #sends OK/NONRES for monitored software
    ups_scan(upslist) #sends OK/NONRES for the attached UPS, if any
    print_startup_message = 0

# tenth version. does ups scanning on PCs & software/crontab autodetect on Pis
