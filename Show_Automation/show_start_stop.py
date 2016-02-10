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

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db'
#LINUX_OSX_DB_FILENAME = "../demosdb.db"

###############
# PoE, WOL, UDPSEND
###############

def set_PoE(auto_or_never, remote_ip, switch):
    import subprocess
    try:
        command = [POE_COMMAND, auto_or_never, remote_ip, switch]
        p = subprocess.Popen(command, stdout=subprocess.PIPE)
        for line in p.stdout:
            print line

    except Exception, e:
        print( "set_PoE error: %s" % e)

def udpsend(message, remote_ip, port):
    try:
        watchsock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    except socket.error as e:
        print( 'Failed to create outgoing socket: %s' % e )

    try:
        print "send " + message + " to " + remote_ip
        watchsock.sendto(message, (remote_ip, port))
        watchsock.close()
    except Exception, e:
        print( 'Failed to send on outgoing socket: %s' % e )

def wake_on_lan(mac_address):
    import subprocess
    try:
        command = [WOL_COMMAND, mac_address, "255.255.255.255",
                   "255.255.255.255", "4343"]
        p = subprocess.Popen(command, stdout=subprocess.PIPE)
        for line in p.stdout:
            print line

    except Exception, e:
        print( "set_PoE error: %s" % e)

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
        print "IP not set! Exiting..."
        exit

def check_macaddress(mac_address):
    if mac_address is None or mac_address == "":
        print "MAC address not set! Exiting..."
        exit
        
def check_switch(remote_ip, switch):
    if remote_ip is None or remote_ip == "":
        print "switch IP not set! Exiting..."
        exit
    if switch is None or switch == "":
        print "switch interface not set! Exiting..."
        exit

def check_remoteip_switch(remote_ip, switch, switch_interface):
    if remote_ip is None or remote_ip == "":
        print "remote IP not set! Exiting..."
        exit
    if switch is None or switch == "":
        print "switch IP not set! Exiting..."
        exit
    if switch_interface is None or switch_interface == "":
        print "switch interface not set! Exiting..."
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
        print "Can't connect to demosdb! %s" % e
        
    try:
        with con:
            cur = con.cursor()
            sql = "SELECT MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE FROM DEVICES WHERE ID_NAME LIKE '%s'" % remote_ip
            cur.execute(sql)
            data = cur.fetchall()
            print data 
            return data[0]
    except lite.Error, e:
        print(" SQL error! %s" % e)   

###############
# START DEVICE
###############

def start_device(switch_ip, switch_interface, device_type, mac_address):        
    if "berry" in device_type.lower(): 
        print "start pi"
        print "%s %s" % (switch_ip, switch_interface)
        check_switch(switch_ip, switch_interface)
        if not args.disable:
            print "gonna do the thing"
            start_pi(switch_ip, switch_interface)
    else:
        if "indow" in device_type.lower():
            print "start windows"
            print "%s" % (mac_address)
            check_macaddress(mac_address)
            if not args.disable:
                print "gonna do the thing"
                start_windows(mac_address)
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():
                print "start arduino"                    
                print "%s %s" % (switch_ip, switch_interface)
                check_switch(switch_ip, switch_interface)
                if not args.disable:
                    print "gonna do the thing"
                    start_arduino(switch_ip, switch_interface)
            else:
                print "WARNING: type %s not matched, exiting..." % device_type

###############
# STOP DEVICE
###############
def stop_device(remote_ip, switch_ip, switch_interface, device_type):
    if "berry" in device_type.lower(): 
        print "stop pi"
        print "%s %s %s" % (remote_ip, switch_ip, switch_interface)
        check_remoteip_switch(remote_ip, switch_ip, switch_interface)
        if not args.disable:
            print "gonna do the thing"
            stop_pi(remote_ip, switch_ip, switch_interface, 6)        
    else:
        if "indow" in device_type.lower():
            print "stop windows"
            print "%s" % (remote_ip)
            check_remoteip(remote_ip)
            if not args.disable:
                print "gonna do the thing"
                stop_windows(remote_ip)
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
                print "stop arduino"
                print "%s %s" % (switch_ip, switch_interface)
                check_switch(switch_ip, switch_interface)
                if not args.disable:
                    print "gonna do the thing"
                    stop_arduino(switch_ip, switch_interface)
            else:
                print "WARNING: type %s not matched, exiting..." % device_type

###############
# REBOOT DEVICE
###############

def reboot_device(remote_ip, switch_ip, switch_interface, device_type):
    if "berry" in device_type.lower(): 
        print "reboot pi"
        check_remoteip(remote_ip)
        if not args.disable:
            print "gonna do the thing"
            reboot_pi(remote_ip)        
    else:
        if "indow" in device_type.lower():
            print "reboot windows"        
            check_remoteip(remote_ip)
            if not args.disable:
                print "gonna do the thing"
                reboot_windows(remote_ip)
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
                print "reboot arduino"
                check_switch(switch_ip, switch_interface)
                if not args.disable:
                    print "gonna do the thing"
                    reboot_arduino(switch_ip, switch_interface, 2)
            else:
                print "WARNING: type %s not matched, exiting..." % device_type

###############
# START/STOP/REBOOT SHOW
###############            
                
def start_stop_reboot_show(command, limit_to_switch_ip):
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
        print "Can't connect to demosdb! %s" % e
        return
    
    try:
        with con:
            cur = con.cursor()
            where_cmd = ""

            if limit_to_switch_ip is None:
                limit_to_switch_ip = ""

#            if limit_to_switch_ip is not None and limit_to_switch_ip != "":
#                print "Limit to switch: %s" % limit_to_switch_ip
#                where_cmd = where_cmd + "WHERE 'SWITCH_INTERFACE' IS LIKE '%s'" % limit_to_switch_ip
            if "noglobal" in command:
                where_cmd = where_cmd + "AND DESCRIPTION NOT LIKE 'GLOBAL'"

            #old style
            #            sql = "SELECT ID_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE FROM DEVICES ORDER BY DEVICE_TYPE DESC, ID_NAME ASC"
            if "start" in command:
                sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            else:
                if "stop" in command:
                    sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER DESC, ID_NAME ASC" 
                else:
                    if "reboot" in command:
                        sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER DESC, ID_NAME ASC" 
                    else:
                        print "command not recognized"
                        return
            print "sql is: %s" % sql
            cur.execute(sql)
            data = cur.fetchall()
            print data
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

 #               if device_name != "":
 #                   print
 #                   print device_name

 #               if boot_order is not None:
 #                   print boot_order

 #               if mac_address != "":
 #                   print "mac " + mac_address
 #               if switch_ip != "":
 #                   print "switch ip " + switch_ip
 #               if switch_interface != "":
 #                   print "switch interface " + switch_interface
 #               if remote_ip != "":
 #                   print "remote_ip " + remote_ip

                if command is "start":
                    #start each item, then delay
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            start_device(switch_ip, switch_interface, device_type, mac_address)
                            print "start it"
                    else:
                        print "start it"
                        start_device(switch_ip, switch_interface, device_type, mac_address)
                            
                if command is "stop":
                    #stop each item, then delay
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            print "stop it"
                            stop_device(remote_ip, switch_ip, switch_interface, device_type)
                    else:
                            print "stop it"
                            stop_device(remote_ip, switch_ip, switch_interface, device_type)

                if command is "reboot":
                    #stop each item, then delay
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            print "reboot it"
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type)
                    else:
                            print "reboot it"
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type)
    except lite.Error, e:
        print(" SQL error! %s" % e)   

###############
# REBOOT NONRESPONSIVE DEVICES
###############            
        
def reboot_unresponsive():
    print "reboot unresponsive"        
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
        print "Can't connect to demosdb! %s" % e
        
    try:
        with con:
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER FROM DEVICES ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
#            sql = "SELECT ID_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE FROM DEVICES WHERE STATUS='NONRESPONSIVE' ORDER BY DEVICE_TYPE DESC, ID_NAME ASC" 
            cur.execute(sql)
            data = cur.fetchall()
            print data
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
                    continue

                if device_name != "":
                    print
                    print device_name

                if boot_order is not None:
                    print boot_order

                if mac_address != "":
                    print "mac " + mac_address
                if switch_ip != "":
                    print "switch ip " + switch_ip
                if switch_interface != "":
                    print "switch interface " + switch_interface
                if remote_ip != "":
                    print "remote_ip " + remote_ip

                if mac_address != "":
                    print "mac " + mac_address
                if switch_ip != "":
                    print "switch ip " + switch_ip
                if switch_interface != "":
                    print "switch interface " + switch_interface
                if remote_ip != "" and "oftware" not in device_type:
                    print "remote_ip " + remote_ip

                #stop each item, then delay
                    print "reboot it"
                    
    except lite.Error, e:
        print(" SQL error! %s" % e) 

###################################
# main() - main scan loop
###################################

if __name__ == "__main__":

    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""

    parser = argparse.ArgumentParser()
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

    group.add_argument('--stop_show_noglobal',
                        action='store_true',
                        help='shuts down the whole show, sans global audio (with great power... etc)')

    group.add_argument('--start_show',
                        action='store_true',
                        help='starts the whole show (with great power... etc)')

    group.add_argument('--start_show_noglobal',
                        action='store_true',
                        help='starts the whole show, sans global audio (with great power... etc)')

    group.add_argument('--reboot_nonresponsive',
                        action='store_true',
                        help='reboots all nonresponsive devices in the whole show (with great power... etc)')

    group.add_argument('--reboot_unresponsive',
                        action='store_true',
                        help='reboots all nonresponsive devices in the whole show (with great power... etc)')

    parser.add_argument("--switch",
                       type=str,
                       help='Limits start_show and stop_shot to this switch IP address (i.e. 10.42.16.166)' ) 
    
    parser.add_argument('--disable',
                        action='store_true',
                        help='Disables start/stop/reboot commands (test mode)')

    parser.add_argument('--ip', 
                        type=str,
                        help='IP address to use (i.e. 10.42.16.166)' )
    
    args = parser.parse_args()
#    print  sys.argv[1:]

    ###############################################
    # sets args for single-device start/stop/reboot
    ###############################################            
    
    if args.ip:

        if args.start_device or args.stop_device or args.reboot_device:
            remote_ip = args.ip
#            print remote_ip
            (mac_address, switch_interface, device_type) = get_item(remote_ip)
            if device_type is None:
                print "Error: no device type found for %s, exiting..." % remote_ip
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

            if mac_address != "":
                print "mac " + mac_address
            if switch_ip != "":
                print "switch ip " + switch_ip
            if switch_interface != "":
                print "switch interface " + switch_interface
            if remote_ip != "":
                print "remote_ip " + remote_ip

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

    if args.start_show_noglobal:
        if args.switch:
            switch_interface = args.switch
        start_stop_reboot_show("start_noglobal", switch_interface)

    ###############
    # STOP SHOW
    ###############
        
    if args.stop_show:
        if args.switch:
            switch_interface = args.switch

        start_stop_reboot_show("stop", switch_interface)

    if args.stop_show_noglobal:
        if args.switch:
            switch_interface = args.switch

        start_stop_reboot_show("stop_noglobal", switch_interface)
        
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
        reboot_unresponsive()
