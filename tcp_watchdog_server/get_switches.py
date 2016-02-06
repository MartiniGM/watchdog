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
pi_list = []

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

def subfinder_switch(mylist, pattern):
    matches = []
    try:
        #and then gets every item where the device type matches the pattern 
        for item in mylist:
#            print "%s in %s?" % (pattern, item[item_id])
            if pattern in item[0]:
                matches.append(item)
        return matches
    except Exception, e:
        print "error in subfinder: %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return blank list
        return []
            
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

def do_pis(mylist):
    for item in mylist:
        returnval = do_a_host(item, "pi")
        if returnval == []:
            continue
        else:
            device_name_list.append(returnval)
        
############################################################
#do_a_linux: takes a list, creates one .cfg file for the teensy in the list
############################################################ 
def do_a_host(mylist, compare):
    import subprocess
    try:
        ip_address = mylist[ip_address_item_id]
        device_type = mylist[device_type_item_id]
        device_name = mylist[hostname_item_id]
        
        if compare not in device_type.lower():
            print "Error? Can't tell if this is a %s, skipping: %s" % (compare, str(mylist))
            return []

        if ip_address is None or ip_address == '':
            print "No 'IP ADDRESS' in the Master Doc for this device, skipping:" + str(mylist)
            return []

        if device_name is None or device_name == '':
            device_name = ip_address
            
            #do the thing
        command = "/Users/Guest/watchdog/tcp_watchdog_server/get_pi_macaddr.exp " + str(ip_address) + " | grep 'eth0' | grep -v 'echo'"
        print "command " + command
        output = subprocess.check_output(command, shell=True)
        for row in output.split('\n'):
            listy = row.split()
            if listy[0] == "send:":
                print "send detected, continue"
                return []
            else:
                returnitem = (listy[2].replace(':', '').lower(), device_name)
                print returnitem
                return returnitem
            
    except Exception, e:
        print "error in do_linux %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return an error
        return []

def print_switch(switch):
    entries = ["\t"]*49
    this_switch = subfinder_switch(interface_list, switch)
    if this_switch != []:
        print ""
        print str(this_switch)
    for item in this_switch:
        interface = item[3]
        number = interface.rsplit('/', 1)[-1]
        stringy = item[1] + "\t"
        entries[int(number)-1] = stringy
        print "%s: %s at %s / %d" % (switch, item[1], interface, int(number)) 
#    print "entries " + str(entries)
    return entries
    
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

try:
    do_pis(pi_list)
except Exception, e:
    print("Hit error in do_pis: %s" % e)

switches = ["10.42.0.3","10.42.0.4","10.42.0.5","10.42.0.6","10.42.0.7",
            "10.42.0.8","10.42.0.9","10.42.0.10","10.42.0.11","10.42.0.12",
            "10.42.0.13", "10.42.0.14"]
for switch in switches:
    do_a_switch(switch)

#format example:
#interface_list = [('10.42.0.3', 'RPi-A0104', 'b827eb64b950', 'FastEthernet1/0/14'), ('10.42.0.3', 'RPi-A0105', 'b827eb7a26b5', 'FastEthernet1/0/15'), ('10.42.0.4', 'RPi-C0303', 'b827eb9deb8e', 'FastEthernet1/0/1'), ('10.42.0.4', 'RPi-C0309', 'b827ebeb5cf4', 'FastEthernet1/0/16'), ('10.42.0.4', 'RPi-C0307', 'b827ebf08b55', 'FastEthernet1/0/3'), ('10.42.0.5', 'RPi-D0401', 'b827ebc7d4bf', 'FastEthernet1/0/1'), ('10.42.0.5', 'RPi-D0408', 'b827ebf997c3', 'FastEthernet1/0/8'), ('10.42.0.6', 'RPi-E0506', 'b827eb224704', 'FastEthernet1/0/8'), ('10.42.0.7', 'RPi-F0605', 'b827eb662331', 'FastEthernet1/0/5'), ('10.42.0.7', 'RPi-F0606', 'b827ebc398d0', 'FastEthernet1/0/6'), ('10.42.0.7', 'RPi-F0607', 'b827ebd106f5', 'FastEthernet1/0/7'), ('10.42.0.8', 'RPi-G0706', 'b827eb8e7f58', 'FastEthernet1/0/6'), ('10.42.0.8', 'RPi-G0702', 'b827ebb83f41', 'FastEthernet1/0/2'), ('10.42.0.8', 'RPi-G0701', 'b827ebc882d4', 'FastEthernet1/0/1'), ('10.42.0.8', 'RPi-G0707', 'b827ebe44d0e', 'FastEthernet1/0/7'), ('10.42.0.9', 'RPi-H0805', 'b827ebacd25f', 'FastEthernet1/0/5'), ('10.42.0.13', 'RPi-L1206', 'b827eb619357', 'FastEthernet1/0/4'), ('10.42.0.13', 'RPi-G0714', 'b827eb8b0ed3', 'FastEthernet1/0/32'), ('10.42.0.13', 'MS-L1202', 'd8cb8a38e8e2', 'FastEthernet1/0/16')]

print interface_list

target = open("switch_map.txt", 'w')

for switch in switches:
    switch_map = print_switch(switch)
    #writes out each switch with tabs so you can cut-n-paste the whole
    #map into the Master Doc. 
    for item in switch_map:
        target.write(item)
    target.write("\n")
    #10.42.0.3 has two switches, second one isn't in use. print an extra newline
    if switch == "10.42.0.3":
        target.write("\n")
