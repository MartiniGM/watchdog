#!/usr/bin/python 
import socket, select
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

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = 'mwsheets-91347531e5f4.json.secret'  #srsly DO NOT UPLOAD THE .JSON FILE

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet

#googleSheetURL = 'https://docs.google.com/spreadsheets/d/1wv_s-CBKj56u9JbZtQA-E-dy5efrS9xPLvFu-TqD-xE/edit#gid=0'

# give a filename for the watchdog's log file here
LOG_FILENAME = 'tcp_watchdog_server.out'

PORT = 6666 # port number to watch
NUM_QUEUED_CONNECTIONS = 10 # number of backlogged connections
SOCKET_TIMEOUT = 5.0 # timeout in seconds

# give the size for each rolling log segment, in bytes
LOG_SIZE = 2000000 #2 MB, in bytes
# give the number of rolling log segments to record before the log rolls over
LOG_NUM_BACKUPS = 5 # five .out files before they roll over

# dictionary to load Google spreadsheet into (for device types and descriptions)
googleSheetDict = {}
list_of_lists = []

# load google sheet every hour. it's a bit slow to get the data back so it doesn't reload often, but if you want to trigger it immediately just restart the program
loadGoogleSheetEvery = 3600 #seconds
loadGoogleSheetTimer = time.time()

# set this to 0 to turn off Google spreadsheets and use local database only
# (f.ex if Google ever breaks the API!)
# if 0 (or if there are errors loading the google sheet), the program will default to using the existing value of DEVICE_TYPE and LOCATION in the SQLite DB.
USE_GOOGLE_SHEETS = 1

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
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        googleWorksheet = sh.worksheet(googleWorksheetName)
        
#        googleWorksheet = gc.open_by_url(googleSheetURL).sheet1
        list_of_lists = googleWorksheet.get_all_values()

    except Exception, e:
        logger.error("error in open_googlesheet: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error( "     in %s on line %d" % (fname, lineno))

#['IP ADDRESS', 'Mac Address', 'Hostname', 'Device Name', 'Device Type', 'Zone', 'Space', 'Location Details', 'Description', 'Flow Chart LInk', 'Order']
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
        logger.info("     Google Sheets load OK, %s rows loaded" % googleSheetLen)
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
        logger.error( "empty dictionary in get_item_googlesheet! Did you remember to call open_googlesheet?")
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
#get_all_from_googlesheet()
############################################################
# queries the google spreadsheet dict for type, location, zone, space,
# device name, and description. then returns them along with the MAX_ID_NAME
# for use with Max (Cycling '74)
# otherwise does nothing
def get_all_from_googlesheet(id_name):
    if (USE_GOOGLE_SHEETS != 1):
        # if googlesheets are off, read these back from the database as they already exist
        location = get_item_sqlite(id_name, "LOCATION")
        device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
        zone = get_item_sqlite(id_name, "ZONE")
        space = get_item_sqlite(id_name, "SPACE")
        device_name = get_item_sqlite(id_name, "DEVICE_NAME")
        description = get_item_sqlite(id_name, "DESCRIPTION")
        
        return (location, device_type, zone, space, device_name, description, id_name) #return items as-is from the database
    try:
        #otherwise try to read them from the googlesheet dictionary
        device_type = get_item_googlesheet(id_name, "Device Type")
        location = get_item_googlesheet(id_name, "Location Details")
        zone = get_item_googlesheet(id_name, "Zone")
        space = get_item_googlesheet(id_name, "Space")
        device_name = get_item_googlesheet(id_name, "Device Name")
        description = get_item_googlesheet(id_name, "Description")
        
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
        print "parent " + parent + " child " + child
        print "max_id_name " + max_id_name
        return (location, device_type, zone, space, device_name, description, max_id_name) #return items from googlesheet dictionary
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
            return (location, device_type, zone, space, device_name, description, max_id_name) #return items as-is from the database
        except Exception, e:
            print "get_all_from_googlesheet error #2: %s" % e
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
#if all else fails, return empty items
                return ("", "", "", "", "", "", id_name) #do nothing for now
    
############################################################
#get_type_location_and_max_name()
############################################################
# queries the google spreadsheet dict for type and location, then writes
# them out to the DB along with the MAX_ID_NAME for use with Max (Cycling '74)
# otherwise does nothing
def get_type_location_and_max_name(id_name):
    if (USE_GOOGLE_SHEETS != 1):
# read these back from the database as they already exist
        location = get_item_sqlite(id_name, "LOCATION")
        device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
  #      print "got location " + str(location) + " and type " + str(device_type)
        return (location, device_type, id_name) #do nothing for now
    try:
        device_type = get_item_googlesheet(id_name, "DEVICE_TYPE")
        location = get_item_googlesheet(id_name, "LOCATION / DESCRIPTION")
        if (device_type == ""):
            device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
        if (location == ""):
            location = get_item_sqlite(id_name, "LOCATION")
#        print "id_name " + id_name
#        print "device type " + device_type
#        print "location " + location
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
#            print "parent " + parent + " child " + child
#        print "max_id_name " + max_id_name
        return (location, device_type, max_id_name)
    except Exception, e:
        logger.error("get_type_location_and_max_name error! %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            logger.error("     in %s on line %d" % (fname, lineno))
                   # read these back from the database as they already exist
        try:
            location = get_item_sqlite(id_name, "LOCATION")
            device_type = get_item_sqlite(id_name, "DEVICE_TYPE")
            return (location, device_type, id_name) #do nothing for now
        except Exception, e:
            logger.error("get_type_location_and_max_name error #2: %s" % e)
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                logger.error("     in %s on line %d" % (fname, lineno))
                return ("", "", id_name) #do nothing for now
            
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
        last_reset_time = datetime.datetime.now() - datetime.timedelta(seconds=int(uptime_sec))
        last_reset_timestamp = str(last_reset_time.strftime("%b %d, %Y %H:%M:%S"))
#        print "*****************NOW SETTING BLANK RESET TS TO: " + str(last_reset_timestamp) 
        return last_reset_timestamp
    else:
        if (last_uptime == None):
            #just return the last recorded one so we can write it back to the DB
            last_reset_timestamp = get_item_sqlite(id_name, "LAST_RESET_TIMESTAMP")
            return last_reset_timestamp
        else:
#            print "new uptime " + str(new_uptime) + " old uptime " + str(last_uptime)
            if (int(new_uptime) < int(last_uptime)):
                #detected a device reset since the last time we checked the uptime
                last_reset_time = datetime.datetime.now() - datetime.timedelta(seconds=int(new_uptime))
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
# get_item_sqlite()
############################################################        
# returns location/description string, given an id_name

def get_item_sqlite2(id_name, item_name):
    global con
    try:
        cur = con.cursor()
        if (item_name == "LOCATION"):
            cur.execute("SELECT ID_NAME, LOCATION FROM DEVICES WHERE ID_NAME LIKE\
            ?", ('%'+id_name+'%',))
        else:
            if (item_name == "LAST_UPTIME_SEC"):
                cur.execute("SELECT ID_NAME, LAST_UPTIME_SEC FROM DEVICES WHERE ID_NAME LIKE\
                ?", ('%'+id_name+'%',))
            else:
                if (item_name == "UPTIME_SEC"):
                    cur.execute("SELECT ID_NAME, UPTIME_SEC FROM DEVICES WHERE ID_NAME LIKE\
                    ?", ('%'+id_name+'%',))
                else:
                    if (item_name == "LAST_RESET_TIMESTAMP"):
                        cur.execute("SELECT ID_NAME, LAST_RESET_TIMESTAMP FROM DEVICES WHERE ID_NAME LIKE\
                        ?", ('%'+id_name+'%',))                    
                    else:
                        if (item_name == "DEVICE_TYPE"):
                            cur.execute("SELECT ID_NAME, DEVICE_TYPE FROM DEVIC\
ES WHERE ID_NAME LIKE\
                        ?", ('%'+id_name+'%',))
                        else:
                            if (item_name == "MAX_ID_NAME"):
                                cur.execute("SELECT ID_NAME, MAX_ID_NAME FROM D\
EVICES WHERE ID_NAME LIKE\
                        ?", ('%'+id_name+'%',))
                            else:
                                logger.warning("Unknown item_name in get_item_sqlite: %s" % item_name)
                                return "" #blank item, will show as None in SQL
        data = cur.fetchall()
        for row in data:
            return row[1]
    except lite.Error, e:
        if con:
            con.rollback()
        logger.error(" SQL error! %s" % e)
        return "" #blank item, will show as None in SQL

############################################################
# pi_status_update_sqlite()
############################################################        
# creates a Pi status update with current timestamp (as list of tuples)
# and sends it to sql_data_sqlite

def pi_status_update_sqlite(addr, status):
    id_name = addr
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    data = [(id_name, timestamp, status, 0, "unknown")]
    sql_data_sqlite(data, "DEVICES")

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

def sql_data_sqlite(data, pi_or_arduino):
    global con
    if len(data) == 0:
        return
    logger.debug(data)
    datalist = data[0]
    id_name = datalist[0]
    timestamp = datalist[1]
    status = datalist[2]
    new_status = return_status(status)
    uptime_sec = datalist[3]
    uptime = datalist[4]
    if (len(uptime) == 0):
        # for now only loneduinos fail to send uptime as a string.
        # if so, create a string from the number of seconds rec'd
        sec = int(uptime_sec)
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
    (location, device_type, zone, space, device_name, description, max_id_name) = get_all_from_googlesheet(id_name)
    # insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, MAX_ID_NAME, ZONE, SPACE, DEVICE_NAME, DESCRIPTION) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, max_id_name, zone, space, device_name, description))
        con.commit()
    except lite.Error, e:
        logger.error(" sqlite error: %s" % e)
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
            table = "DEVICES"
            #also get location, device type, and max name from google sheet
            #            (location, device_type, max_id_name) = get_type_location_and_max_name(id_name)
            (location, device_type, zone, space, device_name, description, max_id_name) = get_all_from_googlesheet(id_name)
            logger.info(id_name + " silent for " + str(total_seconds) + " seconds, setting " + status + " with uptime " + uptime)
            try:
                cur = con.cursor()
                cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME, LAST_UPTIME_SEC, LOCATION, DEVICE_TYPE, MAX_ID_NAME, ZONE, SPACE, DEVICE_NAME, DESCRIPTION) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",  (id_name,timestamp,status, uptime_sec,uptime,uptime_sec, location, device_type, max_id_name, zone, space, device_name, description))
                con.commit()
            except lite.Error, e:
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
            logger.error("sqlite error: %s" % e)
            con.rollback()
                
############################################################                
############################################################
# main()
############################################################
############################################################

if __name__ == "__main__":
      
    CONNECTION_LIST = []    # list of socket clients
    RECV_BUFFER = 4096      # Advisable to keep it as an exponent of 2

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
    except socket.error, e:
        print "socket error: " + e
        
    #    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#    server_socket.settimeout(SOCKET_TIMEOUT) 
 
    # check and turn on TCP keepalive -- this ensures that we'll get 
    # disconnect errors from clients that go away#
#    x = server_socket.getsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE)
#    if (x == 0):
#        x = server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)

        # overrides value (in seconds) for the TCP keepalives. Only works on linux, not on windows
        # 60 secs to 1st timeout, 4 retries @ 15 secs per = 2 mins til timeout
#        if (os.name == 'linux'):
#            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPIDLE, 60)
            # overrides value shown by sysctl net.ipv4.tcp_keepalive_probes
#            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPCNT, 4)
            # overrides value shown by sysctl net.ipv4.tcp_keepalive_intvl
#            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPINTVL, 15)
    
#    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
#    server_socket.bind(("0.0.0.0", PORT))
#    server_socket.listen(NUM_QUEUED_CONNECTIONS)
 
    # Add server socket to the list of readable connections
#    CONNECTION_LIST.append(server_socket)
 
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

        data, address = server_socket.recvfrom(1024)
        print data
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
                        sql_data_sqlite(data3, "ARDUINOS")
                        # otherwise, just log one message
            else:
                data2 = listify_data(data)
                sql_data_sqlite(data2, "ARDUINOS")
                        
    ##################
    # EXIT
    ##################                
    # upon exit, disconnect from sqlite and close sockets
    exit_func()
