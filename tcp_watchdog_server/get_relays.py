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
import shutil
import argparse
from collections import defaultdict
# to install the three below:
# "pip install gspread; pip install oauth2client; pip install PyOpenSSL"
# install pip first if you don't have it, on windows just google "get-pip.py".
# on Mac OS use "easy_install pip"
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

device_type_item_id = 5
device_name_item_id = 0
mac_address_item_id = 0
hostname_item_id = 4
ip_address_item_id = 1
zone_item_id = 8

relay_list = []
device_name_list = []
zones_list = [["arcade", []], ["art city", []], ["beamcade", []], ["caves", []], ["forest", []], ["house", []], ["portals", []], ["shanty", []], ["theater", []]]

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = 'mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet
googleWorksheetNameRelays = "Circuits and Relays" #name of the tab on the google sheet

# dictionary to load Google spreadsheet into (for device types and descriptions)
googleSheetDict = {}
googleSheetDictRelays = {}
list_of_lists = []
list_of_lists_relays = []

USE_GOOGLE_SHEETS = 1

############################################################
#get_items_from_googlesheet_forsave()
############################################################
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
# "Device Type" column of the list of lists. Returns a list of all lists
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

# there are devices we don't want to control: cameras, global audio servers, etc Only add the ones that match controllable types
def check_type(type_str):
    if "berry" in type_str or "indows" in type_str or "eensy" in type_str or "duino" in type_str:
        return True
    else:
        return False
    
############################################################
#opens the googlesheet and reads it into a list of Pis and a list of all items
############################################################         
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
        global device_name_list
        global pi_list
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        googleWorksheet = sh.worksheet(googleWorksheetName)
        
        # reads every item from the Networked Devices tab
        list_of_lists = googleWorksheet.get_all_values()
        googleWorksheetRelays = sh.worksheet(googleWorksheetNameRelays)
        list_of_lists_relays = googleWorksheetRelays.get_all_values()
        print "LIST OF RRELAYS"
        print list_of_lists_relays
        
        device_name_item_id = find_item(list_of_lists, "Device Name")
        zone_item_id = find_item(list_of_lists, "Zone")
        ip_address_item_id = find_item(list_of_lists, "IP ADDRESS")
        device_type_item_id = find_item(list_of_lists, "Device Type")
        hostname_item_id = find_item(list_of_lists, "Device Name")
        alias_item_id = find_item(list_of_lists, "Device Name")
        description_item_id = find_item(list_of_lists, "Description")
        
        # makes a list of every mac address and device name for which both exist
        for item in list_of_lists:
            zone = item[zone_item_id].replace(':','').lower()
            remote_ip = item[ip_address_item_id]
            device_name = item[device_name_item_id]
            device_type = item[device_type_item_id]
            if zone is not None and zone != "":
                if (device_name is not None and
                device_name != "" and
                device_name.lower() != "default" and
                    #don't include the relay controllers themselves!
                "CONTROLLER" not in device_name and
                remote_ip != "" and remote_ip is not None and
                check_type(device_type) is True):
                    item2 = (zone, device_name, remote_ip, device_type)
                    device_name_list.append(item2)

        print "made a list from master doc"
#        print device_name_list

        #and does the same for the Circuits and Relays tab
        circuit_name_item_id = find_item(list_of_lists_relays, "Circuit Name")
        circuit_on_relay_item_id = find_item(list_of_lists_relays, "On Relay")
        circuit_zone_item_id = find_item(list_of_lists_relays, "Zone")
        circuit_space_item_id = find_item(list_of_lists_relays, "Space")
        for item in list_of_lists_relays:
            zone = item[circuit_zone_item_id].replace(':','').lower()
            circuit_on_relay = item[circuit_on_relay_item_id].replace(':','').lower()
            circuit_space = item[circuit_space_item_id]
            circuit_name = item[circuit_name_item_id]
            
            if zone is not None and zone != "" and circuit_on_relay == "yes":
                item2 = (zone, circuit_name, circuit_on_relay, "Relay")
                relay_list.append(item2)

        print "made a list from master doc"
        print device_name_list
        
        # sorts by zone
        list_of_lists.sort(key=lambda x: x[zone_item_id])
        # sorts by zone
        relay_list.sort(key=lambda x: x[0])
    except Exception, e:
        print  "error in open_googlesheet: %s" % e


############################################################
# return_name: finds a name in the device list and returns the item
############################################################         
def return_name(c):
    matches = []
    global device_name_list
    for item in device_name_list:
        try:
            print ("compare %s to %s" % (item[0].lower(), c))
            if item[0].lower() == c:
                print "matched!!!"
                matches.append(item[1])
        except Exception, e:
            print "oops %s" % e
    return matches

########################################################################
# MAIN MAIN MAIN MAIN etc yeah I said it, it's MAIN
########################################################################    

# open the sheet & create lists, one of devices and one of relays
open_googlesheet()

# sorts by zone. maybe superfluous, but this sort of indulgence is why we can have nice things
device_name_list.sort(key=lambda x: x[0])

# creates list of lists of lists: first element in each sublist is the zone name, second is the list of devices for that zone.
for item in zones_list:
    print
    print item[0]
    item[1] = subfinder(device_name_list, item[0], 0)
    item2 = subfinder(relay_list, item[0], 0)
    for subitem in item2:
        item[1].append(subitem)
    #sorts by type
    item[1].sort(key=lambda x: x[3])
    print item[1]
        
#print "relays:"
#for item in relay_list:
#    print item
