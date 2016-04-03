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

device_type_item_id = 5
hostname_item_id = 4
ip_address_item_id = 1

# set this to 0 to turn off Google spreadsheets, if so this does nothing!
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
# opens Google spreadsheet for later use. then use get_item_googlesheet to access the data as often as you like
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
            
#['IP ADDRESS', 'Mac Address', 'Hostname', 'Device Name', 'Device Type', 'Zone', 'Space', 'Location Details', 'Description', 'Flow Chart LInk', 'Order', 'Switch Interface']
    try:
        #create searchable dictionary with ID_NAME as the key!
        googleSheetDict = defaultdict(list)
        for listy in list_of_lists:
            googleSheetDict[listy[1]] += listy[2:]
        googleSheetLen = len(googleSheetDict)    
        if googleSheetLen == 0:
            print("     Google Sheets load failed? %s rows loaded" % googleSheetLen)      
        else:
            print("     Google Sheets load OK, %s rows loaded" % googleSheetLen)
            
    except Exception, e:
        print("error when iterating over Google sheet %s with json file %s: %s" % (googleSheetKey, json_file, e))
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))

############################################################
#get_item_googlesheet()
############################################################
# queries google spreadsheet for id_name, returns string in item_name position
# otherwise returns empty string ("")
def get_item_googlesheet(id_name, item_name):
    global googleSheetDict
    if (bool(googleSheetDict) == False):
        print( "empty dictionary in get_item_googlesheet! Please check google sheets access?")
        return ""
    header_item = googleSheetDict["IP ADDRESS"]
    try:
        item_id = header_item.index(item_name)
        our_item = googleSheetDict[id_name]
#        print our_item
        return str(our_item[item_id])
    except IndexError:
        print("dict entry '%s' not found" % id_name)
        return ""
    except ValueError:
        print("column '%s' not found" % item_name)
        return ""
    except Exception, e:
        print( "error in get_item_googlesheet! %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        return ""

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
#get_items_from_googlesheet_forsave()
############################################################
def find_item(mylist, item_name):
     #gets the position of "item" in the sublists & returns
    for item in mylist:
        i = 0
        for subitem in item:
            if subitem == item_name:
                item_id = i
                print "found  " + item_name + " at " + str(item_id)
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

def do_pis(mylist):
    for item in mylist:
        do_a_host(item, "pi")
        
############################################################
#do_a_linux: takes a list, creates one .cfg file for the teensy in the list
############################################################ 
def do_a_host(mylist, compare):
    try:

            ip_address = mylist[ip_address_item_id]
            device_type = mylist[device_type_item_id]

            if compare not in device_type.lower():
                print "Error? Can't tell if this is a %s, skipping: %s" % (compare, str(mylist))
                return -1

            if ip_address is None or ip_address == '':
                print "No 'IP ADDRESS' in the Master Doc for this device, skipping:" + str(mylist)
                return -1

            #do the thing
            command = "/Users/Guest/watchdog/tcp_watchdog_server/install_pi_volumeconfig.exp " + str(ip_address)
            os.system(command)
            
    except Exception, e:
        print "error in do_linux"
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return an error
        return -1
    
############################################################                
############################################################
# main()
############################################################
############################################################

if __name__ == "__main__":

    if (USE_GOOGLE_SHEETS == 1):
        try:
            open_googlesheet()
        except Exception, e:
            print("Can't connect to googlesheet! %s" % e)
            
        #######################
        # GOOGLE SHEET UPDATE
        #######################
        if (USE_GOOGLE_SHEETS == 1):
            try:

                #opens the sheet and builds a list of every type that should be in nagios
                open_googlesheet()
                print list_of_lists[0][5]
                device_type_item_id = find_item(list_of_lists, "Device Type")
                hostname_item_id = find_item(list_of_lists, "Device Name")
                ip_address_item_id = find_item(list_of_lists, "IP ADDRESS")
                alias_item_id = find_item(list_of_lists, "Device Name")
                description_item_id = find_item(list_of_lists, "Description")
                print "ids: device %d hostname %d ip_address %d alias %d" % (device_type_item_id, hostname_item_id, ip_address_item_id, alias_item_id)
                #sorts by device type
                list_of_lists.sort(key=lambda x: x[5])
                #creates list of pis
                print "PIS"
                pi_list = subfinder(list_of_lists, "berry")
                print pi_list
                print
                print
            except Exception, e:
                print("Hit error in main: %s" % e)

            #then steps over each list, installing the watchdog
            try:
                do_pis(pi_list)
            except Exception, e:
                print("Hit error in do_pis: %s" % e)
