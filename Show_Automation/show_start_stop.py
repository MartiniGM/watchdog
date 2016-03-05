#!/usr/bin/python 
import OSC
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
DELAY_BETWEEN_RELAYS = 2.0 #delays 2 seconds between commands to the relays
DELAY_FOR_PROJECTORS = 360.0 #delays 6 minutes for projector cooldown and/or startup
INIT_DELAY = 30 #delays 30 seconds before starting script so people can cancel

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

OSC_PORT = 9998 #port to send pause/unpause messages to do-audio on the Pis
RELAY_PORT = 9999 #port to send on/off messages to power relays
WATCHDOG_PORT = 6666 #port to send commands to the watchdog on the Pis
PAUSE_COMMAND = "/pause" #pause command sent to do-audio on the Pis
UNPAUSE_COMMAND = "/unpause" #unpause command sent to do-audio on the Pis

#list of valid zones. if the zone is not in this list, don't continue
zones_ok_list = ["arcade", "art city", "beamcade", "caves", "forest", "house", "portals", "shanty", "theater"]
#list of relay prefixes and their IP addresses, for lookup
relay_ip_list = [["2LB", "10.42.0.111"], ["2LC","10.42.0.112"], ["2LD","10.42.0.113"]]

#list of Max relay mapping files. We read these to get the pin for each relay name
relay_files = ["/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LBmapping.txt",
               "/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LCmapping.txt", 
               "/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LDmapping.txt"] 

#empty list for later
relay_list = []

# json file to hold Google credentials.                                         
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----      
json_file = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----                  

# URL for the google sheet. this can be public                                  
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetNameRelays = "Circuits and Relays" #name of the tab on the google sheet
# dictionary to load Google spreadsheet into (for Circuits and Relays tab)
googleSheetDictRelays = {}
list_of_lists_relays = []
circuit_name_item_id = 0
circuit_on_relay_item_id = 0
circuit_zone_item_id = 0
circuit_space_item_id = 0 
USE_GOOGLE_SHEETS = 1

##################
# open_googlesheet
##################
def open_googlesheet():
# if we're not loading the Google sheet, just return                            
    if (USE_GOOGLE_SHEETS != 1):
        return
# else use our JSON credentials to open the Google Drive sheet                  
    try:
        global list_of_lists_relays
        global circuit_name_item_id
        global circuit_on_relay_item_id
        global circuit_zone_item_id
        global circuit_space_item_id
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']

        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)

        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)

        #creates list of list of every entry on the Circuits and Relays tab
        googleWorksheetRelays = sh.worksheet(googleWorksheetNameRelays)
        list_of_lists_relays = googleWorksheetRelays.get_all_values()

        circuit_name_item_id = find_item(list_of_lists_relays, "Circuit Name")
        circuit_on_relay_item_id = find_item(list_of_lists_relays, "On Relay")
        circuit_zone_item_id = find_item(list_of_lists_relays, "Zone")
        circuit_space_item_id = find_item(list_of_lists_relays, "Space")
  
    except Exception, e:
        print  "error in open_googlesheet: %s" % e

################################
# find_item()
################################
def find_item(mylist, item_name):
    # gets the position of "item" in the sublists & returns                     
    for item in mylist:
        i = 0
        for subitem in item:
            if subitem == item_name:
                item_id = i
                return item_id
            i = i + 1

############################################################                    
#subfinder() takes a list of lists and a pattern. finds pattern in the          
# id_num column of the list of lists. Returns a list of all lists        
# that matched.                                                                 
############################################################                    
def subfinder(mylist, pattern, id_num):
    matches = []
    try:
        #and then gets every item where the device type matches the pattern     
        for item in mylist:
            if pattern in item[id_num]:
                matches.append(item)
        return matches
    except Exception, e:
        print "error in subfinder: %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return blank list                                            
        return []

##################
# GET RELAY ZONES
##################
# gets the list of relay names and pins from the Max files listed in relay_files
def get_relay_zones(zone, zone_items):
    #reads everything from the Circuits and Relays tab                      
    relay_list = []
    if len(list_of_lists_relays) == 0:
        open_googlesheet()
    
#    print "%d google items loaded" % len(list_of_lists_relays)

    for item in list_of_lists_relays:
        zone_item = item[circuit_zone_item_id].replace(':','').lower()
        circuit_on_relay = item[circuit_on_relay_item_id].replace(':','').lower()
        circuit_space = item[circuit_space_item_id]
        circuit_name = item[circuit_name_item_id]        

        #if the zone matches and this circuit is on a relay, get relay info and add it to the list
        if zone.lower() in zone_item.lower() and circuit_on_relay == "yes":
            pin = -1
            #grab the pin from the relay map file
            item = subfinder(zone_items, circuit_name, 0)
            if item != []:
                pin = item[0][1]
            #grab the IP address for this relay
                remote_ip_item = subfinder(relay_ip_list, circuit_name[:3], 0) 
                if (remote_ip_item != []):
                    remote_ip = remote_ip_item[0][1]
                else:
                    remote_ip = ""
                #and return the zone, relay name, pin, and IP plus extras
                item2 = (zone_item, circuit_name, circuit_on_relay, pin, remote_ip, "Relay")
                relay_list.append(item2)

    #and return the list
    return relay_list

##################
# GET RELAY PINS
##################
# gets the list of relay names and pins from the Max files listed in relay_files
#reads file(s) of format "6 /2LB-7, /2LB-7;", grabs pin (6) and name ("2LB-7") and returns each

def get_relay_pins(relay_items):
    for relay_file in relay_files:
        with open(relay_file, 'r') as infile:
            for line in infile:
                line_split = line.split()
                pin = line_split[0]
                name = line_split[1][:-1]
                relay_items.append([name, pin])

    relay_items.sort(key=lambda x: x[0])
    return relay_items

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

#turns PoE on or off
def set_PoE(auto_or_never, remote_ip, switch):
    import subprocess
    try:
        command = [POE_COMMAND, auto_or_never, remote_ip, switch]
        p = subprocess.Popen(command, stdout=subprocess.PIPE)
        for line in p.stdout:
            logger.info( line )

    except Exception, e:
        logger.error( " ERROR: set_PoE error: %s" % e)

#sends messages to Pi or Windows watchdog via UDP
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

#tells a Windows or Mac server to wake on lan (boot from the off state)
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
#run these to start a device of the given type. start_device calls these for the proper type
        
def start_windows(mac_address):
    wake_on_lan(mac_address)
        
def start_pi(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)

def start_arduino(remote_ip, switch):
    set_PoE("auto", remote_ip, switch)

###############
# REBOOT TYPES
###############
#run these to reboot a device of the given type. reboot_device calls these for the proper type
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
#run these to stop a device of the given type. stop_device calls these for the proper type
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
#run these to check inputs before using them    
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
#grabs an item from the DEVICES table in SQLITE, given the ID_NAME        
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
#            logger.info( data ) 
            return data[0]
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   

###############
# START DEVICE
###############
#starts a generic device; checks the type and inputs, then calls the correct start function
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
#stops a generic device; checks the type and inputs, then calls the correct stop function
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
#reboots a generic device; checks the type and inputs, then calls the correct reboot function
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
#start, stops, or reboots the whole show. a little out of date right now...
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
                where_cmd = where_cmd + "AND DESCRIPTION NOT LIKE '%GLOBAL%'"

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
#reboots the whole show. a little out of date right now...
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

###############
# BY ZONE FUNCTIONS
###############            
#turns on/off a given zone. See the valid zones at the top of the file.
def on_by_zone(on_or_off, zone):
    logger.info( " -----turn %s %s" % (on_or_off, zone))
    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""
    
    #zone must be given AND must be in the list of valid zones at the top of the file. otherwise exit
    if zone == "" or zone is None:
        logger.error( " ERROR: no zone given with _by_zone, exiting")
        return

    if zone not in zones_ok_list:
        logger.error( " ERROR: %s is not a valid zone, exiting" % (zone))
        logger.error("Valid zones are: " + str(zones_ok_list))
        return

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
            #select everything for this zone, in the proper boot/shutdown order
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES WHERE ZONE LIKE '" + ('%' + zone + "%'")   
            if args.no_global:
                sql = sql + " AND DESCRIPTION NOT LIKE '%GLOBAL%'"
            if (on_or_off == "on"):
                sql = sql + " ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            else:
                sql = sql + " ORDER BY BOOT_ORDER DESC, ID_NAME ASC"
            cur.execute(sql)
            print "sql " + str(sql)
            data = cur.fetchall()
#            logger.info( data)

            #and step through devices, turning them on/off
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order, space, zone, description) = item
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

                #kill or start each device
                if on_or_off == "on":
                    print device_name
                    start_device(switch_ip, switch_interface, device_type, mac_address)               
                else:
                    print device_name
                    stop_device(remote_ip, switch_ip, switch_interface, device_type)

            #then pause
            #                    time.sleep(DELAY_FOR_PROJECTORS)

            #then kill or start the relays for this zone
            get_relay_pins(relay_list)
            zone_list = get_relay_zones(zone, relay_list)

            if zone_list is not None:
                for item in zone_list:
#                    time.sleep(DELAY_BETWEEN_RELAYS)
                    if (on_or_off == "on"):
                        logger.info("send to " + str(item[1]))
                        msg = "/relays/%s 1" % item[3]
                        send_to_osc(item[4], RELAY_PORT, msg)
                    else:
                        logger.info("send to " + str(item[1]))
                        msg = "/relays/%s 0" % item[3]
                        send_to_osc(item[4], RELAY_PORT, msg)

#on boot order
    #start media server
    #start Pis
    #wait 6 minutes
    #start projectors etc

#off boot order
    #kill the Pis
    #kill the media server
    #wait 6 minutes 
    #kill the projectors etc
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)

#sends OSC messages to the relays/Pis/etc
def send_to_osc(remote_ip, port, cmd):
    if not args.disable:
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
    else:
        logger.info( " -----would send %s to %s" % (cmd, remote_ip))
        c = OSC.OSCClient()
        c.connect((remote_ip, port)) 
        oscmsg = OSC.OSCMessage()
        oscmsg.setAddress(cmd)
        c.send(oscmsg)

#tells the watchdog to kill a process (example: "looping-audio" kills all such functions) on the given Pi
def kill_proc_device(remote_ip, procname):
    if not args.disable:
        cmd = "kill_proc " + procname
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
        send_to_osc(remote_ip, WATCHDOG_PORT, cmd)

#tells the watchdog to spawn a background process (example: "/home/pi/RUNNING/scripts/looping-audio.sh", needs full path) on the given Pi
def start_proc_device(remote_ip, procname):
    if not args.disable:
        cmd = "start_proc " + procname
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
        send_to_osc(remote_ip, WATCHDOG_PORT, cmd)

#kills looping audio for a given Pi
def kill_looping_audio(remote_ip):
    send_to_osc(remote_ip, WATCHDOG_PORT, "kill_proc looping-audio")

#starts looping audio on a given Pi
def start_looping_audio(remote_ip):
    send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio.sh")
    send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio1.sh")
    send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio2.sh")

#sends audio pause or unpause command to the given Pi
def pause(remote_ip, cmd):
    send_to_osc(remote_ip, OSC_PORT, cmd)

#sends "concert mode on" commands to one Pi
def concert_on(remote_ip):
    print "concert on %s" % remote_ip
    pause(remote_ip, PAUSE_COMMAND)
    kill_looping_audio(remote_ip)
    #more goes here, set up the lights

#sends "concert mode off" commands to one Pi
def concert_off(remote_ip):
    print "concert off %s" % remote_ip
    pause(remote_ip, UNPAUSE_COMMAND)
    start_looping_audio(remote_ip)
    #more goes here, send to watchdog to kill process

# turns concert mode (for live shows) on or off. Kills/starts audio on all Pis in Shanty Town, plus sends 
# DMX light control to/from the light console
def concert_mode(on_or_off):
    logger.info( " -----concert mode %s" % on_or_off)
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
        
    try:
        with con:
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, ZONE FROM DEVICES WHERE ZONE LIKE '%SHANTY%'"
            cur.execute(sql)
            data = cur.fetchall()
#            logger.info( data)
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order, zone) = item
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

                if "berry" not in device_type.lower(): 
                    #don't do anything for non-pis
                    continue

                #turn on or off concert mode for each device
                print "%s send concert %s" % (device_name, on_or_off)
                if (on_or_off is "on"):
                    concert_on(remote_ip)
                else:
                    concert_off(remote_ip)

            #light desk control stuff goes here

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

    group.add_argument('--start_proc_device',
                        action='store_true',
                        help='tells the watchdog to spawn a process on device (given ip address in --ip). Expects a program name to start, including full path')

    group.add_argument('--kill_proc_device',
                        action='store_true',
                       help='tells the watchdog to kill a process on device (given ip address in --ip). This uses pkill -f to kill all similar process names, use carefully!')

    group.add_argument('--pause_audio_device',
                        action='store_true',
                        help='pauses audio on a single device (given ip address in --ip)' )

    group.add_argument('--unpause_audio_device',
                        action='store_true',
                        help='unpauses (plays) audio on a single device (given ip address in --ip)' )

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

    group.add_argument('--concert_mode_on',
                        action='store_true',
                        help='enters concert mode (stops shantytown audio & sends light control to console')

    group.add_argument('--concert_mode_off',
                        action='store_true',
                        help='leaves concert mode (starts shantytown audio & sends light control to devices')

    group.add_argument('--concert_mode_on_device',
                        action='store_true',
                        help='enters concert mode (stops shantytown audio & sends light control to console')

    group.add_argument('--concert_mode_off_device',
                        action='store_true',
                        help='leaves concert mode (starts shantytown audio & sends light control to devices')

    group.add_argument('--on_by_zone',
                        action='store_true',
                        help='turns everything in the given zone on, in boot order')


    group.add_argument('--off_by_zone',
                        action='store_true',
                        help='turns everything in the given zone off, in reverse boot order')

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
                        help='Skip global audio devices (devices with "global" in the description)')

    parser.add_argument('--no_delay',
                        action='store_true',
                        help='Skip initial delay')

    parser.add_argument('--ip', 
                        type=str,
                        help='IP address to use with start/stop/reboot_device (i.e. 10.42.16.166)' )

    parser.add_argument('--proc', 
                        type=str,
                        help='Process to use with proc_ commands')

    parser.add_argument('--zone', 
                        type=str,
                        help='Zone to use with _zone commands')
    
    args = parser.parse_args()

    ###############################################
    # sets args for single-device start/stop/reboot
    ###############################################            

    cmd = " Show start/stop script OPENED"

    if args.start_show:
        cmd = cmd + (", starting show")
    if args.stop_show:
        cmd = cmd + (", stopping show")
    if args.stop_device:
        cmd = cmd + (", stopping single device")
    if args.start_device:
        cmd = cmd + (", starting single device")
    if args.pause_audio_device:
        cmd = cmd + (", pausing audio for a single device")
    if args.unpause_audio_device:
        cmd = cmd + (", unpausing (playing) audio for a single device")
    if args.concert_mode_on:
        cmd = cmd + (", enter concert mode")
    if args.concert_mode_off:
        cmd = cmd + (", leave concert mode")
    if args.on_by_zone:
        cmd = cmd + (", on by zone:")
    if args.off_by_zone:
        cmd = cmd + (", off by zone:")
    if args.ip:
        cmd = cmd + (" with IP %s" % args.ip)
    if args.proc:
        cmd = cmd + (" with process %s" % args.proc)
    if args.no_servers:
        cmd = cmd + (", with --no_servers")      
    if args.no_global:
        cmd = cmd + (", with --no_global")      
    if args.switch:
        cmd = cmd + (", limited to switch %s" % args.switch)
    if args.zone:
        cmd = cmd + (", for zone %s" % args.zone)
    logger.info(cmd)

    if args.disable:
        logger.warning(" WARNING: disable (test/dry run) option has been selected.")
    
        #checks whether this is a standalone call or requires arguments
    single_item = False
    if not (args.start_device or args.stop_device or args.reboot_device or args.pause_audio_device or args.unpause_audio_device or args.kill_proc_device or args.start_proc_device):
        single_item = True
        
        if not (single_item):
            if not (args.no_delay):
                cur_delay = 0.0
                delay_string = ""
                logger.info("Delaying %d seconds..." % (INIT_DELAY))
                while (cur_delay <= INIT_DELAY - 1.0):
                    if (int(INIT_DELAY - cur_delay) == 5):
                        delay_string = str(int(INIT_DELAY - cur_delay)) + " seconds left, last chance!"
                    else:
                        delay_string = str(int(INIT_DELAY - cur_delay)) + "..."
                    logger.info(delay_string)
                    time.sleep(5.0)
                    cur_delay = cur_delay + 5.0

    #if we included the IP, check it to make sure it's in the Master Doc
    if args.ip:
        if args.start_device or args.stop_device or args.reboot_device or args.pause_audio_device or args.unpause_audio_device or args.kill_proc_device or args.start_proc_device:
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

        if args.start_proc_device or args.kill_proc_device:
            if args.proc is None or args.proc == "":
                logger.error( " ERROR: --start_proc_device or --kill_proc_device selected but no process name was given with --proc, exiting...")        

    if args.off_by_zone or args.on_by_zone:
        if args.zone is None or args.zone == "":
            logger.error( " ERROR: --off_by_zone or --on_by_zone selected but no zone name was given with --zone. Exiting...")
            logger.error("Valid zones are: " + str(zones_ok_list))

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
    # PAUSE AUDIO ON DEVICE
    ###############
                    
    if args.pause_audio_device:
        pause(remote_ip, PAUSE_COMMAND)

    ###############
    # UNPAUSE AUDIO ON DEVICE
    ###############
                    
    if args.unpause_audio_device:
        pause(remote_ip, UNPAUSE_COMMAND)

    ###############
    # START PROCESS ON DEVICE
    ###############
                    
    if args.start_proc_device:
        start_proc_device(remote_ip, args.proc)

    ###############
    # KILL PROCESS ON DEVICE
    ###############
                    
    if args.kill_proc_device:
        kill_proc_device(remote_ip, args.proc)

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

    #################
    # CONCERT MODE ON
    #################

    if args.concert_mode_on:
        concert_mode("on")

    #################
    # CONCERT MODE OFF
    #################

    if args.concert_mode_off:
        concert_mode("off")

    #################
    # ON BY ZONE
    #################

    if args.on_by_zone:
        if (args.zone):
            on_by_zone("on", args.zone.lower())

    #################
    # OFF BY ZONE
    #################

    if args.off_by_zone:
        if (args.zone):
            on_by_zone("off", args.zone.lower())

    #################
    # CONCERT MODE ON DEVICE
    #################

    if args.concert_mode_on_device:
        concert_on(args.ip)

    #################
    # CONCERT MODE OFF DEVICE
    #################

    if args.concert_mode_off_device:
        concert_off(args.ip)

    exit_func()
