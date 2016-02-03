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

device_type_item_id = 5
device_name_item_id = 0
mac_address_item_id = 0
hostname_item_id = 4
ip_address_item_id = 1

interface_list = []
device_name_list = []

# json file to hold Google credentials.
# ----> DO NOT EVER UPLOAD the .json file to public access (github)! <----
json_file = 'mwsheets-91347531e5f4.json.secret'
# ----> srsly DO NOT DO NOT DO NOT UPLOAD THE .JSON FILE <----

# URL for the google sheet. this can be public
googleSheetKey = "1kHAcbAo8saNSTBc7ffidzrwu_FGK3FaBpmh7rO7hT-U"
googleWorksheetName = "Networked Devices" #name of the tab on the google sheet

# dictionary to load Google spreadsheet into (for device types and descriptions)
googleSheetDict = {}
googleSheetDictSwitches = {}
list_of_lists = []
list_of_lists_switches = []

# load google sheet every hour. it's a bit slow to get the data back so it doesn't reload often, but if you want to trigger it immediately just restart the program
LOADSHEET_SLOW = 3600 #seconds, once the initial load gets at least 1 row
LOADSHEET_FAST = 200 #seconds, as long as all loads have failed
loadGoogleSheetEvery = LOADSHEET_FAST #starts with fast loads until it succeeds
loadGoogleSheetTimer = time.time()
USE_GOOGLE_SHEETS = 1

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
        json_key = json.load(open(json_file))
        scope = ['https://spreadsheets.google.com/feeds']
        
        credentials = SignedJwtAssertionCredentials(json_key['client_email'], json_key['private_key'], scope)
        
        gc = gspread.authorize(credentials)
        sh = gc.open_by_key(googleSheetKey)
        googleWorksheet = sh.worksheet(googleWorksheetName)
        
        list_of_lists = googleWorksheet.get_all_values()

        device_name_item_id = find_item(list_of_lists, "Device Name")
        mac_address_item_id = find_item(list_of_lists, "Mac Address")
        
        for item in list_of_lists:
            mac_address = item[mac_address_item_id].replace(':','').lower()
            device_name = item[device_name_item_id]
            if mac_address is not None and mac_address != "":
                if device_name is not None and device_name != "" and device_name.lower() != "default":
                    item2 = (mac_address, device_name)
                    device_name_list.append(item2)

#        print "made a list"
        print device_name_list
            
    except Exception, e:
        print  "error in open_googlesheet: %s" % e
            
def return_name(c):
    matches = []
    for item in device_name_list:
        try:
            if item[0].lower() == c:
#                print "match %s" % item[1]
                matches.append(item[1])
        except Exception, e:
            print "oops %s" % e
    return matches

############################################################
#do_a_switch: takes an ip, grabs interfaces for items in the switch,
#returns as a (mac_address, interface) tuple 
############################################################ 
def do_a_switch(ip_address):
    import subprocess
    try:
        if ip_address is None or ip_address == '':
            print "No 'IP ADDRESS' in the Master Doc for this device, skipping:" + str(mylist)
            return -1

            #do the thing
        command = "/Users/Guest/watchdog/get-mac-addr.exp meow %s | grep ' 16 ' | grep Fa" % str(ip_address)
        print "command " + command
        output = subprocess.check_output(command, shell=True)
        for row in output.split('\n'):
            listy = row.split()
            if (len(listy) >= 6):
                mac_addr = listy[4].replace('.', '').lower()
#                print "searching for %s" % mac_addr
                matches = return_name(mac_addr)
                if matches == []:
#                    print "blank match"
                    continue
                else:
                    if len(matches) != 1:
                        print "Error: multiple identical MAC addresses %s" % matches
                    else:
                        print "%s matched %s" % (mac_addr, matches)
                        match = matches[0]
                        inter = listy[6].replace("Fa", "FastEthernet")
                        this_interface = (ip_address, match, mac_addr, inter)
                        interface_list.append(this_interface)
        
    except Exception, e:
        print "error in do_a_switch %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return an error
        return -1

open_googlesheet()
#do_a_switch("10.42.0.13")
switches = ["10.42.0.3","10.42.0.4","10.42.0.5","10.42.0.6","10.42.0.7",
            "10.42.0.8","10.42.0.9","10.42.0.10","10.42.0.11","10.42.0.12",
            "10.42.0.13", "10.42.0.14"]
for switch in switches:
    do_a_switch(switch)

print interface_list

#bash command to get ip and mac addr on linux:
#echo -n `ip route get 8.8.8.8 | awk 'NR==1 {print $NF}'` ; echo -n " " ; ifconfig -a | awk '/^[a-z]/ { iface=$1; mac=$NF; next } /inet addr:/ { print iface, mac }' | grep eth0



