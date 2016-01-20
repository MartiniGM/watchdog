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

POE_COMMAND = "../set_power.exp"
WOL_COMMAND = "../wolcmd"

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = '../tcp_watchdog_server/demosdb.db'

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

def start_windows(mac_address):
    wake_on_lan(mac_address)
        
def start_pi(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)

def start_arduino(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)
    
def reboot_windows(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_pi(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_arduino(switch_ip, switch_interface, delay):
    set_PoE("never", switch_ip, switch_interface)
    time.sleep(delay)
    set_PoE("auto", switch_ip, switch_interface)
    
def stop_arduino(remote_ip, switch):
    set_PoE("never", remote_ip, switch)

def stop_windows(remote_ip):
    udpsend("halt now", remote_ip, 6666)

def stop_pi(remote_ip, switch_ip, switch_interface, delay):
    udpsend("halt now", remote_ip, 6666)
    time.sleep(delay)
    set_PoE("never", switch_ip, switch_interface)

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
        
def get_item(remote_ip):
    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error("Can't connect to demosdb! %s" % e)
        
    try:
        with con:
            cur = con.cursor()
            sql = "SELECT MAC_ADDRESS, SWITCH_INTERFACE FROM DEVICES WHERE ID_NAME LIKE '%s'" % remote_ip
            cur.execute(sql)
            data = cur.fetchall()
            print data
            return data[0]
    except lite.Error, e:
        print(" SQL error! %s" % e)   

def start_show():
    print "start show"

def stop_show():
    print "stop show"

def reboot_show():
    print "reboot show"

def reboot_unresponsive():
    print "reboot unresponsive"        
            
###################################
# main() - main scan loop
###################################

if __name__ == "__main__":

#set_PoE("never", "10.42.0.16", "FastEthernet1/0/8")
#time.sleep(10)
#set_PoE("auto", "10.42.0.16", "FastEthernet1/0/8")
#shut_down_windows_or_pi("10.42.16.23")
#wake_on_lan("D8:CB:8A:38:E8:E2")

    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--start_pi',
                        action='store_true',
                        help='starts a Raspberry Pi (given ip address in --ip)' )

    group.add_argument('--start_arduino',
                        action='store_true',
                        help='starts an Arduino (given ip address in --ip)' )

    group.add_argument('--start_windows',
                        action='store_true',
                        help='starts a Windows PC (given ip address in --ip)' )

    group.add_argument('--stop_pi',
                        action='store_true',
                        help='stops a Raspberry Pi (given ip address in --ip)' )

    group.add_argument('--stop_arduino',
                        action='store_true',
                        help='stops an Arduino (given ip address in --ip)' )
    
    group.add_argument('--stop_windows',
                        action='store_true',
                        help='stops a Windows PC (given ip address in --ip)' )

    group.add_argument('--reboot_arduino',
                        action='store_true',
                        help='reboots an Arduino (given ip address in --ip)' )

    group.add_argument('--reboot_windows',
                        action='store_true',
                        help='reboots a Windows PC (given ip address in --ip)' )

    group.add_argument('--reboot_pi',
                        action='store_true',
                        help='reboots a Raspberry Pi (given ip address in --ip)' )

    group.add_argument('--reboot_show',
                        action='store_true',
                        help='reboots the whole show (with great power... etc)')

    group.add_argument('--stop_show',
                        action='store_true',
                        help='shuts down the whole show (with great power... etc)')

    group.add_argument('--start_show',
                        action='store_true',
                        help='starts the whole show (with great power... etc)')

    group.add_argument('--reboot_unresponsive',
                        action='store_true',
                        help='reboots all unresponsive devices in the whole show (with great power... etc)')
    
    parser.add_argument('--ip', 
                        type=str,
                        help='IP address to use (i.e. 10.42.16.166)' )
    
    args = parser.parse_args()

    if args.ip:
        remote_ip = args.ip
        (mac_address, switch_interface) = get_item(remote_ip)
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
            
        print "mac " + mac_address
        print "switch ip " + switch_ip
        print "switch interface " + switch_interface
        print "remote_ip " + remote_ip

    if args.start_pi:
        print "start pi"
        check_switch(switch_ip, switch_interface)
        start_pi(switch_ip, switch_interface)
        
    if args.start_arduino:
        check_switch(switch_ip, switch_interface)
        start_arduino(switch_ip, switch_interface)
        print "start arduino"

    if args.start_windows:
        print "start windows"
        check_macaddress(mac_address)
        start_windows(mac_address)
        
    if args.stop_pi:
        print "stop pi"
        check_remoteip_switch(remote_ip, switch_ip, switch_interface)
        stop_pi(remote_ip, switch_ip, switch_interface, 6)
        
    if args.stop_arduino:
        print "stop arduino"
        check_switch(switch_ip, switch_interface)
        stop_arduino(switch_ip, switch_interface)
        
    if args.stop_windows:
        print "stop windows"
        check_remoteip(remote_ip)
        stop_windows(remote_ip)
        
    if args.reboot_pi:
        print "reboot pi"
        check_remoteip(remote_ip)
        reboot_pi(remote_ip)
        
    if args.reboot_arduino:
        print "reboot arduino"
        check_switch(switch_ip, switch_interface)
        reboot_arduino(switch_ip, switch_interface, 2)
        
    if args.reboot_windows:
        print "reboot windows"        
        check_remoteip(remote_ip)
        reboot_windows(remote_ip)
        
    if args.stop_show:
        stop_show()
        
    if args.start_show:
        start_show()

    if args.reboot_show:
        reboot_show()

    if args.reboot_unresponsive:
        reboot_unresponsive()
        
    
    
