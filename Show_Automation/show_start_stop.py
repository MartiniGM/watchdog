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

#command to use to set PoE on/off
POE_COMMAND = "/Users/Aesir/Documents/watchdog/set_power.exp"
#command to use to send Wake on Lan messages 
WOL_COMMAND = "/Users/Aesir/Documents/watchdog/wolcmd"
DELAY_AFTER_SERVERS = 120.0 #delays 2 minutes between booting windows servers and pis
DELAY_STOP_PI = 15.0 #delays 15 seconds between halting Pis and cutting PoE
DELAY_BETWEEN_DEVICES = 0.5 #delays a half second between stop/starting devices
DELAY_BETWEEN_RELAYS = 1.0 #delays 2 seconds between commands to the relays
DELAY_FOR_PROJECTORS = 360.0 #delays 6 minutes for projector cooldown and/or startup
DELAY_FOR_TVARCH = 120.0 #delays 2 minutes for the TV Arch Pis to start
INIT_DELAY = 30 #delays 30 seconds before starting script so people can cancel
NO_POE = 0
WITH_POE = 1

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX 
LINUX_OSX_DB_FILENAME = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db'

# give a filename for the watchdog's log file here                           
LOG_FILENAME = '/Users/Aesir/Documents/watchdog/Show_Automation/show_start_stop.out'
# give the size for each rolling log segment, in bytes                       
LOG_SIZE = 2000000 #2 MB, in bytes                                            
# give the number of rolling log segments to record before the log rolls over 
LOG_NUM_BACKUPS = 5 # five .out files before they roll over                    

OSC_PORT = 9998 #port to send pause/unpause messages to do-audio on the Pis
RELAY_PORT = 9999 #port to send on/off messages to power relays
WATCHDOG_PORT = 6666 #port to send commands to the watchdog on the Pis
DO_VIDEO_PORT = 9995 #port to send commands to do-video
PAUSE_COMMAND = "/pause" #pause command sent to do-audio on the Pis
UNPAUSE_COMMAND = "/unpause" #unpause command sent to do-audio on the Pis
PAUSE_VIDEO_COMMAND = "/stopall" #pause command sent to do-audio on the Pis
UNPAUSE_VIDEO_COMMAND = "/playnormal" #unpause command sent to do-audio on the Pis

#commands to send to set volume on the Pis
VOLUME_RELATIVE_COMMAND = "/home/pi/RUNNING/scripts/set_volume.py --relative"
VOLUME_DOWN_COMMAND = "/home/pi/RUNNING/scripts/set_volume.py 0%"
VOLUME_UP_COMMAND = "/home/pi/RUNNING/scripts/set_volume.py"

#list of entry videos to be rebooted simultaneously
entry_video_list = ["10.42.27.41", "10.42.27.42"]

#IP address for the POD
POD_ip = "10.42.24.21"
POD_port = 5678 #port it listens for the "calm down" bang
#command to start the POD max patch
POD_command = "c:/Users/bauerrus/Desktop/MasterControlPatch.maxpat"

#command & list to start Ableton on media servers
ableton_play_command = "/live/play"
ableton_port = 9000
ableton_list = ["10.42.18.21", "10.42.20.20", "10.42.20.21", "10.42.21.18", "10.42.22.20", "10.42.24.20", "10.42.24.21", "10.42.25.20", "10.42.25.21"]

#list of Pis with videos to kill/start for concert mode
concert_mode_video_list = ["10.42.22.42", "10.42.23.45", "10.42.22.54", "10.42.23.44"] #benji's dance videos, lighthouse, lucius narrative

#list of Pis with audio to kill/start for concert mode
concert_mode_looping_audio_list = ["10.42.23.40", "10.42.22.50"] #lighthouse, saloon
concert_mode_triggered_audio_list = ["10.42.22.52"] #charter clock
concert_mode_volume_list = ["10.42.22.53", "10.42.22.54", "10.42.22.50"] #bug room, dylan's cartoon room, and 1x shanty global] #, "10.42.23.43", 

#Beamspace server IP & port for DMX control
DMX_IP = "10.42.20.21"
DMX_PORT = 6667

#Show controller IP & port for status readback
SHOW_CONTROLLER_IP = "10.42.16.17"
SHOW_CONTROLLER_PORT = 4001

#list of valid zones
zones_ok_list = ["arcade", "art city", "beamcade", "caves", "forest", "house", "portals", "shanty", "theater", "cade"]
#list of relay prefixes and their IP addresses, for lookup
relay_ip_list = [["2LB", "10.42.0.111"], ["2LC","10.42.0.112"], ["2LD","10.42.0.113"]]

#list of Max relay mapping files. We read these to get the pin for each relay name
relay_files = ["/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LBmapping.txt",
               "/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LCmapping.txt", 
               "/Users/Aesir/Documents/Max 7/Library/Show Automation/Panel-2LDmapping.txt"] 

#empty list for later
relay_pin_list = []

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

####################################
#DUMP DEVICES
####################################
#dumps okay or nonresponsive devices to the log
def dump_devices(okay_or_nonresponsive):
    try:
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)

    try:
        with con:
            cur = con.cursor()
            cur.execute("SELECT * FROM DEVICES ORDER BY DEVICE_TYPE, ID_NAME ")
            rows = cur.fetchall()
            logger.info( " *-*-*-Now dumping:  %s" % (okay_or_nonresponsive))
            i = 0
            for row in rows:
                device_name = str(row[11])
                if device_name is not None and device_name != "None" and device_name != "default":
                    if str(row[5]) == okay_or_nonresponsive:
                        logger.info( str(row[11]) + ":" + str(row[0]) + " last message: " + str(row[2]))
                        i = i + 1

            logger.info( " *-*-*-TOTAL %s: %s" % (okay_or_nonresponsive, str(i)))
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   

#dump_devices("OKAY")
#time.sleep(1.0)
#dump_devices("NONRESPONSIVE")

####################################
#DELAY_WITH_COUNTDOWN
####################################
#delays X seconds, printing a countdown message 
def delay_with_countdown(delay):
    cur_delay = 0.0
    incr = 5.0
    delay_string = ""
    if (delay <= 29.0):
        incr = 5.0
    else:
        if (delay <= 59.0):
            incr = 10.0
        else:
            incr = 30.0
    logger.info("Delaying %d seconds..." % (delay))

    try:
        while (cur_delay <= delay - 1.0):
            delay_string = str(int(delay - cur_delay)) + "..."
            logger.info(delay_string)
            time.sleep(incr)
            cur_delay = cur_delay + incr
    except Exception, e:
        logger.error(  "error in delay_with_countdown: %s" % e)

####################################
# open_googlesheet
####################################
#opens the Google sheet and reads everything from the Circuits and Relays tab
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
        circuit_zone_item_id = find_item(list_of_lists_relays, "Automation Zone")
        circuit_space_item_id = find_item(list_of_lists_relays, "Space")
  
    except Exception, e:
        logger.error(  "error in open_googlesheet: %s" % e)

################################
# find_item()
################################
def find_item(mylist, item_name):
    # gets the position of "item" in the sublists & returns                     
    try:
        for item in mylist:
            i = 0
            for subitem in item:
                if subitem == item_name:
                    item_id = i
                    return item_id
                i = i + 1
    except Exception, e:
        logger.error( "error in find_item: %s" % e)

############################################################                 
#subfinder() takes a list of lists and a pattern. finds pattern in the        
# id_num column of the list of lists. Returns a list of all lists        
# that matched.                                                                
############################################################                  
#returns list of matching items
def subfinder(mylist, pattern, id_num):
    matches = []
    try:
        #and then gets every item where the device type matches the pattern   
        for item in mylist:
#            print "compare " + pattern + " with " + item[id_num]
            if pattern in item[id_num]:
                matches.append(item)
        return matches
    except Exception, e:
        logger.error( "error in subfinder: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        #otherwise return blank list                                          
        return []

##################
# GET ALL RELAYS
##################
# gets the list of relay names and pins from the Max files listed in relay_files. Gets every
# relay as long as it has "yes" / "YES" in the "Circuit On Relay" column
def get_all_relays(relay_pin_items):
    #reads everything from the Circuits and Relays tab                      
    relay_list = []
    if len(list_of_lists_relays) == 0:
        open_googlesheet()
    
    try:
#    print "%d google items loaded" % len(list_of_lists_relays)

        for item in list_of_lists_relays:
            zone_item = item[circuit_zone_item_id].replace(':','').lower()
            circuit_on_relay = item[circuit_on_relay_item_id].replace(':','').lower()
            circuit_space = item[circuit_space_item_id]
            circuit_name = item[circuit_name_item_id]        
            
        #if the zone matches and this circuit is on a relay, get relay info and add it to the list
            if circuit_on_relay == "yes":
                pin = -1
            #grab the pin from the relay map file
                item = subfinder(relay_pin_items, circuit_name, 0)
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

    except Exception, e:
        logger.error( "error in get_all_relays: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return []

##################
# GET RELAY ZONES
##################
# gets the list of relay names and pins from the Max files listed in relay_files.  Gets every
# relay for the given Automation Zone, as long as it has "yes" / "YES" in the "Circuit On Relay" column
def get_relay_zones(zone, zone_items):
    #reads everything from the Circuits and Relays tab                      
    relay_list = []
    if len(list_of_lists_relays) == 0:
        open_googlesheet()
    
#    print "%d google items loaded" % len(list_of_lists_relays)

    try:

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

    except Exception, e:
        logger.error( "error in get_relay_zones: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return []

##################
# GET SINGLE RELAY
##################
# gets the list of relay names and pins from the Max files listed in relay_files.  Gets a relay for the given Relay Name, as long as it has "yes" / "YES" in the "Circuit On Relay" column
def get_single_relay(relay, relay_items):
    #reads everything from the Circuits and Relays tab                      
    relay_list = []
    if len(list_of_lists_relays) == 0:
        open_googlesheet()
    
#    print "%d google items loaded" % len(list_of_lists_relays)

    try:

        for item in list_of_lists_relays:
            zone_item = item[circuit_zone_item_id].replace(':','').lower()
            circuit_on_relay = item[circuit_on_relay_item_id].replace(':','').lower()
            circuit_space = item[circuit_space_item_id]
            circuit_name = item[circuit_name_item_id]        
#            print relay.upper() + " '" + circuit_name + "'"

        #if the zone matches and this circuit is on a relay, get relay info and add it to the list
            if circuit_name.endswith(relay.upper()) and circuit_on_relay == "yes":
                pin = -1
            #grab the pin from the relay map file
                item = subfinder(relay_items, circuit_name, 0)
#                print item
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

    except Exception, e:
        logger.error( "error in get_relay_zones: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return []

##################
# GET RELAY PINS
##################
# gets the list of relay names and pins from the Max files listed in relay_files
#reads file(s) of format "6 /2LB-7, /2LB-7;", grabs pin (6) and name ("2LB-7") and returns each

def get_relay_pins(relay_items):
    try:
        for relay_file in relay_files:
            with open(relay_file, 'r') as infile:
                for line in infile:
                    line_split = line.split()
                    pin = line_split[0]
                    name = line_split[1][:-1]
                    relay_items.append([name, pin])

        relay_items.sort(key=lambda x: x[0])
        return relay_items
    except Exception, e:
        logger.error(  "error in get_relay_pins: %s" % e)
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

###################
# PoE, WOL, UDPSEND
###################
#turns PoE on or off
def set_PoE(auto_or_never, remote_ip, switch, device_name, description):
    import subprocess
    if not args.disable:
        try:
            logger.info( "%s %s set PoE %s for %s %s" % (device_name, description, auto_or_never, remote_ip, switch))
            command = [POE_COMMAND, auto_or_never, remote_ip, switch]
            p = subprocess.Popen(command, stdout=subprocess.PIPE)
            for line in p.stdout:
                logger.info( line )

        except Exception, e:
            logger.error( " ERROR: set_PoE error: %s" % e)
    else:
        logger.info( "would set %s %s PoE %s for %s %s" % (device_name, description, auto_or_never, remote_ip, switch))

#sends messages to Pi or Windows watchdog via UDP
def udpsend(message, remote_ip, port):
    if not args.disable:
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
    else:
        logger.info( " would send " + message + " to " + remote_ip )

#tells a Windows or Mac server to wake on lan (boot from the off state)
def wake_on_lan(mac_address):
    import subprocess
    if not args.disable:
        try:
            logger.info( " sending WoL to %s" % mac_address )
            command = [WOL_COMMAND, mac_address, "255.255.255.255",
                   "255.255.255.255", "4343"]
            p = subprocess.Popen(command, stdout=subprocess.PIPE)
            for line in p.stdout:
                logger.info(line)

        except Exception, e:
            logger.error( " ERROR: set_PoE error: %s" % e)
    else:
        logger.info( " would send WoL to %s" % mac_address )


###############
# START TYPES
###############
#run these to start a device of the given type. start_device calls these for the proper type
def start_windows(mac_address):
    wake_on_lan(mac_address)
        
def start_pi(remote_ip, switch, device_name, description):
    set_PoE("auto", remote_ip, switch, device_name, description)

def start_arduino(remote_ip, switch, device_name, description):
    set_PoE("auto", remote_ip, switch, device_name, description)

###############
# REBOOT TYPES
###############
#run these to reboot a device of the given type. reboot_device calls these for the proper type
def reboot_windows(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_pi(remote_ip):
    udpsend("reboot now", remote_ip, 6666)

def reboot_arduino(switch_ip, switch_interface, device_name, description, delay):
    set_PoE("never", switch_ip, switch_interface, device_name, description)
    time.sleep(delay)
    set_PoE("auto", switch_ip, switch_interface, device_name, description)

###############
# STOP TYPES
###############
#run these to stop a device of the given type. stop_device calls these for the proper type
def stop_arduino(remote_ip, switch, device_name, description):
    set_PoE("never", remote_ip, switch, device_name, description)

def stop_windows(remote_ip):
    udpsend("halt now", remote_ip, 6666)

def stop_pi(remote_ip, switch_ip, switch_interface, delay, device_name, description, poe_flag):
    udpsend("halt now", remote_ip, 6666)
    if (poe_flag == WITH_POE):
        time.sleep(delay)
        set_PoE("never", switch_ip, switch_interface, device_name, description)

###############
# CHECK FUNCTIONS
###############
#run these to check inputs before using them    
def check_remoteip(remote_ip):
    if remote_ip is None or remote_ip == "":
        return 1
    return 0

def check_macaddress(mac_address):
    if mac_address is None or mac_address == "":
       # logger.error( " ERROR: MAC address not set! Exiting...")
        return 1
    return 0
        
def check_switch(remote_ip, switch):
    if remote_ip is None or remote_ip == "":
        #logger.error( " ERROR: switch IP not set! Exiting...")
        return 1
    if switch is None or switch == "":
        #logger.error( " ERROR: switch interface not set! Exiting...")
        return 2
    return 0

def check_remoteip_switch(remote_ip, switch, switch_interface):
    if remote_ip is None or remote_ip == "":
        #logger.error( " ERROR: remote IP not set! Exiting...")
        return 1
    if switch is None or switch == "":
        #logger.error( " ERROR: switch IP not set! Exiting...")
        return 2
    if switch_interface is None or switch_interface == "":
        #logger.error( " ERROR: switch interface not set! Exiting...")
        return 3
    return 0

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
            logger.info( data ) 
            return data[0]
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   

###############
# START DEVICE
###############
#starts a generic device; checks the type and inputs, then calls the correct start function
def start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description):        
    if "berry" in device_type.lower() or "cubi" in device_type.lower(): 
#        print "start pi"
        ret = check_switch(switch_ip, switch_interface)
        if (ret != 0):
            logger.info( "ERROR: Switch info not set: %s %s %s" % (device_name, description, switch_ip, switch_interface))
            return
        logger.info( " would start pi: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
        time.sleep(DELAY_BETWEEN_DEVICES)
        if not args.disable:
            logger.info(" now starting... %s %s %s %s" %  (device_name, description, switch_ip, switch_interface))
            start_pi(switch_ip, switch_interface, device_name, description)
    else:
        if "indow" in device_type.lower():
#            print "start windows"
            ret = check_macaddress(mac_address)
            if (ret != 0):
                logger.info( "ERROR: MAC address not set!")
                return
            logger.info(" would start windows: %s %s %s" % (device_name, description, mac_address))
            time.sleep(DELAY_BETWEEN_DEVICES)
            if (not args.disable) and not (args.no_servers):
                logger.info("now starting... %s %s %s" % (device_name, description, mac_address))         
                start_windows(mac_address)
            else:
                if args.no_servers:
                    logger.info( " skipping device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():
#                print "start arduino"                    
                ret = check_switch(switch_ip, switch_interface)
                if (ret != 0):
                    logger.info("ERROR: Switch info not set: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    return
                logger.info(" would start arduino: %s %s %s %s" % (device_name, description,  switch_ip, switch_interface))
                time.sleep(DELAY_BETWEEN_DEVICES)
                if not args.disable:
                    logger.info(" now starting... %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    start_arduino(switch_ip, switch_interface, device_name, description)
            else:
                if "mac" in device_type.lower():
                    print "mac"
                    start_windows(mac_address)
                else:
                    logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# STOP DEVICE
###############
#stops a generic device; checks the type and inputs, then calls the correct stop function
def stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, poe_flag):
    if "berry" in device_type.lower() or "cubi" in device_type.lower(): 
#        print "stop pi"
        ret = check_remoteip_switch(remote_ip, switch_ip, switch_interface)
        if (ret != 0):
            logger.info( "ERROR: %s %s Remote IP %s or switch info %s %s not set!" % (device_name, description, remote_ip, switch_ip, switch_interface))
            return
            #print error
        logger.info( " would stop pi: %s %s %s %s %s" % (device_name, description, remote_ip, switch_ip, switch_interface))
        time.sleep(DELAY_BETWEEN_DEVICES)
        if not args.disable:
            logger.info( " now stopping... %s %s %s %s %s" % (device_name, description, remote_ip, switch_ip, switch_interface))
            stop_pi(remote_ip, switch_ip, switch_interface, DELAY_STOP_PI, device_name, description, poe_flag)    
    else:
        if "indow" in device_type.lower():
#            print "stop windows"
            ret = check_remoteip(remote_ip)
            if (ret != 0):
                logger.info( "ERROR: Remote IP not set!")
                return
            logger.info( " would stop windows: %s %s %s" % (device_name, description, remote_ip))
            time.sleep(DELAY_BETWEEN_DEVICES)

            if not args.disable and not args.no_servers:
                logger.info( "now stopping... %s %s %s" % (device_name, description, remote_ip))
                stop_windows(remote_ip)
            else:
                if args.no_servers:
                    logger.info(" skip device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
#                logger.warning( "stop arduino")
                ret = check_switch(switch_ip, switch_interface)
                if (ret != 0):
                    logger.info( "ERROR: Switch info not set: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    return
                logger.info( " would stop arduino: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                time.sleep(DELAY_BETWEEN_DEVICES)

                if not args.disable:
                    logger.info( " now stopping... %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    stop_arduino(switch_ip, switch_interface)
            else:
                if "mac" in device_type.lower():
                    logger.info("would stop mac: %s %s %s" % (device_name, description, remote_ip))
                    if not args.disable:
                        logger.info("now stopping mac: %s %s %s" % (device_name, description, remote_ip))
                        stop_windows(remote_ip)
                else:
                    logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# REBOOT DEVICE
###############
#reboots a generic device; checks the type and inputs, then calls the correct reboot function
def reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description):
    if "berry" in device_type.lower() or "cubi" in device_type.lower(): 
#        print "reboot pi"
        ret = check_remoteip(remote_ip)
        if (ret != 0):
            logger.info( "ERROR: Remote IP not set!")
            return
        logger.info( " would reboot pi: %s %s %s" % (device_name, description, remote_ip))

        time.sleep(DELAY_BETWEEN_DEVICES)

        if not args.disable:
            logger.info( " now rebooting... %s %s %s" % (device_name, description, remote_ip))
            reboot_pi(remote_ip)        
    else:
        if "indow" in device_type.lower():
#            print "reboot windows"       
            ret = check_remoteip(remote_ip)
            if (ret != 0):
                logger.info( "ERROR: Remote IP not set!")
                return
            logger.info( " would reboot windows: %s %s %s" % (device_name, description, remote_ip))
            time.sleep(DELAY_BETWEEN_DEVICES)
        
            if not args.disable and not args.no_servers:
                logger.info( " now rebooting... %s %s %s" % (device_name, description, remote_ip))
                reboot_windows(remote_ip)
            else:
                if args.no_servers:
                    logger.info( " skip device due to --no_servers")
        else:
            if "duino" in device_type.lower() or "eensy" in device_type.lower():            
#                print "reboot arduino"
                ret = check_switch(switch_ip, switch_interface)
                if (ret != 0):
                    logger.info( "ERROR: Switch info not set: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    return
                time.sleep(DELAY_BETWEEN_DEVICES)
                logger.info(" would reboot arduino: %s %s %s %s" % (device_name, description, switch_ip, switch_interface))

                if not args.disable:
                    logger.info(" now rebooting... %s %s %s %s" % (device_name, description, switch_ip, switch_interface))
                    reboot_arduino(switch_ip, switch_interface, device_name, description, 2)
            else:
                if "mac" in device_type.lower():
                    print "mac"
                    reboot_windows(remote_ip)
                else:
                    logger.error( " ERROR: type %s not matched, exiting..." % device_type)

###############
# RELAYS ON OFF
###############
#turns on/off all relays (for the given zone, or "" for no zone) given a list of relays  
def relays_on_off(on_or_off, zone_list, zone): 
    
    if (args.no_relays or args.with_relays == 0):
        logger.warning("--no_relays, or --with_relays not found, skipping relays")
        return

    if (zone.lower() == "art city" and on_or_off == "on") or (on_or_off == "on" and zone == "") :
        #the TV arch has relay dependencies because the Pi controllers
        #are on relays, not PoE. Move their items to the front of the 
        #list, boot them first, then wait for them to boot before
        #powering the rest of the relays
        if zone_list is None:
            return
        for item in zone_list:
            if item[1] == "2LD-11":        
                zone_list.insert(0, zone_list.pop(zone_list.index(item)))
            if item[1] == "2LD-15":
                zone_list.insert(0, zone_list.pop(zone_list.index(item)))
        print "---after"
        print zone_list
        #turn on the TV arch Pis first
        item = zone_list[0]
        logger.info("send to " + str(item[1]))
        msg = "/relay %s 1" % item[3]
        send_to_osc(item[4], RELAY_PORT, msg)
        time.sleep(DELAY_BETWEEN_RELAYS)
        item = zone_list[1]
        logger.info("send to " + str(item[1]))
        msg = "/relay %s 1" % item[3]
        send_to_osc(item[4], RELAY_PORT, msg)
        delay_with_countdown(DELAY_FOR_TVARCH)
        #then the remainder of the list
        for item in zone_list[2:]:
            time.sleep(DELAY_BETWEEN_RELAYS)
            logger.info("send to " + str(item[1]))
            msg = "/relay %s 1" % item[3]
            send_to_osc(item[4], RELAY_PORT, msg)
        return
    
    #if this isn't art city or we're turning art city off, just do each
    if zone_list is not None:
        for item in zone_list:
            time.sleep(DELAY_BETWEEN_RELAYS)
            if (on_or_off == "on"):
                logger.info("send to " + str(item[1]))
                msg = "/relay %s 1" % item[3]
                send_to_osc(item[4], RELAY_PORT, msg)
            else:
                logger.info("send to " + str(item[1]))
                msg = "/relay %s 0" % item[3]
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

###############
# RELAYS ON OFF
###############
#turns on/off a given relay (needs testing!)  
def on_off_single_relay(on_or_off, relay_name):

    if relay_name is None or relay_name == "":
        logger.error("No relay name given for on_off_single_relay!");
        return

        #then kill or start the given relay 

    if (args.no_relays or args.with_relays == 0):
        logger.warning("--no_relays, or --with_relays not found, skipping relays")
        return
      
    get_relay_pins(relay_pin_list)
    relay_list = get_single_relay(relay_name, relay_pin_list)
#    print relay_list
    if len(relay_list) >= 1:
        item = relay_list[0]

        if (on_or_off == "on"):
            logger.info("would send to " + str(item[1]))
            msg = "/relay %s 1" % item[3]
            print msg
            send_to_osc(item[4], RELAY_PORT, msg)
        else:
            logger.info("would send to " + str(item[1]))
            msg = "/relay %s 0" % item[3]
            print msg
            send_to_osc(item[4], RELAY_PORT, msg)
    else:
        logger.warning( "relay %s not found!" % relay_name)

###############
# start_switch
###############
#starts/stops/reboots everything on a given switch IP
def start_switch(command, limit_to_switch_ip, type):
    print "start switch"
    if limit_to_switch_ip is None or limit_to_switch_ip == "" or limit_to_switch_ip == " ":
        logger.warning("%s switch called without a switch! Exiting..." % command)
        return
    else:
        start_stop_reboot_show(command, limit_to_switch_ip, type)

###############
# start_by_type
###############
#starts/stops/reboots a given type "windows", "arduino", or "raspberry pi"
def start_by_type(command, limit_to_switch_ip, type):
    print "start by type"
    if type is None or type == "" or type == " ":
        logger.warning("%s type called without a type! Exiting..." % command)
        return
    else:
        remote_ip = ""
        mac_address = ""
        switch_interface = ""
        device_type = ""
        start_pi_type = 0
        start_arduino_type = 0
        start_windows_type = 0

        if limit_to_switch_ip is None:
            limit_to_switch_ip = ""

        cmd = " -----%s by type %s" % (command, type)
        if args.disable:
            cmd = cmd + ", ***START/STOP DISABLED"

        logger.info(cmd)       

        if type != None and type != "":
            logger.info( "for type %s %s" % (type.lower(), device_type.lower()))
            if "berry" in type.lower() or "pi" in type.lower() or "cubi" in device_type.lower():
                print "set pi type"
                start_pi_type = 1
            if "indows" in type.lower() or "mac" in type.lower():
                print "set windows type"
                start_windows_type = 1
            if "duino" in type.lower():
                print "set arduino type"
                start_arduino_type = 1

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

                sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES"
                if args.no_global:
                    sql = sql + " WHERE DESCRIPTION NOT LIKE '%GLOBAL%'"
                if ("start" in command):
                    sql = sql + " ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
                else:
                    if ("stop" in command or "reboot" in command):
                        sql = sql + " ORDER BY BOOT_ORDER DESC, ID_NAME ASC"
                    else:
                        logger.error( " ERROR: command %s not recognized", command)
                        return

                cur.execute(sql)
                data = cur.fetchall()
            
                done_server_delay = 0 #initialize this to 0 so we know when we started
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

                    if device_name is None:
                        device_name = ""

                    if device_type is None:
                        device_type = ""

                    if "software" in device_type.lower() or boot_order == "" or boot_order is None:
                        continue

                    if command is "start":
                    #start each item
                        if start_pi_type == 1 and "berry" in device_type.lower() or "cubi" in device_type.lower():
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)
                            continue
                        if start_windows_type == 1 and ("indow" in device_type.lower() or "mac" in device_type.lower()):
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)
                            continue
                        if start_arduino_type == 1 and "duino" in device_type.lower():
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)
                            continue

                    if command is "stop":
                    #stop each item
                        if start_pi_type == 1 and "berry" in device_type.lower() or "cubi" in device_type.lower():
                            stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, WITH_POE)
                            continue
                        if start_windows_type == 1 and ("indow" in device_type.lower() or "mac" in device_type.lower()):
                            stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, WITH_POE)
                            continue
                        if start_arduino_type == 1 and "duino" in device_type.lower():
                            stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, WITH_POE)
                            continue
                    if command is "reboot":
                    #reboot each item
                        if start_pi_type == 1 and "berry" in device_type.lower() or "cubi" in device_type.lower():
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                            continue
                        if start_windows_type == 1 and ("indow" in device_type.lower() or "mac" in device_type.lower()):
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                            continue
                        if start_arduino_type == 1 and "duino" in device_type.lower():
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                            continue
        except lite.Error, e:
            logger.error(" ERROR: SQL error! %s" % e)   
        except Exception, e:
            logger.error(" ERROR: non-SQL error %s" % e)

##############################
# START/STOP/REBOOT SHOW
##############################            
#start, stops, or reboots the whole show.
def start_stop_reboot_show(command, limit_to_switch_ip, type):
    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""
    start_pi_type = 0
    start_arduino_type = 0
    start_windows_type = 0

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

            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES"
            if args.no_global:
                sql = sql + " WHERE DESCRIPTION NOT LIKE '%GLOBAL%'"
            if ("start" in command):
                sql = sql + " ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            else:
                if ("stop" in command or "reboot" in command):
                    sql = sql + " ORDER BY BOOT_ORDER DESC, ID_NAME ASC"
                else:
                    logger.error( " ERROR: command %s not recognized", command)
                    return

            cur.execute(sql)
            data = cur.fetchall()
            
            done_server_delay = 0 #initialize this to 0 so we know when we started
            poe_list = []

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

                if device_name is None:
                    device_name = ""

                if device_type is None:
                    device_type = ""

                if description is None:
                    description = ""

                if "software" in device_type.lower() or boot_order == "" or boot_order is None:
                    if device_name != "" and device_name != "default":
                        print "skipping " + str(device_name)
                    continue

                if command is "start":
                    print "would start " + str(device_name)
                    #otherwise just start stuff
                    if "berry" in device_type.lower() or "cubi" in device_type.lower() and done_server_delay == 0:
                        #delays before the first Pi
                        done_server_delay = 1;
                        delay_with_countdown(DELAY_AFTER_SERVERS)

                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)
                    else:
                        if boot_order != "" and boot_order is not None:
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)
                        
                if command is "stop":
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            #temporarily rebooting pis instead of stopping them
                            if "berry" in device_type.lower() and "video" in description.lower():
                                logger.warning("reboot video pi instead")
                                reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                            else:
                                if "berry" in device_type.lower() or "cubi" in device_type.lower():
                                    poe_list.append([remote_ip, switch_ip, switch_interface, device_type, description])
                                logger.warning("nope, stopping")
                                stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, NO_POE)
                    else:
                        if boot_order != "" and boot_order is not None:
                            if "berry" in device_type.lower() or "cubi" in device_type.lower():
                                poe_list.append([remote_ip, switch_ip, switch_interface, device_type, description])
                            stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, NO_POE)

                if command is "reboot":
                    #reboot each item
                    if limit_to_switch_ip is not None and limit_to_switch_ip != "":
                        if limit_to_switch_ip in switch_group:
                            reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                        else:
                            if boot_order != "" and boot_order is not None:
                                reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)


            # then kill every Pi PoE
            if command is "stop":
                if len(poe_list) > 0:
                    logger.warning("delay %d seconds to make sure Pis halt" % DELAY_STOP_PI)
                    time.sleep(DELAY_STOP_PI)

                for item in poe_list:
                    set_PoE("never", item[0], item[1], "", item[4])

            if command is "stop" or command is "start":
                if command is "stop":
                    on_or_off = "off"
                else:
                    on_or_off = "on"
                #then kill or start all relays 

                if (args.no_relays or args.with_relays == 0):
                    logger.warning("--no_relays, or --with_relays not found, skipping relays")
                    return

            #then pause before stopping/starting the relays
                logger.warning("Pausing before %s-ing relays" % command)
                time.sleep(DELAY_FOR_PROJECTORS)

                get_relay_pins(relay_pin_list)
                relay_list = get_all_relays(relay_pin_list)

                relays_on_off(on_or_off, relay_list, "")

    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)   
    except Exception, e:
        logger.error(" ERROR: non-SQL error %s" % e)

##############################
# REBOOT NONRESPONSIVE DEVICES
##############################             
#reboots nonresponsives in the whole show.
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
                        reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                else:
                    reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e) 

#####################
# BY ZONE FUNCTIONS
#####################            
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
            data = cur.fetchall()

            poe_list = []

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
                    if boot_order != "" and boot_order is not None:
                        if remote_ip != "10.42.21.18":
                            logger.info( device_name)
                            start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)       
                else:
                    if boot_order != "" and boot_order is not None:
                        if remote_ip != "10.42.21.18":
                            #temporarily rebooting pis instead of stopping them
                            if "berry" in device_type.lower() and "video" in description.lower():
                                logger.warning("reboot video pi instead")
                                reboot_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description)
                            else:
                                if "berry" in device_type.lower() or "cubi" in device_type.lower():
                                    poe_list.append([remote_ip, switch_ip, switch_interface, device_type, description])
                                logger.info( device_name)
                                stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, NO_POE)

            # then kill every Pi PoE
            if on_or_off == "off":
                if len(poe_list) > 0:
                    logger.warning("delay %d seconds to make sure Pis halt" % DELAY_STOP_PI)
                    time.sleep(DELAY_STOP_PI)

                for item in poe_list:
                    set_PoE("never", item[0], item[1], "", item[4])

            #then kill or start the relays for this zone
            if (args.no_relays or args.with_relays == 0):
                logger.warning("--no_relays, or --with_relays not found, skipping relays")
                return
            #then pause
            logger.warning("Pausing before %s-ing relays" % on_or_off)
            time.sleep(DELAY_FOR_PROJECTORS)
            get_relay_pins(relay_pin_list)
            zone_list = get_relay_zones(zone, relay_pin_list)
            print "zone is %s" % zone.lower()

            relays_on_off(on_or_off, zone_list, zone)
        
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)

###############
# BY SPACE FUNCTIONS
###############            
#turns on/off a given space. See the valid zones at the top of the file.
def on_by_space(on_or_off, space):
    logger.info( " -----turn %s %s" % (on_or_off, space))
    remote_ip = ""
    mac_address = ""
    switch_interface = ""
    device_type = ""
    
    #space must be given
    if space == "" or space is None:
        logger.error( " ERROR: no space given with _by_space, exiting")
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
            #select everything for this space, in the proper boot/shutdown order
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES WHERE SPACE LIKE '" + ('%' + space + "%'")   
            if args.no_global:
                sql = sql + " AND DESCRIPTION NOT LIKE '%GLOBAL%'"
            if (on_or_off == "on"):
                sql = sql + " ORDER BY BOOT_ORDER ASC, ID_NAME ASC"
            else:
                sql = sql + " ORDER BY BOOT_ORDER DESC, ID_NAME ASC"
            cur.execute(sql)
            data = cur.fetchall()

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
                    logger.info( device_name)
                    start_device(switch_ip, switch_interface, device_type, mac_address, device_name, description)               
                else:
                    logger.info( device_name)
                    stop_device(remote_ip, switch_ip, switch_interface, device_type, device_name, description, WITH_POE)
#by space doesn't do relays
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)

#sends OSC messages to the relays/Pis/etc
def send_to_osc(remote_ip, port, cmd):
    if not args.disable:
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
        try:
            c = OSC.OSCClient()
            c.connect((remote_ip, port)) 
            oscmsg = OSC.OSCMessage()
            oscmsg.setAddress(cmd)
            c.send(oscmsg)
        except Exception, e:
            logger.error( "error in send_to_osc: %s" % e)
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                logger.error( "     in %s on line %d" % (fname, lineno))
    else:
        logger.info( " -----would send %s to %s" % (cmd, remote_ip))
                
#tells the watchdog to kill a process (example: "looping-audio" kills all such functions) on the given Pi
def kill_proc_device(remote_ip, procname):
    if not args.disable:
        cmd = "kill_proc " + procname
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
        udpsend(cmd, remote_ip, WATCHDOG_PORT)

#tells the watchdog to spawn a background process (example: "/home/pi/RUNNING/scripts/looping-audio.sh", needs full path) on the given Pi
def start_proc_device(remote_ip, procname):
    if not args.disable:
        cmd = "start_proc " + procname
        logger.info( " -----sending %s to %s" % (cmd, remote_ip))
        udpsend(cmd, remote_ip, WATCHDOG_PORT)

#restarts the max patch on the POD (sends "calm down" message and then stops/starts the max patch)
def restart_pod():
    send_to_osc(POD_ip, POD_port, "restart pod")
    time.sleep(4.0)
    reboot_windows(POD_ip)
#    start_proc_device(POD_ip, POD_command)

#kills looping audio for a given Pi
def kill_looping_audio(remote_ip):
    if not args.disable:
        send_to_osc(remote_ip, WATCHDOG_PORT, "kill_proc looping-audio")

#starts looping audio on a given Pi
def start_looping_audio(remote_ip):
    if not args.disable:
        send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio.sh")
        send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio1.sh")
        send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio2.sh")
        send_to_osc(remote_ip, WATCHDOG_PORT, "start_proc /home/pi/RUNNING/scripts/looping-audio3.sh")

#starts looping video on a given Pi
def start_looping_video(remote_ip):
    if not args.disable:
        send_to_osc(remote_ip, DO_VIDEO_PORT, "/playnormal")
        msg = "/watchdog_status %s" % "watchdog got /playnormal for do-video" 
        send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)

#kills looping video on a given Pi
def stop_looping_video(remote_ip):
    #send do-video a stop command
    if not args.disable:
        send_to_osc(remote_ip, DO_VIDEO_PORT, "/stopall")
        msg = "/watchdog_status %s" % "watchdog got /stopall for do-video" 
        send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)

#sends audio pause or unpause command to the given Pi
def pause(remote_ip, cmd):
    if not args.disable:
        send_to_osc(remote_ip, OSC_PORT, cmd)

#sends volume setting to the given Pi
def volume_relative_pi(remote_ip, volume_amount):
    if volume_amount is None: 
        logger.info("Error: no --volume given with --volume_relative")
        return

    if volume_amount == "":
        logger.info("Error: no --volume given with --volume_relative")
        return

    if not args.disable:
        cmd = "start_proc " + VOLUME_RELATIVE_COMMAND + " " + volume_amount
        send_to_osc(remote_ip, WATCHDOG_PORT, cmd)
        time.sleep(0.5)
    else:
        log_info = "would send volume relative to " + remote_ip + " as " + volume_amount
        logger.info(log_info)

#sends volume off to the given Pi
def volume_off_pi(remote_ip):
    if not args.disable:

        cmd = "start_proc " + VOLUME_DOWN_COMMAND
        send_to_osc(remote_ip, WATCHDOG_PORT, cmd)
        time.sleep(0.5)
    else:
        logger.info("would send volume down to %s" % remote_ip)

#sends volume on (standard presets) to the given Pi
def volume_on_pi(remote_ip):
    if not args.disable:
        cmd = "start_proc " + VOLUME_UP_COMMAND
        send_to_osc(remote_ip, WATCHDOG_PORT, cmd)
        time.sleep(0.5)
    else:
        logger.info("would send volume up to %s" % remote_ip)

#sends volume on (standard presets) to all non global Pis
def volume_on_allpis():
    try:
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)

    try:
        with con:
            #select all the Pis
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES WHERE DEVICE_TYPE LIKE '%BERRY%' AND DESCRIPTION NOT LIKE '%GLOBAL%'" 
            cur.execute(sql)
            data = cur.fetchall()

        #and step through devices, turning volume on
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order, space, zone, description) = item

                if device_name is not None and device_name.lower() != "default":
                    if not args.disable:
                        logger.info("sending volume up to %s: %s" % (remote_ip, device_name))
                        cmd = "start_proc " + VOLUME_UP_COMMAND
                        time.sleep(0.5)
                    else:
                        logger.info("would send volume up to %s: %s" % (remote_ip, device_name))
    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)

#sends volume on (relative volume given) to all non global Pis
def volume_relative_allpis(volume_amount):
    if volume_amount is None:
        logger.info("Error: no --volume given with --volume_relative")
        return

    if volume_amount == "":
        logger.info("Error: no --volume given with --volume_relative")
        return

    try:
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)
    except Exception, e:
        logger.error( " ERROR: Can't connect to demosdb! %s" % e)

    try:
        with con:
            #select all the Pis
            cur = con.cursor()
            sql = "SELECT ID_NAME, DEVICE_NAME, MAC_ADDRESS, SWITCH_INTERFACE, DEVICE_TYPE, BOOT_ORDER, SPACE, ZONE, DESCRIPTION FROM DEVICES WHERE DEVICE_TYPE LIKE '%BERRY%' AND DESCRIPTION NOT LIKE '%GLOBAL%'" 
            cur.execute(sql)
            data = cur.fetchall()

        #and step through devices, turning volume on
            for item in data:
                (remote_ip, device_name, mac_address, switch_interface, device_type, boot_order, space, zone, description) = item

                if device_name is not None and device_name.lower() != "default":
                    if not args.disable:
                        logger.info("sending volume %s to %s: %s" % (volume_amount, remote_ip, device_name))

                        cmd = "start_proc " + VOLUME_RELATIVE_COMMAND + " " + volume_amount
                        time.sleep(0.5)
                    else:
                        logger.info("would send volume %s to %s: %s" % (volume_amount, remote_ip, device_name))

    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e)

#sends "concert mode on" commands to one Pi
def concert_on_video(remote_ip):
    if not args.disable:
        logger.info( "concert on, kill video on %s" % remote_ip)
        stop_looping_video(remote_ip)
    else:
        logger.info( "would send concert on, kill video %s" % remote_ip)

#sends "concert mode on" commands to one Pi
def concert_on_video(remote_ip):
    if not args.disable:
        logger.info( "concert on, kill video on %s" % remote_ip)
        stop_looping_video(remote_ip)
    else:
        logger.info( "would send concert on, kill video %s" % remote_ip)

#sends "concert mode off" commands to one Pi
def concert_off_video(remote_ip):
    if not args.disable:
        logger.info( "concert off, start video %s" % remote_ip)
        start_looping_video(remote_ip)
    else:
        logger.info( "would send concert off, start video %s" % remote_ip)

#sends "concert mode on" commands to one Pi
def concert_on_audio_looping(remote_ip):
    if not args.disable:
        logger.info( "concert on, kill looping audio %s" % remote_ip)
        kill_looping_audio(remote_ip)
    else:
        logger.info( "would send concert on, kill triggered audio %s" % remote_ip)

def concert_on_audio_triggered(remote_ip):
    if not args.disable:
        logger.info( "concert on, kill triggered audio %s" % remote_ip)
        pause(remote_ip, PAUSE_COMMAND)
    else:
        logger.info( "would send concert on, kill triggered audio %s" % remote_ip)

#sends "concert mode off" commands to one Pi
def concert_off_audio_looping(remote_ip):
    if not args.disable:
        logger.info( "concert off, start looping audio %s" % remote_ip)
        start_looping_audio(remote_ip)
    else:
        logger.info( "would send concert off, start looping audio %s" % remote_ip)

#sends "concert mode off" commands to one Pi
def concert_off_audio_triggered(remote_ip):
    if not args.disable:
        logger.info( "concert off, start audio %s" % remote_ip)
        pause(remote_ip, UNPAUSE_COMMAND)
    else:
        logger.info( "would send concert off, start audio %s" % remote_ip)

#sends "concert mode on" commands to one Pi
def concert_on(remote_ip):
    if not args.disable:
        logger.info( "concert on %s" % remote_ip)
        if remote_ip in concert_mode_video_list:
            concert_on_video(remote_ip)
        if remote_ip in concert_mode_triggered_audio_list:
            concert_on_audio_triggered(remote_ip)
        if remote_ip in concert_mode_looping_audio_list:
            concert_on_audio_looping(remote_ip)
        if remote_ip in concert_mode_volume_list:
            concert_on_volume(remote_ip)
    else:
        logger.info( "would send concert on %s" % remote_ip)

#sends "concert mode off" commands to one Pi
def concert_off(remote_ip):
    if not args.disable:
        logger.info( "concert off %s" % remote_ip)
        if remote_ip in concert_mode_video_list:
            concert_off_video(remote_ip)
        if remote_ip in concert_mode_triggered_audio_list:
            concert_off_audio_triggered(remote_ip)
        if remote_ip in concert_mode_looping_audio_list:
            concert_off_audio_looping(remote_ip)
        if remote_ip in concert_mode_volume_list:
            concert_off_volume(remote_ip)
    else:
        logger.info( "would send concert off %s" % remote_ip)

def concert_on_dmx():
    if not args.disable:
        logger.info( "setting dmx preset 2 on %s: entering concert mode" % DMX_IP)
        msg = "/dmxMode 2"
        udpsend(msg, DMX_IP, DMX_PORT) 
        send_to_osc(DMX_IP, DMX_PORT, msg)
    else:
        logger.info( "would set dmx preset 2 on %s: to enter concert mode" % DMX_IP)

def concert_off_dmx():
    if not args.disable:
        logger.info( "setting dmx preset 1 on %s: entering exhibition mode" % DMX_IP)
        msg = "/dmxMode 1"
        udpsend(msg, DMX_IP, DMX_PORT) 
        send_to_osc(DMX_IP, DMX_PORT, msg)
    else:
        logger.info( "would set dmx preset 1 on %s: to enter exhibition mode" % DMX_IP)

# hits play on Ableton for a given list of media servers
def play_ableton():
    logger.info( " -----play ableton")
        
    try:
        for item in ableton_list:
            send_to_osc(item, ableton_port, ableton_play_command)
    except Exception, e:
        logger.error(" ERROR: %s" % e) 

# turns concert mode (for live shows) on or off. Kills/starts audio on all Pis in Shanty Town, plus sends 
# DMX light control to/from the light console
def concert_mode(on_or_off):
    logger.info( " -----concert mode %s" % on_or_off)
        
    try:
        if (on_or_off is "on"):
            #enter concert mode, set DMX to preset 2
            concert_on_dmx()
        else:
            #enter exhibition mode, set DMX to preset 1
            concert_off_dmx()

        #turn on or off concert mode for each device                         
        for item in concert_mode_video_list:
            if (on_or_off is "on"):
                #enter concert mode, kill looping video/audio
                concert_on_video(item)
            else:
                #enter exhibition mode, start looping video
                concert_off_video(item)

        for item in concert_mode_looping_audio_list:
            if (on_or_off is "on"):
                #enter concert mode, stop looping audio
                concert_on_audio_looping(item)
            else:
                #enter exhibition mode, start looping audio
                concert_off_audio_looping(item)

        for item in concert_mode_triggered_audio_list:
            if (on_or_off is "on"):
                #enter concert mode, turn off triggered audio
                concert_on_audio_triggered(item)
            else:
                #enter exhibition mode, turn on triggered audio
                concert_off_audio_triggered(item)

        for item in concert_mode_volume_list:
            if (on_or_off is "on"):
                #enter concert mode, turn down volume
                volume_off_pi(item)
            else:
                #enter concert mode, turn up volume
                volume_on_pi(item)

        msg = "/concertmode_%s 1" % on_or_off
        send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)

        return

    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e) 

# reboots the entry video Pis at around the same time, for sync
def reboot_entry_videos():
    logger.info( " -----reboot entry pis")

    try:
        for item in entry_video_list:
            reboot_pi(item)

    except lite.Error, e:
        logger.error(" ERROR: SQL error! %s" % e) 

###################################
# main() - main scan loop
###################################

if __name__ == "__main__":

    ##################                                                          
    # LOGGING SETUP                                                             
    ##################                                                          
    try:
    
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
        
        group.add_argument('--stop_switch',
                           action='store_true',
                           help='shuts down all devices on a given --switch IP (with great power... etc)')
        
        group.add_argument('--start_show',
                           action='store_true',
                           help='starts the whole show (with great power... etc)')
        
        group.add_argument('--start_by_type',
                           action='store_true',
                           help='starts the whole show for a device type (with great power... etc)')
        
        group.add_argument('--stop_by_type',
                           action='store_true',
                           help='stops the whole show for a device type (with great power... etc)')
        
        group.add_argument('--start_switch',
                           action='store_true',
                           help='starts the whole show for a given switch IP (with great power... etc)')
        
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
                           help='leaves concert mode (starts shantytown audio & sends light control to devices)')
        
        group.add_argument('--concert_mode_on_device',
                           action='store_true',
                           help='enters concert mode (stops shantytown audio & sends light control to console) for a single device')
        
        group.add_argument('--concert_mode_off_device',
                           action='store_true',
                           help='leaves concert mode (starts shantytown audio & sends light control to devices) for a single device')
        
        group.add_argument('--on_by_zone',
                           action='store_true',
                           help='turns everything in the given zone on, in boot order')
        
        group.add_argument('--off_by_zone',
                           action='store_true',
                           help='turns everything in the given zone off, in reverse boot order')
        
        group.add_argument('--on_by_space',
                           action='store_true',
                           help='turns everything in the given space on, in boot order')
        
        group.add_argument('--off_by_space',
                           action='store_true',
                           help='turns everything in the given space off, in reverse boot order')
        
        group.add_argument('--dump_devices',
                           action='store_true',
                           help='dumps device list to the log')
        
        group.add_argument('--reboot_entry_videos',
                           action='store_true',
                           help='simul(ish)-reboots the entry video (Benji as Agent 35) Pis')
        
        group.add_argument('--restart_pod',
                           action='store_true',
                           help='stops the MAX patch on Russels Livestock POD, then reboots the machine')
        
        group.add_argument('--volume_up',
                           action='store_true',
                           help='sets volume to preset on Pis')
        
        group.add_argument('--volume_down',
                           action='store_true',
                           help='sets volume to 0 percent on Pis')
        
        group.add_argument('--volume_relative',
                           action='store_true',
                           help='sets volume to the preset, +/- the given percent on Pis')
        
        group.add_argument('--play_ableton',
                           action='store_true',
                           help='sends /live/play message to media servers, to hit play on Ableton')
        
        group.add_argument('--test_item',
                           action='store_true',
                           help='test item, does nothing real')
        
    ##### add-on arguments (can be applied to the above)
        parser.add_argument("--switch",
                            type=str,
                            help='Limits start_switch and stop_switch to this switch IP address (i.e. 10.42.16.166)' ) 
        
        parser.add_argument('--disable',
                            action='store_true',
                            help='Disables all commands (test mode)')
        
        parser.add_argument('--no_servers',
                            action='store_true',
                            help='Skip start/stop/reboot commands for servers (Windows/Mac); start/stop/reboot Pis and Arduinos only')
        
        parser.add_argument('--no_relays',
                            action='store_true',
                            help='Skip start/stop/reboot commands for power relays (managed outlets)')
        
        parser.add_argument('--with_relays',
                            action='store_true',
                            help='Adds start/stop/reboot commands for power relays (managed outlets)')
        
        group.add_argument('--relay_on',
                           action='store_true',
                           help='starts a single relay (given relay name in --relay)' )
        
        group.add_argument('--relay_off',
                           action='store_true',
                           help='stops a single relay (given relay name in --relay)' )
        
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
        
        parser.add_argument('--with_dump', 
                            action='store_true',
                            help='Dumps OKAY and NONRESPONSIVE lists to the log')
        
        parser.add_argument('--zone', 
                            type=str,
                            help='Zone to use with _zone commands')
        
        parser.add_argument('--type', 
                            type=str,
                            help='Zone to use with _type commands')
        
        parser.add_argument('--space', 
                            type=str,
                            help='Space to use with _space commands')
        
        parser.add_argument('--relay', 
                            type=str,
                            help='Relay name to use with relay_ commands')
        
        parser.add_argument('--volume', 
                            type=str,
                            help='Volume to use with --volume_relative (i.e. 5-, 10+') 
        args = parser.parse_args()
        
    ###############################################
    # sets args for single-device start/stop/reboot
    ###############################################            
        
        cmd = " Show start/stop script OPENED"
        
        if args.dump_devices:
            dump_devices("OKAY")
            dump_devices("NONRESPONSIVE")
            exit()
            
        if args.with_dump:
            dump_devices("OKAY")
            dump_devices("NONRESPONSIVE")
                
        if args.test_item:
            logger.info("test item, does nothing...")
            exit()

        if args.start_show:
            cmd = cmd + (", starting show")
            msg = "/start_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.stop_show:
            cmd = cmd + (", stopping show")
            msg = "/stop_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.stop_device:
            cmd = cmd + (", stopping single device")
        if args.start_device:
            cmd = cmd + (", starting single device")
        if args.relay_off:
            cmd = cmd + (", stopping single relay")
        if args.relay_on:
            cmd = cmd + (", starting single relay")
        if args.pause_audio_device:
            cmd = cmd + (", pausing audio for a single device")
        if args.unpause_audio_device:
            cmd = cmd + (", unpausing (playing) audio for a single device")
        if args.concert_mode_on:
            cmd = cmd + (", enter concert mode")
        if args.concert_mode_off:
            cmd = cmd + (", leave concert mode")
        if args.reboot_entry_videos:
            cmd = cmd + (", reboot entry videos")
        if args.play_ableton:
            cmd = cmd + (", play ableton")
        if args.start_switch:
            cmd = cmd + (", on by switch:")
            msg = "/start_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.stop_switch:
            cmd = cmd + (", off by switch:")
            msg = "/stop_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.start_by_type:
            cmd = cmd + (", on by type:")
            msg = "/start_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.stop_by_type:
            cmd = cmd + (", off by type:")
            msg = "/stop_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.on_by_zone:
            cmd = cmd + (", on by zone:")
            msg = "/start_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.off_by_zone:
            cmd = cmd + (", off by zone:")
            msg = "/stop_show 1"
            send_to_osc(SHOW_CONTROLLER_IP, SHOW_CONTROLLER_PORT, msg)
        if args.volume_up:
            cmd = cmd + (", volume up")
        if args.volume_down:
            cmd = cmd + (", volume down:")
        if args.volume_relative:
            cmd = cmd + (", volume relative:")
        if args.ip:
            cmd = cmd + (" with IP %s" % args.ip)
        if args.proc:
            cmd = cmd + (" with process %s" % args.proc)
        if args.relay:
            cmd = cmd + (" with relay %s" % args.relay)
        if args.no_relays:
            cmd = cmd + (", with --no_relays")      
        if args.with_relays:
            cmd = cmd + (", with --with_relays")      
        if args.no_servers:
            cmd = cmd + (", with --no_servers")      
        if args.no_global:
            cmd = cmd + (", with --no_global")      
        if args.switch:
            cmd = cmd + (", limited to switch %s" % args.switch)
        if args.zone:
            cmd = cmd + (", for zone %s" % args.zone)
        if args.type:
            cmd = cmd + (", for device type %s" % args.type)
        if args.space:
            cmd = cmd + (", for space %s" % args.space)
        if args.volume:
            cmd = cmd + (" with volume %s" % args.volume)
        logger.info(cmd)

        if args.disable:
            logger.warning(" WARNING: disable (test/dry run) option has been selected.")
    
    except Exception, e:
        logger.warning("Error: %s" % e)

        #checks whether this is a standalone call or requires arguments
    multi_item = False
    if not (args.start_device or args.stop_device or args.reboot_device or args.pause_audio_device or args.unpause_audio_device or args.kill_proc_device or args.start_proc_device or args.volume_up or args.volume_down or args.volume_relative or args.relay_on or args.relay_off):
        multi_item = True
        
    if (multi_item):
        if not (args.no_delay):
            delay_with_countdown(INIT_DELAY)

    #if we included the IP, check it to make sure it's in the Master Doc
    if args.ip:
        if not (multi_item):
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
        else:
            if args.zone.lower() == "arcade" or args.zone.lower() == "beamcade":
                args.zone = "cade"

    if args.off_by_space or args.on_by_space:
        if args.space is None or args.space == "":
            logger.error( " ERROR: --off_by_space or --on_by_space selected but no space name was given with --space. Exiting...")


    if args.start_by_type or args.stop_by_type:
        if args.type is None or args.type == "":
            logger.error( " ERROR: --off_by_type or --on_by_type selected but no type name was given with --type. Exiting...")


    if args.start_switch or args.stop_switch:
        if args.type is None or args.type == "":
            logger.error( " ERROR: --start_switch or --stop_switch selected but no switch name was given with --switch. Exiting...")

    ###############
    # START DEVICE
    ###############
        
    if args.start_device:
        start_device(switch_ip, switch_interface, device_type, mac_address, "", "")
        
    ###############
    # STOP DEVICE
    ###############
                    
    if args.stop_device:
        stop_device(remote_ip, switch_ip, switch_interface, device_type, "", "", WITH_POE)

    ###############
    # REBOOT DEVICE
    ###############
                    
    if args.reboot_device:
        reboot_device(remote_ip, switch_ip, switch_interface, device_type, "", "")

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
        start_stop_reboot_show("start", switch_interface, args.type)

    ###############
    # STOP SHOW
    ###############
        
    if args.stop_show:
        if args.switch:
            switch_interface = args.switch
        start_stop_reboot_show("stop", switch_interface, args.type)

    ###############
    # REBOOT SHOW
    ###############

    if args.reboot_show:
        if args.switch:
            switch_interface = args.switch            
        start_stop_reboot_show("reboot", switch_interface, args.type)

    if args.stop_switch:
        if args.switch:
            switch_interface = args.switch
        start_switch("stop", switch_interface, args.type)

    if args.start_switch:
        if args.switch:
            switch_interface = args.switch
        start_switch("start", switch_interface, args.type)

    if args.start_by_type:
        if args.switch:
            switch_interface = args.switch            
        start_by_type("start", switch_interface, args.type)

    if args.stop_by_type:
        if args.switch:
            switch_interface = args.switch            
        start_by_type("stop", switch_interface, args.type)

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
    # ON BY SPACE
    #################

    if args.on_by_space:
        if (args.space):
            on_by_space("on", args.space.lower())

    #################
    # OFF BY SPACE
    #################

    if args.off_by_space:
        if (args.space):
            on_by_space("off", args.space.lower())

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

    #################
    # VOLUME UP
    #################

    if args.volume_up:
        if args.ip:
            volume_on_pi(args.ip)
        else:
            volume_on_allpis()           

    #################
    # VOLUME DOWN
    #################

    if args.volume_down:
        volume_off_pi(args.ip)

    #################
    # VOLUME DOWN
    #################

    if args.volume_relative:
        if args.ip:
            volume_relative_pi(args.ip, args.volume)
        else:
            #turn everything up
            volume_relative_allpis(args.volume)

    #################
    # RELAY ON
    #################

    if args.relay_on:
        on_off_single_relay("on", args.relay)

    #################
    # RELAY OFF
    #################

    if args.relay_off:
        on_off_single_relay("off", args.relay)

    #################
    # RELAY OFF
    #################

    if args.play_ableton:
        play_ableton()

    #################
    # RESTART POD
    #################

    if args.restart_pod:
        restart_pod()

    #################
    # ENTRY VIDEO REBOOT
    #################

    if args.reboot_entry_videos:
        reboot_entry_videos()

    exit_func()
