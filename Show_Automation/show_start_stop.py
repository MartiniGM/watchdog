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
import traceback
import argparse
from collections import defaultdict
# to install the three below:
# "pip install gspread; pip install oauth2client; pip install PyOpenSSL"
# install pip first if you don't have it, on windows just google "get-pip.py".
# on Mac OS use "easy_install pip"
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

POE_COMMAND = "/Users/Aesir/Documents/watchdog/set_power.exp"
WOL_COMMAND = "/Users/Aesir/Documents/watchdog/wolcmd"
DELAY_BETWEEN_DEVICES = 0.5 #delays a half second between displaying device & stop/starting

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db'
#LINUX_OSX_DB_FILENAME = "../demosdb.db"

# give a filename for the watchdog's log file here                              
LOG_FILENAME = '/Users/Aesir/Documents/watchdog/Show_Automation/show_start_stop.out'
# give the size for each rolling log segment, in bytes                          
LOG_SIZE = 2000000 #2 MB, in bytes                                              
# give the number of rolling log segments to record before the log rolls over   
LOG_NUM_BACKUPS = 5 # five .out files before they roll over                     

####################                                                            
# EXIT HANDLER                                                                  
####################

# upon exit, log exit msg, disconnect from sqlite and close sockets             
def exit_func():
    logger.warning ("     Show start/stop script CLOSED ")
    logger.warning ("     ")
    sys.exit(0)

# exits the program cleanly, logging exit time                                  
def signal_handler(signal, frame):
    print ""
    exit_func()

signal.signal(signal.SIGINT, signal_handler)

###############
# PoE, WOL, UDPSEND
###############

def set_PoE(auto_or_never, remote_ip, switch):
    import subprocess
    try:
        command = [POE_COMMAND, auto_or_never, remote_ip, switch]
        p = subprocess.Popen(command, stdout=subprocess.PIPE)
        for line in p.stdout:
            logger.info( line )

    except Exception, e:
        logger.error( " ERROR: set_PoE error: %s" % e)

def udpsend(message, remote_ip, port):
    try:
        watchsock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    except socket.error as e:
        logger.error( ' ERROR: Failed to create outgoing socket: %s' % e )

    try:
        logger.info( " send " + message + " to " + remote_ip )
        watchsock.sendto(message, (remote_ip, port))
        watchsock.close()
    except Exception, e:
        logger.error( ' ERROR: Failed to send on outgoing socket: %s' % e )

def wake_on_lan(mac_address):
    import subprocess
    try:
        command = [WOL_COMMAND, mac_address, "255.255.255.255",
                   "255.255.255.255", "4343"]
        p = subprocess.Popen(command, stdout=subprocess.PIPE)
        for line in p.stdout:
            logger.info(line)

    except Exception, e:
        logger.error( " ERROR: set_PoE error: %s" % e)

###############
# START TYPES
###############
        
def start_windows(mac_address):
    wake_on_lan(mac_address)
        
def start_pi(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)

def start_arduino(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)

###############
# REBOOT TYPES
###############
    
def reboot_windows(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_pi(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_arduino(switch_ip, switch_interface, delay):
    set_PoE("never", switch_ip, switch_interface)
    time.sleep(delay)
    set_PoE("auto", switch_ip, switch_interface)

###############
# STOP TYPES
###############
    
def stop_arduino(remote_ip, switch):
    set_PoE("never", remote_ip, switch)

def stop_windows(remote_ip):
    udpsend("halt now", remote_ip, 6666)

def stop_pi(remote_ip, switch_ip, switch_interface, delay):
    udpsend("halt now", remote_ip, 6666)
    time.sleep(delay)
    set_PoE("never", switch_ip, switch_interface)

###############
# CHECK FUNCTIONS
###############
    
def check_remoteip(remote_ip):
    if remote_ip is None or remote_ip == "":
        logger.error( " ERROR: IP not set! Exiting...")
        exit

def check_macaddress(mac_address):
    if mac_address is None or mac_address == "":
        logger.error( " ERROR: MAC address not set! Exiting...")
        exit
        
def check_switch(remote_ip, switch):
    if remote_ip is None or remote_ip == "":
        logger.error( " ERROR: switch IP not set! Exiting...")
        exit
    if switch is None or switch == "":
        logger.error( " ERROR: switch interface not set! Exiting...")
        exit

def check_remoteip_switch(remote_ip, switch, switch_interface):
    if remote_ip is None or remote_ip == "":
        logger.error( " ERROR: remote IP not set! Exiting...")
        exit
    if switch is None or switch == "":
        logger.error( " ERROR: switch IP not set! Exiting...")
        exit
    if switch_interface is None or switch_interface == "":
        logger.error( " ERROR: switch interface not set! Exiting...")
        exit

###############
# GET_ITEM 
###############
        
def get_item(remote_ip):
    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)
        
    try:
        with con:
            cur = con.cursor()
            sql = "SELECT MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE FROM DEVICES WHERE ID_NAME LIKE '%s'" % remote_ip
            cur.execute(sql)
            data = cur.fetchall()
            logger.info( data ) 
            return data[0]
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   

###############
# START DEVICE
###############

def start_device(switch_ip, switch_interface, device_type, mac_address):        
    if "berry" in device_type.lower(): 
#        print "start pi"
        logger.info( " start pi: %s %s" % (switch_ip, switch_interface))
        check_switch(switch_ip, switch_interface)
        time.sleep(DELAY_BETWEEN_DEVICES)
        if not args.disable:
            logger.info(" now starting... %s %s" %  (switch_ip, switch_interface))
            start_pi(switch_ip, switch_interface)
    else:
        if "indow" in device_type.lower():
#            print "start windows"
            logger.info(" start windows: %s" % (mac_address))
            check_macaddress(mac_address)
            time.sleep(DELAY_BETWEEN_DEVICES)
            if (not args.disable) and not (args.no_servers):
                logger.info("now starting... %s" % (mac_address))                
                start_windows(mac_address)
            else:
                if args.no_servers:
                    logger.info( " skipping device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():
#                print "start arduino"                    
                logger.info(" start arduino: %s %s" % (switch_ip, switch_interface))
                check_switch(switch_ip, switch_interface)
                time.sleep(DELAY_BETWEEN_DEVICES)
                if not args.disable:
                    logger.info(" now starting... %s %s" % (switch_ip, switch_interface))
                    start_arduino(switch_ip, switch_interface)
            else:
                logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# STOP DEVICE
###############
def stop_device(remote_ip, switch_ip, switch_interface, device_type):
    if "berry" in device_type.lower(): 
#        print "stop pi"
        logger.info( " stop pi: %s %s %s" % (remote_ip, switch_ip, switch_interface))
        check_remoteip_switch(remote_ip, switch_ip, switch_interface)
        time.sleep(DELAY_BETWEEN_DEVICES)
        if not args.disable:
            logger.info( " now stopping... %s %s %s" % (remote_ip, switch_ip, switch_interface))
            stop_pi(remote_ip, switch_ip, switch_interface, 6)        
    else:
        if "indow" in device_type.lower():
#            print "stop windows"
            logger.info( " stop windows: %s" % (remote_ip))
            check_remoteip(remote_ip)
            time.sleep(DELAY_BETWEEN_DEVICES)

            if not args.disable and not args.no_servers:
                logger.info( "now stopping... %s" % (remote_ip))
                stop_windows(remote_ip)
            else:
                if args.no_servers:
                    logger.info(" skip device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
#                print "stop arduino"
                logger.info( " stop arduino: %s %s" % (switch_ip, switch_interface))
                check_switch(switch_ip, switch_interface)
                time.sleep(DELAY_BETWEEN_DEVICES)

                if not args.disable:
                    logger.info( " now stopping... %s %s" % (switch_ip, switch_interface))
                    stop_arduino(switch_ip, switch_interface)
            else:
                logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# REBOOT DEVICE
###############

def reboot_device(remote_ip, switch_ip, switch_interface, device_type):
    if "berry" in device_type.lower(): 
#        print "reboot pi"
        logger.info( " reboot pi: %s" % (remote_ip))
        check_remoteip(remote_ip)
        time.sleep(DELAY_BETWEEN_DEVICES)

        if not args.disable:
            logger.info( " now rebooting... %s" % (remote_ip))
            reboot_pi(remote_ip)        
    else:
        if "indow" in device_type.lower():
#            print "reboot windows"       
            logger.info( " reboot windows: %s" % (remote_ip))
            check_remoteip(remote_ip)
            time.sleep(DELAY_BETWEEN_DEVICES)
        
            if not args.disable and not args.no_servers:
                logger.info( " now rebooting... %s" % (remote_ip))
                reboot_windows(remote_ip)
            else:
                if args.no_servers:
                    logger.info( " skip device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
#                print "reboot arduino"
                logger.info(" reboot arduino: %s %s" % (switch_ip, switch_interface))
                check_switch(switch_ip, switch_interface)
                time.sleep(DELAY_BETWEEN_DEVICES)

                if not args.disable:
                    logger.info(" now rebooting... %s %s" % (switch_ip, switch_interface))
                    reboot_arduino(switch_ip, switch_interface, 2)
            else:
                logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# START/STOP/REBOOT SHOW
###############            
                
def start_stop_reboot_show(command, limit_to_switch_ip):
    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""

    if limit_to_switch_ip is None:
        limit_to_switch_ip = ""

    cmd = " -----%s show" % command
    if limit_to_switch_ip is not "":
        cmd = cmd + ", limited to switch %s" % limit_to_switch_ip
    if args.disable:
        cmd = cmd + ", ***START/STOP DISABLED"

    logger.info(cmd)       

    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)
        return
    
    try:
        with con:
            cur = con.cursor()
            where_cmd = ""

            if args.no_global:
                where_cmd = where_cmd + "AND DESCRIPTION NOT LIKE 'GLOBAL'"

            if "start" in command:
                sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            else:
                if "stop" in command:
                    sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER DESC, ID_NAME ASC" 
                else:
                    if "reboot" in command:
                        sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER DESC, ID_NAME ASC" 
                    else:
                        logger.error( " ERROR: command %s not recognized", command)
                        return
#            print "sql is: %s" % sql
            cur.execute(sql)
            data = cur.fetchall()
#            print data
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order) = item
                if mac_address is None:
                    mac_address = ""

                if switch_interface is None:
                    switch_interface = ""
                    switch_ip = ""
                else:
                    switch_group = switch_interface.split()
                    switch_ip = switch_group[0]
                    switch_interface = switch_group[1]

                if remote_ip is None:
                    remote_ip = ""

                if device_name is None:
                    device_name = ""

                if device_type is None:
                    device_type = ""

                if "software" in device_type.lower():
                    continue

                if command is "start":
                    #start each item
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            start_device(switch_ip, switch_interface, device_type, mac_address)
#                            print "start it"
                    else:
#                        print "start it"
                        start_device(switch_ip, switch_interface, device_type, mac_address)
                            
                if command is "stop":
                    #stop each item
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
#                            print "stop it"
                            stop_device(remote_ip, switch_ip, switch_interface, device_type)
                    else:
#                            print "stop it"
                            stop_device(remote_ip, switch_ip, switch_interface, device_type)

                if command is "reboot":
                    #reboot each item
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
#                            print "reboot it"
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type)
                    else:
#                            print "reboot it"
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type)
                            
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   

###############
# REBOOT NONRESPONSIVE DEVICES
###############            
        
def reboot_unresponsive(limit_to_switch_ip):
    logger.info( " -----reboot unresponsive" )       
    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""
    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)
        
    if limit_to_switch_ip is None:
        limit_to_switch_ip = ""

    try:
        with con:
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES WHERE STATUS='NONRESPONSIVE' ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            cur.execute(sql)
            data = cur.fetchall()
#            logger.info( data)
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order) = item
                if mac_address is None:
                    mac_address = ""

                if switch_interface is None:
                    switch_interface = ""
                    switch_ip = ""
                else:
                    switch_group = switch_interface.split()
                    switch_ip = switch_group[0]
                    switch_interface = switch_group[1]

                if remote_ip is None:
                    remote_ip = ""

                if device_type is None:
                    device_type = ""

                if "software" in device_type.lower():
                    #don't do anything for software
                    continue

                #stop each item, then delay
                if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                    if limit_to_switch_ip in switch_group:
#                            print "reboot it"
                        reboot_device(remote_ip, switch_ip, switch_interface, device_type)
                else:
#                            print "reboot it"
                    reboot_device(remote_ip, switch_ip, switch_interface, device_type)
                
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e) 

###################################
# main() - main scan loop
###################################

if __name__ == "__main__":

    ##################                                                          
    # LOGGING SETUP                                                             
    ##################                                                          

    # defines log levels for the log file. Default is 'info' and above.         
    # Run program with "debug" on the command line for extra debugging output   
    LEVELS = {
        'debug':logging.DEBUG,
        'info':logging.INFO,
        'warning':logging.WARNING,
        'error':logging.ERROR,
        'critical':logging.CRITICAL, }

    # default log level is info (prints info, warning, error, etc).             
    # run with "tcp_watchdog_sqlite.py debug" to print/log debug messages       
    level = LEVELS.get('info', logging.NOTSET)
    logging.basicConfig(level=level)

    # creates our logger with the settings above/below                          
    logger = logging.getLogger('StartStopLog')

    # Add the log message handler to the logger. Creates a rolling/circular log
    # with LOG_NUM_BACKUPS backups, each of size LOG_SIZE bytes                 
    handler = logging.handlers.RotatingFileHandler(LOG_FILENAME,
                                                   maxBytes=LOG_SIZE,
                                                   backupCount=LOG_NUM_BACKUPS)

    # sets the message & timestamp format for the log                           
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%m/%d/%Y %H:%M:%S")
    handler.setFormatter(frmt)
    logger.addHandler(handler)
    ch = logging.StreamHandler(sys.stdout)
    ch.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""

    parser = argparse.ArgumentParser()

    ##### stand-alone arguments (choose only one)
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--start_device',
                        action='store_true',
                        help='starts a single device (given ip address in --ip)' )

    group.add_argument('--stop_device',
                        action='store_true',
                        help='stops a single device (given ip address in --ip)' )

    group.add_argument('--reboot_device',
                        action='store_true',
                        help='reboots a single device (given ip address in --ip)' )

    group.add_argument('--reboot_show',
                        action='store_true',
                        help='reboots the whole show (with great power... etc)')

    group.add_argument('--stop_show',
                        action='store_true',
                        help='shuts down the whole show (with great power... etc)')

    group.add_argument('--start_show',
                        action='store_true',
                        help='starts the whole show (with great power... etc)')

    group.add_argument('--reboot_nonresponsive',
                        action='store_true',
                        help='reboots all nonresponsive devices in the whole show (with great power... etc)')

    group.add_argument('--reboot_unresponsive',
                        action='store_true',
                        help='reboots all nonresponsive devices in the whole show (with great power... etc)')

    ##### add-on arguments (can be applied to the above)
    parser.add_argument("--switch",
                       type=str,
                       help='Limits start_show and stop_show to this switch IP address (i.e. 10.42.16.166)' ) 
    
    parser.add_argument('--disable',
                        action='store_true',
                        help='Disables start/stop/reboot commands (test mode)')

    parser.add_argument('--no_servers',
                        action='store_true',
                        help='Skip start/stop/reboot commands for servers (Windows/Mac); start/stop/reboot Pis and Arduinos only')

    parser.add_argument('--no_global',
                        action='store_true',
                        help='Skip global audio devices')

    parser.add_argument('--ip', 
                        type=str,
                        help='IP address to use with start/stop/reboot_device (i.e. 10.42.16.166)' )
    
    args = parser.parse_args()

    ###############################################
    # sets args for single-device start/stop/reboot
    ###############################################            

    cmd = " Show start/stop script OPENED"
    if args.ip:
        cmd = cmd + (" with IP %s" % args.ip)
    if args.no_servers:
        cmd = cmd + (", with --no_servers")      
    if args.no_global:
        cmd = cmd + (", with --no_global")      
    if args.switch:
        cmd = cmd + (", limited to switch %s" % args.switch)
    logger.info(cmd)

    if args.disable:
        logger.warning(" WARNING: disable (test/dry run) option has been selected.")
    
    if args.ip:

        if args.start_device or args.stop_device or args.reboot_device:
            remote_ip = args.ip
            (mac_address, switch_interface, device_type) = get_item(remote_ip)
            if device_type is None:
                logger.error( " ERROR: no device type found for %s, exiting..." % remote_ip)
                exit
            
            if mac_address is None:
                mac_address = ""

            if switch_interface is None:
                switch_interface = ""
                switch_ip = ""
            else:
                switch_group = switch_interface.split()
                switch_ip = switch_group[0]
                switch_interface = switch_group[1]

            if remote_ip is None:
                remote_ip = ""

    ###############
    # START DEVICE
    ###############
        
    if args.start_device:
        start_device(switch_ip, switch_interface, device_type, mac_address)
        
    ###############
    # STOP DEVICE
    ###############
                    
    if args.stop_device:
        stop_device(remote_ip, switch_ip, switch_interface, device_type)

    ###############
    # REBOOT DEVICE
    ###############
                    
    if args.reboot_device:
        reboot_device(remote_ip, switch_ip, switch_interface, device_type)

    ###############
    # START SHOW
    ###############

    if args.start_show:
        if args.switch:
            switch_interface = args.switch            
        start_stop_reboot_show("start", switch_interface)

    ###############
    # STOP SHOW
    ###############
        
    if args.stop_show:
        if args.switch:
            switch_interface = args.switch
        start_stop_reboot_show("stop", switch_interface)

    ###############
    # REBOOT SHOW
    ###############

    if args.reboot_show:
        if args.switch:
            switch_interface = args.switch            
        start_stop_reboot_show("reboot", switch_interface)

    ###############
    # REBOOT NONRESPONSIVE
    ###############
        
    if args.reboot_nonresponsive or args.reboot_unresponsive:
        if args.switch:
            switch_interface = args.switch
        reboot_unresponsive(switch_interface)

    exit_func()
