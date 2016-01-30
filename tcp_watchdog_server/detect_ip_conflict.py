#!/usr/bin/python 
import socket
import sqlite3 as lite
import datetime
import time
import os
import errno
import re
import logging
import logging.handlers
import sys
import signal
import traceback
from collections import defaultdict
from operator import itemgetter
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

# nagios destination directory. Should be something like /tmp/nagios/objects/hosts.
# DO NOT use the nagios directory itself, it's way safer to create them in tmp and copy them over!
nagios_dir = "/tmp/nagios/objects/hosts/"
teensy_dir = "arduinos"
arduino_dir = "arduinos"
pi_dir = "pis"
windows_dir = "windows"
switch_dir = "switch"

device_type_item_id = 5
hostname_item_id = 4
ip_address_item_id = 1
description_item_id = 9

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

####################
# EXIT HANDLER
####################                

# upon exit, log exit msg, disconnect from sqlite and close sockets
def exit_func():
    print ("close")
    con.close()
    server_socket.close()
    sys.exit(0)
    
# exits the program cleanly, logging exit time
def signal_handler(signal, frame):
    print ""
    exit_func()

signal.signal(signal.SIGINT, signal_handler)

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
        print("error in open_googlesheet: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))

            ############################################################
#get_items_from_googlesheet_forsave()
############################################################
def find_item(mylist, item_name):
     #gets the position of "item" in the sublists & returns
    for item in mylist:
        i = 0
        for subitem in item:
            if subitem == item_name:
                item_id = i
#                print "found  " + item_name + " at " + str(item_id)
                return item_id
            i = i + 1

############################################################
#subfinder() takes a list of lists and a pattern. finds pattern in the
# "Device Type" column of the list of lists. Returns a list of all lists
# that matched.
############################################################
def subfinder(mylist, pattern):
    matches = []
    try:
        #and then gets every item where the device type matches the pattern 
        for item in mylist:
#            print "%s in %s?" % (pattern, item[item_id])
            if pattern in item[device_type_item_id]:
                matches.append(item)
        return matches
    except Exception, e:
        print "error in subfinder: %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return blank list
        return []

if __name__ == "__main__":

    if (USE_GOOGLE_SHEETS == 1):
        try:
            open_googlesheet()
        except Exception, e:
            print("Can't connect to googlesheet! %s" % e)
            
        try:

            #opens the sheet and builds a list of every type that should be in nagios
            open_googlesheet()
#            print list_of_lists[0][5]
            device_type_item_id = find_item(list_of_lists, "Device Type")
            hostname_item_id = find_item(list_of_lists, "Device Name")
            ip_address_item_id = find_item(list_of_lists, "IP ADDRESS")
            alias_item_id = find_item(list_of_lists, "Device Name")
            description_item_id = find_item(list_of_lists, "Description")
            #sorts by device type
            list_of_lists.sort(key=lambda x: x[ip_address_item_id])
#            print list_of_lists
            last_item = ['', '', '', '', '', '', '', '', '', '', '']
            for item in list_of_lists:
                if item[ip_address_item_id] != '' and item[ip_address_item_id] != "n/a":
                    if item[ip_address_item_id] == last_item[ip_address_item_id]:
                        print "***POSSIBLE IP CONFLICT: %s (%s) and %s (%s)" % (item[hostname_item_id], item[ip_address_item_id], last_item[hostname_item_id], last_item[ip_address_item_id])
                last_item = item
            
        except Exception, e:
            print "error %s" % e
