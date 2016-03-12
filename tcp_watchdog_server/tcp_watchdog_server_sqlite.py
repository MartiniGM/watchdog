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
from collections import defaultdict
# to install the three below:
# "pip install gspread; pip install oauth2client; pip install PyOpenSSL"
# install pip first if you don't have it, on windows just google "get-pip.py".
# on Mac OS use "easy_install pip"
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

####################
# GLOBALS & SETTINGS
####################                

# give a time (in seconds) for the periodic data check here
# every N seconds the watchdog will compare timestamps for all entries in the 
# database to the current time, and set NONRESPONSIVE if each hasn't replied
# within this time period.
periodic_period = 90 #seconds 
periodic_timer = time.time() #initialize timer

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db'

# set this to 0 to turn off Google spreadsheets and use local database only
# (f.ex if Google ever breaks the API!)
# if 0 (or if there are errors loading the google sheet), the program will default to using the googlesheet_backup table in the SQLite DB. If that fails, it will write back any existing values from the DB.
USE_GOOGLE_SHEETS = 1

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet
googleWorksheetName_Switches = "Switch Interface Map" #name of the tab on the google sheet

# dictionary to load Google spreadsheet into (for device types and descriptions)
googleSheetDict = {}
list_of_lists = []
# dictionary to load Google spreadsheet into (for Switch Interface Map)
googleSheetDictSwitches = {}
list_of_lists_switches = []
switch_prefix_index = 0
switch_ip_index = 0

# load google sheet every hour. it's a bit slow to get the data back so it doesn't reload often, but if you want to trigger it immediately just restart the program
LOADSHEET_SLOW = 3600 #seconds, once the initial load gets at least 1 row
LOADSHEET_FAST = 200 #seconds, as long as all loads have failed
loadGoogleSheetEvery = LOADSHEET_FAST #starts with fast loads until it succeeds
loadGoogleSheetTimer = time.time()

# give a filename for the watchdog's log file here
LOG_FILENAME = '/Users/Aesir/Documents/watchdog/tcp_watchdog_server/tcp_watchdog_server.out'

PORT = 6666 # port number to watch

# give the size for each rolling log segment, in bytes
LOG_SIZE = 20000000 #20 MB, in bytes
# give the number of rolling log segments to record before the log rolls over
LOG_NUM_BACKUPS = 5 # five .out files before they roll over

####################
# EXIT HANDLER
####################                

# upon exit, log exit msg, disconnect from sqlite and close sockets
def exit_func():
    logger.warning ("     Watchdog server STOPPED on port " + str(PORT))
    con.close()
    server_socket.close()
    sys.exit(0)
    
# exits the program cleanly, logging exit time
def signal_handler(signal, frame):
    print ""
    exit_func()

signal.signal(signal.SIGINT, signal_handler)

####################
# FUNCTIONS
####################

############################################################
#find_item()
############################################################
def find_item(mylist, item_name):
     #gets the position of "item" in the sublists & returns
    for item in mylist:
        i = 0
        for subitem in item:
            if subitem == item_name:
                item_id = i
                return item_id
            i = i + 1

############################################################
#open_googlesheet()
############################################################
# opens Google spreadsheet for later use. Call every hour or so to refresh the data from the Google sheet, then use get_item_googlesheet to access the data as often as you like in the interim.
# use our JSON credentials to open the Google Drive sheet
def open_googlesheet():
# if we're not loading the Google sheet, just return
    if (USE_GOOGLE_SHEETS != 1):
        return
# else use our JSON credentials to open the Google Drive sheet        
    try:
        global googleSheetDict
        global googleSheetDictSwitches
        global json_file
        global googleSheetKey
        global list_of_lists
        global list_of_lists_switches
        global switch_ip_index
        global switch_prefix_index
        global loadGoogleSheetEvery 
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        
        googleWorksheet = sh.worksheet(googleWorksheetName)
        list_of_lists = googleWorksheet.get_all_values()

        googleWorksheet_switches = sh.worksheet(googleWorksheetName_Switches)
        list_of_lists_switches = googleWorksheet_switches.get_all_values()
        googleSheetLenSwitches = len(list_of_lists_switches)

    except Exception, e:
        logger.error("error in open_googlesheet: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
            
    try:
        #create searchable dictionary with ID_NAME/IP ADDRESS as the key!
        if googleSheetLenSwitches != 0:
            matches2 = [match for match in find_switch("Switch Prefix")]
            switch_prefix_index = int(matches2[0][1])
        
            matches3 = [match for match in find_switch("Switch IP")]
            switch_ip_index = int(matches3[0][1])
            pivot_switches()

    except Exception, e:
        logger.error("error in open_googlesheet for switches: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))

    try:
        #create searchable dictionary with ID_NAME/IP ADDRESS as the key!
        googleSheetDict = defaultdict(list)
        #finds location of "IP ADDRESS" column to use as key
        ip_address_column = 1 #default
        ip_address_column = find_item(list_of_lists, "IP ADDRESS")
        next_column = ip_address_column + 1
        for listy in list_of_lists:
            googleSheetDict[listy[ip_address_column]] += listy[next_column:]
        googleSheetLen = len(googleSheetDict)    
        #for keys,values in googleSheetDict.items():
        #    print(keys)
        #    print(values)
        if googleSheetLen == 0 or googleSheetLenSwitches == 0:
            # set slower loads after load gets at least one row
            # if not, try to reload much more often.
            loadGoogleSheetEvery = LOADSHEET_FAST #seconds
            logger.info("     Google Sheets load failed? %s rows loaded plus %s switch interfaces" % (googleSheetLen, googleSheetLenSwitches))      
        else:
            #the load got at least one row. Save everything in the DB 
            loadGoogleSheetEvery = LOADSHEET_SLOW #seconds
            logger.info("     Google Sheets load OK, %s rows loaded plus %s switch interfaces" % (googleSheetLen, googleSheetLenSwitches))
            save_googlesheet_backup()
            
    except Exception, e:
        logger.error("error when iterating over Google sheet %s with json file %s: %s" % (googleSheetKey, json_file, e))
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))

############################################################
#get_item_googlesheet()
############################################################
# queries google spreadsheet for id_name, returns string in item_name position
# otherwise returns empty string ("")
def get_item_googlesheet(id_name, item_name):
    global googleSheetDict
    if (bool(googleSheetDict) == False):
        logger.error( "empty dictionary in get_item_googlesheet! Please check google sheets access?")
        return ""
    header_item = googleSheetDict["IP ADDRESS"]
    try:
        item_id = header_item.index(item_name) 
        if item_name == "Switch Interface":
            our_item = googleSheetDict[id_name]
            item_id = header_item.index("Device Name")
            dev_name = our_item[item_id]
            our_item2 = googleSheetDictSwitches[dev_name]

#            print "%s %s" % (id_name, our_item2[0])
            return str(our_item2[0])
        else:
            our_item = googleSheetDict[id_name]
            return_item = re.sub(u"\u2010", "-", our_item[item_id])
            #strips out em-dash someone put in the Master Doc
            return str(return_item)
    except KeyError:
#        logger.warning("dict entry '%s' not found" % id_name)
        return ""
    except IndexError:
#        logger.warning("dict entry '%s' not found" % id_name)
        return ""
    except ValueError, e:
        logger.warning("ValueError, column '%s' not found? %s" % (item_name, e))
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return ""
    except Exception, e:
        logger.error( "error in get_item_googlesheet! %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return ""

############################################################
#save_googlesheet_backup()
############################################################
#dumps all rows of the google sheet to the GOOGLESHEET_BACKUP sqlite table
def save_googlesheet_backup():
    global googleSheetDict
    for key in googleSheetDict:
        (location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, boot_order) = get_items_from_googlesheet_forsave(key)
        try:
            cur = con.cursor()
            cur.execute("INSERT OR REPLACE INTO GOOGLESHEET_BACKUP(IP_ADDRESS, LOCATION, DEVICE_TYPE, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE, MAC_ADDRESS, HOSTNAME, BOOT_ORDER) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (key, location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, boot_order))
            con.commit()
        except lite.Error, e:
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                logger.error( "     in %s on line %d" % (fname, lineno))
            logger.error( " sqlite error: %s" % e)
            try:
                con.rollback()
            except Exception, e:
                logger.error(" Can't rollback! %s" % e)

############################################################
# get_item_googlesheet_backup()
############################################################        
# returns a row from googlesheet backup, given an ip_address
def get_item_from_googlesheet_backup(ip_address, item_name):
    global con
    try:
        cur = con.cursor()
        query = "SELECT %s FROM GOOGLESHEET_BACKUP WHERE IP_ADDRESS LIKE ?" % item_name
        cur.execute(query, ('%'+ip_address+'%',))
        data = cur.fetchall()
        for row in data:
            return row[0]
    except lite.Error, e:
        if con:
            try:
                con.rollback()
            except Exception, e:
                logger.error(" Can't rollback! %s" % e)
        logger.error(" SQL error! %s" % e)
        return "" #blank item, will show as None in SQL
            
############################################################
#get_items_from_googlesheet_forsave()
############################################################
#gets all googlesheet items from one row of the GS dict 
def get_items_from_googlesheet_forsave(id_name):
#otherwise try to read them from the googlesheet dictionary
    device_type = get_item_googlesheet(id_name, "Device Type")
    location = get_item_googlesheet(id_name, "Location Details")
    zone = get_item_googlesheet(id_name, "Zone")
    space = get_item_googlesheet(id_name, "Space")
    device_name = get_item_googlesheet(id_name, "Device Name")
    description = get_item_googlesheet(id_name, "Description")
    switch_interface = get_item_googlesheet(id_name, "Switch Interface")
    mac_address = get_item_googlesheet(id_name, "Mac Address")
    hostname = get_item_googlesheet(id_name, "Hostname")
    boot_order = get_item_googlesheet(id_name, "Boot Order")
    
    return (location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, boot_order) #return items from googlesheet dictionary

############################################################
#is_known_software(id_name)
############################################################
#returns alias for known pi software. Or returns ""
def is_known_software(id_name):
    try:
        sep = '/'
        parent = id_name.split(sep, 1)[0]
        desc = get_item_googlesheet(parent, "Description")
    
        if "do-audio.py" in id_name:
            return desc[:20] + " (audio script)"  
        if "do-video.py" in id_name:
            return desc[:20] + " (video script)"  
        if "looping-audio.sh" in id_name:
            return desc[:20] + " (looping audio 1)"
        if "looping-audio1.sh" in id_name:
            return desc[:20] + " (looping audio 2)"
        if "looping-audio2.sh" in id_name:
            return desc[:20] + " (looping audio 3)"
        if "looping-audio3.sh" in id_name:
            return desc[:20] + " (looping audio 4)"
        if "checkServer.sh" in id_name:
            return desc[:20] + " (check server)"  
        if "Max.exe" in id_name:
            return desc[:20] + " (Max MSP)"  
    
        return ""
    except Exception, e:
        logger.error( "Error in is_known_software: %s" % e)
        return ""
    
############################################################
#get_items_from_googlesheet()
############################################################
#gets all googlesheet items from the GS backup. If that fails, get the
#current values from the sqlite DB.
def get_items_from_googlesheet(id_name):
    loc = ""
    
    location = get_item_googlesheet(id_name, "Location Details")
    if location == "" or location is None:
        location = get_item_from_googlesheet_backup(id_name, "LOCATION")
        if location == "" or location is None:
            location = get_item_sqlite(id_name, "LOCATION")        

    description = get_item_googlesheet(id_name,  "Description")
    if description == "" or description is None:
        description = get_item_from_googlesheet_backup(id_name,  "DESCRIPTION")
        if description == "" or description is None:
            #new device. try to autofill
            desc = is_known_software(id_name)
            if desc == "":
                description = get_item_sqlite(id_name, "DESCRIPTION")
            else:
                description = desc
                
    device_type = get_item_googlesheet(id_name, "Device Type")
    if device_type == "" or device_type is None:
        device_type = get_item_from_googlesheet_backup(id_name, "DEVICE_TYPE")
        if device_type == "" or device_type is None:
            if desc != "":
                device_type = "Software"
            else:
                device_type = get_item_sqlite(id_name, "DEVICE_TYPE")

    zone = get_item_googlesheet(id_name, "Zone")
    if zone == "" or zone is None:
        zone = get_item_from_googlesheet_backup(id_name, "ZONE")
        if zone == "" or zone is None:
            zone = get_item_sqlite(id_name, "ZONE")

    space = get_item_googlesheet(id_name, "Space")
    if space == "" or space is None:
        space = get_item_from_googlesheet_backup(id_name, "SPACE")
        if space == "" or space is None:
            space = get_item_sqlite(id_name, "SPACE")

    device_name = get_item_googlesheet(id_name, "Device Name")
    if device_name == "" or device_name is None:
        device_name = get_item_from_googlesheet_backup(id_name, "DEVICE_NAME")
        if device_name == "" or device_name is None:
            device_name = get_item_sqlite(id_name, "DEVICE_NAME")

    switch_interface = get_item_googlesheet(id_name, "Switch Interface")
    if switch_interface == "" or switch_interface is None:
        switch_interface = get_item_from_googlesheet_backup(id_name, "SWITCH_INTERFACE")
        if switch_interface == "" or switch_interface is None:
            switch_interface = get_item_sqlite(id_name, "SWITCH_INTERFACE")

    mac_address = get_item_googlesheet(id_name, "Mac Address")
    if mac_address == "" or mac_address is None:
        mac_address = get_item_from_googlesheet_backup(id_name, "MAC_ADDRESS")
        if mac_address == "" or mac_address is None:
            mac_address = get_item_sqlite(id_name, "MAC_ADDRESS")

    boot_order = get_item_googlesheet(id_name, "Boot Order")
    if boot_order == "" or boot_order is None:
        boot_order = get_item_from_googlesheet_backup(id_name, "BOOT_ORDER")
        if boot_order == "" or boot_order is None:
            boot_order = get_item_sqlite(id_name, "BOOT_ORDER")
            
    return (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) #return items, either from GS backup or as-is from the database

############################################################
#get_all_from_googlesheet()
############################################################
# queries the google spreadsheet dict for type, location, zone, space,
# device name, and description. then returns them 
# otherwise does nothing
def get_all_from_googlesheet(id_name):
    try:
        (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) = get_items_from_googlesheet(id_name)
    except Exception, e:
        logger.error( "get_all_from_googlesheet error: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        return ("", "", "", "", "", "", "", "", "")
    
    return (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) #return items from googlesheet dictionary

############################################################
#find_item()
############################################################
#gets the position of "item" in the sublists & returns
def find_item(mylist, item_name):
     #gets the position of "item" in the sublists & returns
    for item in mylist:
        i = 0
        for subitem in item:
            if subitem == item_name:
                item_id = i
                return item_id
            i = i + 1

############################################################
#find_switch()
############################################################
# returns switch in list of switches
def find_switch(c):
    for i, switch in enumerate(list_of_lists_switches):
        try:
            j = switch.index(c)
        except ValueError:
            continue
        yield i, j

############################################################
#pivot_switches()
############################################################
# creates searchable per-switch dict of device names & switch interfaces
def pivot_switches():
    top = 13; #max number of switches, ignore everything below these in sheet
    global googleSheetDictSwitches
    googleSheetDictSwitches = defaultdict(list)
    for i, switch in enumerate(list_of_lists_switches):
        try:
            if i == 0: # the first row is always just the column titles/key
                continue
            if i <= top:
#                print ""
                #                print "i %d switch %s" % (i, switch)
                this_prefix = switch[switch_prefix_index]
#                print "this_prefix %s" % this_prefix
                this_switch = switch[switch_ip_index]
#                print "this_switch_ip %s" % this_switch
                j = 0
                for item in switch[switch_prefix_index+1:]:
                    j = j + 1
                    if item != "":
                        return_item = "%s: %s %s%d" % (item, this_switch, this_prefix, j)
                        interface = "%s %s%d" % (this_switch, this_prefix, j)
                    #add these to a dict so you can look them up by item later
                        googleSheetDictSwitches[item] += [interface]
#                        print return_item
            else:
                return
        except ValueError:
            continue

############################################################
#return_last_reset()
############################################################
# figures last detected reset time and returns as timestamp string
def return_last_reset(new_uptime, last_uptime, id_name):
    last_reset_timestamp_check = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
    uptime_sec = get_item_sqlite(id_name, "UPTIME_SEC")
    if (last_reset_timestamp_check == None and uptime_sec != None):
        #get the uptime and subtract from the current time to create baseline ts
        try:
            last_reset_time = datetime.datetime.now() - datetime.timedelta(seconds=int(float(uptime_sec)))
            last_reset_timestamp = str(last_reset_time.strftime("%b %d, %Y %H:%M:%S"))
        except Exception, e:
            import time
            logger.debug("Problem converting last reset time, setting to 0")
            last_reset_time = 0
            last_reset_timestamp = ""
        return last_reset_timestamp
    else:
        if (last_uptime == None):
            #just return the last recorded one so we can write it back to the DB
            last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
            return last_reset_timestamp
        else:
            try:
                if (int(float(new_uptime)) < int(float(last_uptime))):
                #detected a device reset since the last time we checked the uptime
                    last_reset_time = datetime.datetime.now() - datetime.timedelta(seconds=int(float(new_uptime)))
                    last_reset_timestamp = str(last_reset_time.strftime("%b %d, %Y %H:%M:%S"))
                    logger.warning (id_name + " **DEVICE RESET** detected at " + last_reset_timestamp)
                    logger.debug("old uptime" + str(last_uptime) + ",new uptime " + str(new_uptime))
                    return last_reset_timestamp
                else:
                #just return the last recorded one so we can write it back to the DB
                    last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
                    return last_reset_timestamp
            except Exception, e: 
                logger.warning( "Problem converting timestamp, returning ''")
                return ""
            
############################################################
#return_status()
############################################################
# returns human-friendly status strings, given internal codes

def return_status(stat):
    if stat is None:
        return "UNKNOWN" # in case something badly formatted got into the database
    if ('CLEAR' in stat):
        return "OKAY"
    else:
        if ('NOREPLY' in stat):
            return "NONRESPONSIVE"
        else:
            # if not recognized, return status as-is
            return stat
    
############################################################
# get_pis_sqlite()
############################################################        
# returns data from arduinos and pis (as a list of tuples)

def get_pis_sqlite(pi_or_arduino):
    global con
    with con:
        cur = con.cursor()
        sql = """SELECT ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME FROM %s""" % pi_or_arduino
        cur.execute(sql)
        data = cur.fetchall()
        return data

############################################################
# get_item_sqlite()
############################################################        
# returns location/description string, given an id_name

def get_item_sqlite(id_name, item_name):
    global con
    try:
        cur = con.cursor()
        query = "SELECT ID_NAME, %s FROM DEVICES WHERE ID_NAME LIKE ?" % item_name
        cur.execute(query, ('%'+id_name+'%',))
        data = cur.fetchall()
        for row in data:
            return row[1]
    except lite.Error, e:
        if con:
            logger.error(" SQL error! %s" % e)
            try:
                con.rollback()
            except Exception, e:
                logger.error(" Can't rollback! %s" % e)
        return "" #blank item, will show as None in SQL
    
############################################################
# listify_data()
############################################################            
# splits string input into a formatted list of tuples and returns it.
# this is intended to match the way SQLite returns values, so we can use the
# same functions to parse both. Also checks msg for validity & truncates strings

def listify_data(data):
    MAX_STATUS_STRING = 50 #strings longer than 50 chars are truncated
    MAX_ID_STRING = 150 #strings longer than 150 chars are truncated
    MAX_UPTIME_STRING = 50 #strings longer than 50 chars are truncated
    try:
        if len(data) == 0:
            return
        data_list = data.split();
        status = data_list[0]
        #truncate stuff, none of these strings need to be super long
        if len(status) > MAX_STATUS_STRING:
            status = status[:MAX_STATUS_STRING]
        new_status = return_status(status)
        id_name = data_list[1]
        #truncate stuff, none of these strings need to be super long
        if len(id_name) > MAX_ID_STRING:
            id_name = id_name[:MAX_ID_STRING]

        #right now all ID names should contain an IP address
        if '.' not in id_name:
            logger.error( "Error in listify_data: ID %s doesn't contain IP address?", id_name)
            logger.error( "Check the last message's formatting!")
            return
        
        #if there's no uptime...
        if len(data_list) <= 2:
            logger.error( "Error in listify_data: message %s has no uptime" % data)
            logger.error( "Check the last message's formatting!")
            uptime_sec = "0"
            timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
            uptime = ""
            return [(id_name, timestamp, new_status, uptime_sec, uptime)]

        #if everything's cool...
        uptime_sec = data_list[2]
        timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
        strr = " "
        uptime = strr.join(data_list[3:])
        #truncate stuff, none of these strings need to be super long
        if len(uptime) > MAX_UPTIME_STRING:
            uptime = uptime[:MAX_UPTIME_STRING]
        return [(id_name, timestamp, new_status, uptime_sec, uptime)]
    except Exception, e:
        logger.error( "Error in listify_data: %s" % e)
        logger.error( "Check the last message's formatting!")
        return 

############################################################
# sql_data_sqlite()
############################################################        
# parses data (as a list of tuples, either from SQLite or listify_data) a
# and updates SQLite

def sql_data_sqlite(data, pi_or_arduino, ip):
    global con
    if data is None:
        return
    if len(data) == 0:
        return
    logger.debug(data)
    datalist = data[0]
    non_decimal = re.compile(r'[^\d.]+')

    if len(datalist) != 5 or datalist[0] == "x.x.x.x":
        logger.warning( "got the IP address error %s " % ip[0])
        id_name = ip[0]
        timestamp = datalist[0]
        status = datalist[1]
        new_status = return_status(status)
        uptime_sec = datalist[2]
        #replaces ',' etc to ensure numbers only
        uptime_sec = non_decimal.sub('', uptime_sec)
        #strips out dumb characters at the end of strings sent by Max
        uptime_sec = uptime_sec.replace('\x00', '')
        uptime = datalist[3]
    else:
        id_name = datalist[0]
        if (id_name[0] == '/'):
 #           print "got the IP address error"
            id_name = ip + id_name
        timestamp = datalist[1]
        status = datalist[2]
        new_status = return_status(status)
        uptime_sec = datalist[3]
        #replaces ',' etc to ensure numbers only
        uptime_sec = non_decimal.sub('', uptime_sec)
        #strips out dumb characters at the end of strings sent by Max
        uptime_sec = uptime_sec.replace('\x00', '')
        #prints with dumb characters if present
#        print(repr(uptime_sec))
        uptime = datalist[4]
    if (len(uptime) == 0):
        # for now only loneduinos fail to send uptime as a string.
        # if so, create a string from the number of seconds rec'd
        try:
            sec = int(float(uptime_sec))
        except Exception, e:
            logger.debug("Problem converting uptime. Setting to 0")
            sec = 0
        mins = int(sec / 60)
        hours = int(mins / 60)
        days = int(hours / 24)

        sec = int(sec - (mins * 60))     # subtract the coverted seconds to minutes 
        mins = int(mins - (hours * 60))  # subtract the coverted minutes to hours 
        hours = int(hours - (days * 24)) # subtract the coverted hours to days 
        uptime = "%d days, %02d:%02d:%02d" % (days, hours, mins, sec)

    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    last_uptime = get_item_sqlite(id_name, "LAST_UPTIME_SEC")
    logger.info(id_name + " reports " + new_status + " with uptime " + uptime)

    #gets timestamp of last detected reset from the new/old uptime
    last_reset_timestamp = return_last_reset(uptime_sec, last_uptime, id_name)
    #reset uptime and write back to the database
    last_uptime = uptime_sec
    (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) = get_all_from_googlesheet(id_name)
    # insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, LAST_RESET_TIMESTAMP, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE, MAC_ADDRESS, BOOT_ORDER) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, last_reset_timestamp, zone, space, device_name, description, switch_interface, mac_address, boot_order))
        con.commit()
    except lite.Error, e:
        logger.error(" sqlite error: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
        try:
            con.rollback()
        except Exception, e:
            logger.error(" Can't rollback! %s" % e)
            
############################################################
# parse_data_sqlite()
############################################################        
# parses/checks for periodic disconnects; if found, inserts NOREPLY into SQLite

def parse_data_sqlite(data):
    num_okay = 0
    num_total = 0
    for row in data:
        id_name = row[0]
        timestamp = row[1]
        status = row[2]
        new_status = return_status(status)
        last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
        uptime_sec = row[3]
        uptime = row[4]
        time_cur = datetime.datetime.now()
        if timestamp is not None:
            time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%M:%S")
        else:
            time_ts = datetime.datetime.time()
        total_seconds = ((time_cur-time_ts).seconds)
        if (total_seconds > periodic_period):
            # more than X seconds since last message. update this entry with NOREPLY
            timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
            status = "NONRESPONSIVE"
            device_type = ""
            (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) = get_all_from_googlesheet(id_name)
            if (device_type is not None and "software" not in device_type.lower()):
                num_total += 1
            old_status = get_item_sqlite(id_name, "STATUS")
            if old_status != "NONRESPONSIVE" and "NOREPLY" not in old_status: #don't print if we already detected this!
                logger.info(id_name + " silent for " + str(total_seconds) + " seconds, setting " + status + " with uptime " + uptime)
            try:
                cur = con.cursor()
                cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, LAST_RESET_TIMESTAMP, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE, MAC_ADDRESS, BOOT_ORDER) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, last_reset_timestamp, zone, space, device_name, description, switch_interface, mac_address, boot_order))
                con.commit()
            except lite.Error, e:
                for frame in traceback.extract_tb(sys.exc_info()[2]):
                    fname,lineno,fn,text = frame
                    logger.error( "     in %s on line %d" % (fname, lineno))
                logger.error("sqlite error: %s" % e)
                try:
                    con.rollback()
                except Exception, e:
                    logger.error(" Can't rollback! %s" % e)
        else:
            #this item was OK if its status says OKAY
            if (new_status == "OKAY" and device_type is not None and "software" not in device_type.lower()):
                num_okay += 1
    # report / save system stats            
    if (num_total == 0):
        return
    else:
        try:
            percent_okay = (float(num_okay) / float(num_total)) * 100.0
        except Exception, e:
            logger.debug("Problem converting percent okay, setting to 0")
            percent_okay = 0.0
        info_id_name = "SYSTEM_INFO"
        logger.info(">>>>>>>>>>System Info: total is %d, okay %d, %d%% OK" % (num_total, num_okay, percent_okay))
        try:
            cur = con.cursor()
            cur.execute("INSERT OR REPLACE INTO SYSTEM_INFO(ID_NAME, NUM_DEVICES, NUM_OKAY_DEVICES, PERCENT_OKAY) values (?, ?, ?, ?)",  (info_id_name, num_total, num_okay, percent_okay))
            con.commit()
        except lite.Error, e:
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                logger.error( "     in %s on line %d" % (fname, lineno))
            logger.error("sqlite error: %s" % e)
            try:
                con.rollback()
            except Exception, e:
                logger.error(" Can't rollback! %s" % e)                

############################################################                
############################################################
# main()
############################################################
############################################################

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
    if len(sys.argv) > 1:
        level_name = sys.argv[1]
        level = LEVELS.get(level_name, logging.NOTSET)
        logging.basicConfig(level=level)
    else:
        level = LEVELS.get('info', logging.NOTSET)
        logging.basicConfig(level=level)

    # creates our logger with the settings above/below
    logger = logging.getLogger('WDLog')

    # Add the log message handler to the logger. Creates a rolling/circular log
    # with LOG_NUM_BACKUPS backups, each of size LOG_SIZE bytes
    handler = logging.handlers.RotatingFileHandler(LOG_FILENAME,
                                                   maxBytes=LOG_SIZE,
                                                   backupCount=LOG_NUM_BACKUPS)
    
    # sets the message & timestamp format for the log
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%m/%d/%Y %H:%M:%S")
    handler.setFormatter(frmt)
    logger.addHandler(handler)

    #########################
    # DATABASE SETUP (SQLITE)
    #########################
    
    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(WINDOWS_DB_FILENAME)
        else:
            con = lite.connect(LINUX_OSX_DB_FILENAME)     
    except Exception, e:
        logger.error("Can't connect to demosdb! %s" % e)

    if (USE_GOOGLE_SHEETS == 1):
        try:
            open_googlesheet()
        except Exception, e:
            logger.error("Can't connect to googlesheet! %s" % e)
        
    ##################
    # SOCKET SETUP
    ##################

    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_socket.bind(("0.0.0.0", PORT))
        server_socket.settimeout(5.0)
    except socket.error, e:
        logger.error( "socket error: %s" % e)
        
    logger.info ("     Watchdog server started on port " + str(PORT))

    #######################
    # MAIN LOOP
    #######################
    
    while 1:
        #######################
        # GOOGLE SHEET UPDATE
        #######################
        # refresh data from the google sheet. it's slow, don't do it too often!
        if (USE_GOOGLE_SHEETS == 1):
            if (time.time() - loadGoogleSheetTimer > loadGoogleSheetEvery):
                open_googlesheet()
                loadGoogleSheetTimer = time.time()
                
        #######################
        # PERIODIC DATA CHECK
        #######################
        # periodic data check. Checks SQLite every X seconds for lack of replies

        if (time.time() - periodic_timer > periodic_period):
            data = get_pis_sqlite("DEVICES")
            parse_data_sqlite(data)
            periodic_timer = time.time()
        
        try:
            data, address = server_socket.recvfrom(1024)
            if (data):
                print "-----Client (%s) connected, sent %s" % (address, data)

            #######################
            # DATA RECEIVED
            #######################
            # at this point we got data, so log it
            
                if data.count("ERRPI") + data.count("ERRDUINO") > 1:
                # we may get more than one message at a time
                # due to the way TCP works. If so, split 'em.
                # probably can't happen w/ UDP but I'm leaving it here in case
                    datas = re.split('(ERR)', data)
                    for data in datas:
                        if data != "" and data != "ERR":
                            data2 = "ERR"+data
                            logger.debug("line is " + data2)
                            data3 = listify_data(data2)
                            sql_data_sqlite(data3, "ARDUINOS", address)
            # otherwise, just log one message
                else:
                    data2 = listify_data(data)
                    sql_data_sqlite(data2, "ARDUINOS", address)
            else:
                continue
        except socket.timeout:
#            print "socket timeout"
            continue
        
    ##################
    # EXIT
    ##################                
    # upon exit, disconnect from sqlite and close sockets
    exit_func()
