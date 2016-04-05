#!/usr/bin/python
#test to see if I can init database items from the master doc 
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
# on Mac OS use "easy_install pip" 
# then "pip install gspread; pip install oauth2client; pip install PyOpenSSL"
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

USE_GOOGLE_SHEETS = 1

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = '/Users/Guest/watchdog/tcp_watchdog_server/mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet
googleWorksheetName_Switches = "Switch Interface Map" #name of the tab on the google sheet
LINUX_OSX_DB_FILENAME = 'demosdb.db'

googleSheetDict = {} # dictionary to load Google spreadsheet into (for Networked Devices)
list_of_lists = [] #list of items on the networked devices tab
# dictionary to load Google spreadsheet into (for Switch Interface Map)
googleSheetDictSwitches = {} #dict of items on the switch map tab
list_of_lists_switches = [] #list of items on the switch map tab
switch_prefix_index = 0 #index for the switch prefix on the switch map tab
switch_ip_index = 0 #index for the switch IP address on the switch map tab
googlesheet_failures = 0 # counts successive sheet failures to suppress messages
ip_address_column = 1

# load google sheet every hour. it's a bit slow to get the data back so it doesn't reload often, but if you want to trigger it immediately just restart the program
LOADSHEET_SLOW = 3600 #seconds, once the initial load gets at least 1 row
LOADSHEET_FAST = 200 #seconds, as long as all loads have failed
loadGoogleSheetEvery = LOADSHEET_FAST #starts with fast loads until it succeeds
loadGoogleSheetTimer = time.time()

############################################################
#is_known_software(id_name)
############################################################
#returns alias for known pi software. Or returns ""
def is_known_software(id_name):
    try:
        sep = '/'
        parent = id_name.split(sep, 1)[0]
        desc = ""
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
#get_item_googlesheet()
############################################################
# queries google spreadsheet for id_name, returns string in item_name position
# otherwise returns empty string ("")
def get_item_googlesheet(id_name, item_name):
    global googleSheetDict
    global googlesheet_failures
    if (bool(googleSheetDict) == False):
        googlesheet_failures = googlesheet_failures + 1
        if googlesheet_failures < 2:
            print( "empty dictionary in get_item_googlesheet! Please check google sheets access!")
        return ""
    header_item = googleSheetDict["IP ADDRESS"]
    googlesheet_failures = 0
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
            #strips out em-dashes in the Master Doc
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
            print( "     in %s on line %d" % (fname, lineno))
        return ""
    except Exception, e:
        print( "error in get_item_googlesheet! %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        return ""

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
#get_items_from_googlesheet()
############################################################
#gets all googlesheet items from the GS backup. If that fails, get the
#current values from the sqlite DB.
def get_items_from_googlesheet(id_name):
    loc = ""
    desc = ""
    
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
        print( "get_all_from_googlesheet error: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        return ("", "", "", "", "", "", "", "", "")
    
    return (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) #return items from googlesheet dictionary

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
        global googlesheet_failures
        googleSheetLenSwitches = 0
        googleSheetLen = 0
        googlesheet_failures = 0
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        
        #load the Networked Devices tab
        googleWorksheet = sh.worksheet(googleWorksheetName)
        list_of_lists = googleWorksheet.get_all_values()

    except Exception, e:
        print("error in open_googlesheet: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
    try:
        #create searchable dictionary with ID_NAME/IP ADDRESS as the key!
        googleSheetDict = defaultdict(list)
        #finds location of "IP ADDRESS" column to use as key
        ip_address_column = 1 #default
        ip_address_column = find_item(list_of_lists, "IP ADDRESS")
        if ip_address_column is not None:
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
            loadGoogleSheetEvery = LOADSHEET_FAST 
            print("     Google Sheets load failed? %s rows loaded plus %s switch interfaces" % (googleSheetLen, googleSheetLenSwitches))      
        else:
            #the load got at least one row. Save everything in the DB 
            loadGoogleSheetEvery = LOADSHEET_SLOW #seconds
            print("     Google Sheets load OK, %s rows loaded plus %s switch interfaces" % (googleSheetLen, googleSheetLenSwitches))
            save_googlesheet_backup()
            
    except Exception, e:
        print("error when iterating over Google sheet %s with json file %s: %s" % (googleSheetKey, json_file, e))
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))

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

########################
def init_items():
    global list_of_lists
    global ip_address_column
    print list_of_lists
    for item in list_of_lists:
        id_name = item[ip_address_column]
        status = "UNKNOWN"
        last_reset_timestamp = ""
        timestamp = ""
        uptime_sec = 0
        uptime = ""
        (location, device_type, zone, space, device_name, description, switch_interface, mac_address, boot_order) = get_all_from_googlesheet(id_name)
        if device_type is not None and device_type != "" and id_name is not None and id_name != "" and id_name != "n/a":
            if "berry" in device_type.lower() or "duino" in device_type.lower() or "indow" in device_type.lower() or "mac" in device_type.lower() or "eensy" in device_type.lower() and id_name is not None and id_name != "": 
                print "this item %s" % id_name

                try:
                    cur = con.cursor()
                    cur.execute("INSERT OR IGNORE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, LAST_RESET_TIMESTAMP, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE, MAC_ADDRESS, BOOT_ORDER) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, last_reset_timestamp, zone, space, device_name, description, switch_interface, mac_address, boot_order))
                    con.commit()
                except lite.Error, e:
                    for frame in traceback.extract_tb(sys.exc_info()[2]):
                        fname,lineno,fn,text = frame
                        print( "     in %s on line %d" % (fname, lineno))
                        print("sqlite error: %s" % e)
                        try:
                            con.rollback()
                        except Exception, e:
                            print(" Can't rollback! %s" % e)
try:
    # Open database connection, create cursor
    if os.name == 'nt':
        con = lite.connect(WINDOWS_DB_FILENAME)
    else:
        con = lite.connect(LINUX_OSX_DB_FILENAME)     
except Exception, e:
    print("Can't connect to demosdb! %s" % e)

try:
    open_googlesheet()
except Exception, e:
    print("Can't connect to googlesheet! %s" % e)

init_items()

