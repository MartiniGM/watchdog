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
periodic_period = 120 #seconds 
periodic_timer = time.time() #initialize timer

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = 'demosdb.db'

# set this to 0 to turn off Google spreadsheets and use local database only
# (f.ex if Google ever breaks the API!)
# if 0 (or if there are errors loading the google sheet), the program will default to using the googlesheet_backup table in the SQLite DB. If that fails, it will write back any existing values from the DB.
USE_GOOGLE_SHEETS = 1

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = 'mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet

# dictionary to load Google spreadsheet into (for device types and descriptions)
googleSheetDict = {}
list_of_lists = []

# load google sheet every hour. it's a bit slow to get the data back so it doesn't reload often, but if you want to trigger it immediately just restart the program
LOADSHEET_SLOW = 3600 #seconds, once the initial load gets at least 1 row
LOADSHEET_FAST = 200 #seconds, as long as all loads have failed
loadGoogleSheetEvery = LOADSHEET_FAST #starts with fast loads until it succeeds
loadGoogleSheetTimer = time.time()

# give a filename for the watchdog's log file here
LOG_FILENAME = 'tcp_watchdog_server.out'

PORT = 6666 # port number to watch

# give the size for each rolling log segment, in bytes
LOG_SIZE = 2000000 #2 MB, in bytes
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
        global json_file
        global googleSheetKey
        global googleWorksheet
        global list_of_lists
        global loadGoogleSheetEvery 
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        googleWorksheet = sh.worksheet(googleWorksheetName)
        
        list_of_lists = googleWorksheet.get_all_values()

    except Exception, e:
        logger.error("error in open_googlesheet: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))
            
#['IP ADDRESS', 'Mac Address', 'Hostname', 'Device Name', 'Device Type', 'Zone', 'Space', 'Location Details', 'Description', 'Flow Chart LInk', 'Order', 'Switch Interface']
    try:
        #create searchable dictionary with ID_NAME as the key!
        googleSheetDict = defaultdict(list)
        for listy in list_of_lists:
            #googleSheetDict[listy[0]] += listy[1:]
            googleSheetDict[listy[1]] += listy[2:]
        googleSheetLen = len(googleSheetDict)    
        #for keys,values in googleSheetDict.items():
        #    print(keys)
        #    print(values)
        if googleSheetLen == 0:
            # set slower loads after load gets at least one row
            # if not, try to reload much more often.
            loadGoogleSheetEvery = LOADSHEET_FAST #seconds
            logger.info("     Google Sheets load failed? %s rows loaded" % googleSheetLen)      
        else:
            #the load got at least one row. Save everything in the DB 
            loadGoogleSheetEvery = LOADSHEET_SLOW #seconds
            logger.info("     Google Sheets load OK, %s rows loaded" % googleSheetLen)
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
#        print "item_id " + str(item_id) + " for " + id_name
        our_item = googleSheetDict[id_name]
#        print our_item
        return str(our_item[item_id])
    except IndexError:
        logger.warning("dict entry '%s' not found" % id_name)
        return ""
    except ValueError:
        logger.warning("column '%s' not found" % item_name)
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
        (location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, flow_chart_link, order) = get_items_from_googlesheet_forsave(key)
#        print (location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, flow_chart_link, order)
        try:
            cur = con.cursor()
            cur.execute("INSERT OR REPLACE INTO GOOGLESHEET_BACKUP(IP_ADDRESS, LOCATION, DEVICE_TYPE, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE, MAC_ADDRESS, HOSTNAME, FLOW_CHART_LINK, GS_ORDER) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", (key, location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, flow_chart_link, order))
            con.commit()
        except lite.Error, e:
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
            print " sqlite error: %s" % e
            con.rollback()

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
            con.rollback()
        print(" SQL error! %s" % e)
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
    flow_chart_link = get_item_googlesheet(id_name, "Flow Chart LInk")
    order = get_item_googlesheet(id_name, "Order")
    
    return (location, device_type, zone, space, device_name, description, switch_interface, mac_address, hostname, flow_chart_link, order) #return items from googlesheet dictionary

############################################################
#get_items_from_googlesheet()
############################################################
#gets all googlesheet items from the GS backup. If that fails, get the
#current values from the sqlite DB.
def get_items_from_googlesheet(id_name):
    location = get_item_googlesheet(id_name, "Location Details")
    if location == "" or location is None:
        location = get_item_from_googlesheet_backup(id_name, "LOCATION")
        if location == "" or location is None:
            location = get_item_sqlite(id_name, "LOCATION")
            
    device_type = get_item_googlesheet(id_name, "Device Type")
    if device_type == "" or device_type is None:
        device_type = get_item_from_googlesheet_backup(id_name, "DEVICE_TYPE")
        if device_type == "" or device_type is None:
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

    description = get_item_googlesheet(id_name,  "Description")
    if description == "" or description is None:
        description = get_item_from_googlesheet_backup(id_name,  "DESCRIPTION")
        if description == "" or description is None:
            description = get_item_sqlite(id_name, "DESCRIPTION")

    switch_interface = get_item_googlesheet(id_name, "Switch Interface")
    if switch_interface == "" or switch_interface is None:
        switch_interface = get_item_from_googlesheet_backup(id_name, "SWITCH_INTERFACE")
        if switch_interface == "" or switch_interface is None:
            switch_interface = get_item_sqlite(id_name, "SWITCH_INTERFACE")

    return (location, device_type, zone, space, device_name, description, switch_interface) #return items, either from GS backup or as-is from the database

############################################################
#get_all_from_googlesheet()
############################################################
# queries the google spreadsheet dict for type, location, zone, space,
# device name, and description. then returns them along with the MAX_ID_NAME
# for use with Max (Cycling '74)
# otherwise does nothing
def get_all_from_googlesheet(id_name):
#    if (USE_GOOGLE_SHEETS != 1):
        # if googlesheets are off, read these back from the GS backup or from the database as they already exist
    try:
        (location, device_type, zone, space, device_name, description, switch_interface) = get_items_from_googlesheet(id_name)
    except Exception, e:
        print "get_all_from_googlesheet error: %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
        return ("", "", "", "", "", "", "", id_name)
    
    #got data back and all is well. now parse max_id_name and return
    parent_child_list = id_name.split('/', 1)
    if len(parent_child_list) > 1:
        (parent, child) = parent_child_list
        if (device_type is not None and len(device_type) > 0):
            max_id_name = str(parent) + "/" + str(device_type) + "/" + str(child)
        else:
            max_id_name = str(parent) + "/" + "UNKNOWN" + "/" + str(child)
    else:
        parent = id_name
        child = ""
        if (device_type is not None and len(device_type) > 0):
            max_id_name = str(parent) + "/" + str(device_type) 
        else:
            max_id_name = str(parent) + "/" + "UNKNOWN"
    #print "parent " + parent + " child " + child
    #print "max_id_name " + max_id_name
    return (location, device_type, zone, space, device_name, description, switch_interface, max_id_name) #return items from googlesheet dictionary
    
############################################################
#get_all_from_googlesheet_old()
############################################################
# queries the google spreadsheet dict for type, location, zone, space,
# device name, and description. then returns them along with the MAX_ID_NAME
# for use with Max (Cycling '74)
# otherwise does nothing
def get_all_from_googlesheet_old(id_name):
    if (USE_GOOGLE_SHEETS != 1):
        # if googlesheets are off, read these back from the database as they already exist
        location = get_item_sqlite(id_name, "LOCATION")
        device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
        zone = get_item_sqlite(id_name, "ZONE")
        space = get_item_sqlite(id_name, "SPACE")
        device_name = get_item_sqlite(id_name, "DEVICE_NAME")
        description = get_item_sqlite(id_name, "DESCRIPTION")
        switch_interface = get_item_sqlite(id_name, "SWITCH_INTERFACE")
        return (location, device_type, zone, space, device_name, description, switch_interface, id_name) #return items as-is from the database
    try:
        #otherwise try to read them from the googlesheet dictionary
        device_type = get_item_googlesheet(id_name, "Device Type")
        location = get_item_googlesheet(id_name, "Location Details")
        zone = get_item_googlesheet(id_name, "Zone")
        space = get_item_googlesheet(id_name, "Space")
        device_name = get_item_googlesheet(id_name, "Device Name")
        description = get_item_googlesheet(id_name, "Description")
        switch_interface = get_item_googlesheet(id_name, "Switch Interface")
        
        parent_child_list = id_name.split('/', 1)
        if len(parent_child_list) > 1:
            (parent, child) = parent_child_list
            if (len(device_type) > 0):
                max_id_name = str(parent) + "/" + str(device_type) + "/" + str(child)
            else:
                max_id_name = str(parent) + "/" + "UNKNOWN" + "/" + str(child)
        else:
            parent = id_name
            child = ""
            if (len(device_type) > 0):
                max_id_name = str(parent) + "/" + str(device_type) 
            else:
                 max_id_name = str(parent) + "/" + "UNKNOWN"
        #print "parent " + parent + " child " + child
        #print "max_id_name " + max_id_name
        return (location, device_type, zone, space, device_name, description, switch_interface, max_id_name) #return items from googlesheet dictionary
    except Exception, e:
        #if the googlesheet read fails, read them from the database
        print "get_all_from_googlesheet error: %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
        # read these back from the database as they already exist
        try:
            location = get_item_sqlite(id_name, "LOCATION")
            device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
            zone = get_item_sqlite(id_name, "ZONE")
            space = get_item_sqlite(id_name, "SPACE")
            device_name = get_item_sqlite(id_name, "DEVICE_NAME")
            description = get_item_sqlite(id_name, "DESCRIPTION")
            switch_interface = get_item_sqlite(id_name, "SWITCH_INTERFACE")
            return (location, device_type, zone, space, device_name, description, switch_interface, max_id_name) #return items as-is from the database
        except Exception, e:
            print "get_all_from_googlesheet error #2: %s" % e
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
#if all else fails, return empty items
                return ("", "", "", "", "", "", "", id_name) #do nothing for now
            
############################################################
#return_last_reset()
############################################################
# figures last detected reset time and returns as timestamp string
def return_last_reset(new_uptime, last_uptime, id_name):
    last_reset_timestamp_check = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
    uptime_sec = get_item_sqlite(id_name, "UPTIME_SEC")
  #  print "*******************last check is " + str(last_reset_timestamp_check) + " uptime is " + str(uptime_sec)
    if (last_reset_timestamp_check == None and uptime_sec != None):
        #get the uptime and subtract from the current time to create baseline ts
        last_reset_time = datetime.datetime.now() - datetime.timedelta(seconds=int(float(uptime_sec)))
        last_reset_timestamp = str(last_reset_time.strftime("%b %d, %Y %H:%M:%S"))
#        print "*****************NOW SETTING BLANK RESET TS TO: " + str(last_reset_timestamp) 
        return last_reset_timestamp
    else:
        if (last_uptime == None):
            #just return the last recorded one so we can write it back to the DB
            last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
            return last_reset_timestamp
        else:
            #print "new uptime " + str(new_uptime) + " old uptime " + str(last_uptime)
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
        
############################################################
#return_status()
############################################################
# returns new human-friendly status strings, given internal codes

def return_status(stat):
    if stat is None:
        return "UNKNOWN" # in case something badly formatted got into the database
    
    if ('CLEAR' in stat):
        return "OKAY"
    else:
        if ('DISCON' in stat):
            return "DISCONNECT"
        else:
            if ('PIPE' in stat):
                return "BROKEN_PIDUINO_LINK"
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
            con.rollback()
        print(" SQL error! %s" % e)
        return "" #blank item, will show as None in SQL
    
############################################################
# listify_data()
############################################################            
# splits string input into a formatted list of tuples and returns it.
# this is intended to match the way SQLite returns values, so we can use the
# same functions to parse both.

def listify_data(data):
    if len(data) == 0:
        return
    data_list = data.split();
    status = data_list[0]
    new_status = return_status(status)
    id_name = data_list[1]
    uptime_sec = data_list[2]
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    strr = " "
    uptime = strr.join(data_list[3:])
    return [(id_name, timestamp, new_status, uptime_sec, uptime)]

############################################################
# sql_data_sqlite()
############################################################        
# parses data (as a list of tuples, either from SQLite or listify_data) a
# and updates SQLite

def sql_data_sqlite(data, pi_or_arduino, ip):
    global con
    if len(data) == 0:
        return
    logger.debug(data)
    datalist = data[0]
    if len(datalist) != 5:
        print "got the IP address error"        
        id_name = ip
        timestamp = datalist[0]
        status = datalist[1]
        new_status = return_status(status)
        uptime_sec = datalist[2]
        uptime = datalist[3]
    else:
        id_name = datalist[0]
        if (id_name[0] == '/'):
            print "got the IP address error"
            id_name = ip + id_name
        timestamp = datalist[1]
        status = datalist[2]
        new_status = return_status(status)
        uptime_sec = datalist[3]
        uptime = datalist[4]
    if (len(uptime) == 0):
        # for now only loneduinos fail to send uptime as a string.
        # if so, create a string from the number of seconds rec'd
        sec = int(float(uptime_sec))
        mins = sec/60
        hours = mins/60
        days = hours / 24

        sec=sec-(mins*60)     # subtract the coverted seconds to minutes 
        mins=mins-(hours*60)  # subtract the coverted minutes to hours 
        hours=hours-(days*24) # subtract the coverted hours to days 
        uptime = "%d days, %02d:%02d:%02d" % (days, hours, mins, sec)

    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    last_uptime = get_item_sqlite(id_name, "LAST_UPTIME_SEC")
    logger.info(id_name + " reports " + new_status + " with uptime " + uptime)

    #gets timestamp of last detected reset from the new/old uptime
    last_reset_timestamp = return_last_reset(uptime_sec, last_uptime, id_name)
    #reset uptime and write back to the database
    last_uptime = uptime_sec
    #also get location, device type, and max name from google sheet
    #    (location, device_type, max_id_name) = get_type_location_and_max_name(id_name)
    (location, device_type, zone, space, device_name, description, switch_interface, max_id_name) = get_all_from_googlesheet(id_name)
    # insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, LAST_RESET_TIMESTAMP, MAX_ID_NAME, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, last_reset_timestamp, max_id_name, zone, space, device_name, description, switch_interface))
        con.commit()
    except lite.Error, e:
        logger.error(" sqlite error: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print "     in %s on line %d" % (fname, lineno)
        con.rollback()
        
############################################################
# parse_data_sqlite()
############################################################        
# parses/checks for periodic disconnects; if found, inserts NOREPLY into SQLite

def parse_data_sqlite(data):
    num_okay = 0
    num_total = 0
    for row in data:
        num_total += 1
#        logger.info("row is " + str(row))
        id_name = row[0]
        timestamp = row[1]
        status = row[2]
        new_status = return_status(status)
#        location = get_item_sqlite(id_name, "LOCATION")
        last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
        uptime_sec = row[3]
        uptime = row[4]
        time_cur = datetime.datetime.now()
        if timestamp is not None:
            time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%M:%S")
        else:
            time_ts = datetime.datetime.time()
        total_seconds = ((time_cur-time_ts).seconds)
#        logger.debug("total seconds between times: " + str(total_seconds))
        if (total_seconds > periodic_period):
            # more than X seconds since last message. update this entry with NOREPLY
#            logger.debug("More than %d minutes for %s" % (periodic_period / 60, id_name))
            timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
            status = "NONRESPONSIVE"
            #also get location, device type, and max name from google sheet
            #            (location, device_type, max_id_name) = get_type_location_and_max_name(id_name)
            (location, device_type, zone, space, device_name, description, switch_interface, max_id_name) = get_all_from_googlesheet(id_name)
            logger.info(id_name + " silent for " + str(total_seconds) + " seconds, setting " + status + " with uptime " + uptime)
            try:
                cur = con.cursor()
                cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, LAST_RESET_TIMESTAMP, MAX_ID_NAME, ZONE, SPACE, DEVICE_NAME, DESCRIPTION, SWITCH_INTERFACE) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, last_reset_timestamp, max_id_name, zone, space, device_name, description, switch_interface))
                con.commit()
            except lite.Error, e:
                for frame in traceback.extract_tb(sys.exc_info()[2]):
                    fname,lineno,fn,text = frame
                    print "     in %s on line %d" % (fname, lineno)
                logger.error("sqlite error: %s" % e)
                con.rollback()
        else:
            #this item was OK if its status says OKAY
            if (new_status == "OKAY"):
                num_okay += 1
    # report / save system stats            
    if (num_total == 0):
        return
    else:
        percent_okay = (float(num_okay) / float(num_total)) * 100.0
        info_id_name = "SYSTEM_INFO"
        logger.info(">>>>>>>>>>System Info: total is %d, okay %d, %d%% OK" % (num_total, num_okay, percent_okay))
        try:
            cur = con.cursor()
            cur.execute("INSERT OR REPLACE INTO SYSTEM_INFO(ID_NAME, NUM_DEVICES, NUM_OKAY_DEVICES, PERCENT_OKAY) values (?, ?, ?, ?)",  (info_id_name, num_total, num_okay, percent_okay))
            con.commit()
        except lite.Error, e:
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
            logger.error("sqlite error: %s" % e)
            con.rollback()
                
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
    LEVELS = { 'debug':logging.DEBUG,
            'info':logging.INFO,
            'warning':logging.WARNING,
            'error':logging.ERROR,
            'critical':logging.CRITICAL,
            }
    
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
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
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
        print "socket error: %s" % e
        
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
                #                update_from_googlesheet()
                open_googlesheet()
                loadGoogleSheetTimer = time.time()
                
        #######################
        # PERIODIC DATA CHECK
        #######################
        # periodic data check. Checks SQLite every X seconds for lack of replies

        if (time.time() - periodic_timer > periodic_period):
            data = get_pis_sqlite("DEVICES")
#            print data
            parse_data_sqlite(data)
            periodic_timer = time.time()
        
        try:
            data, address = server_socket.recvfrom(1024)
            #print data
            if (data):
                print "-----Client (%s) connected, sent %s" % (address, data)
            #######################
            # DATA RECEIVED
            #######################
            # at this point we got data, so log it
            
                if data.count("ERRPI") + data.count("ERRDUINO") > 1:
                # we may get more than one message at a time
                # due to the way TCP works. If so, split 'em.
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
