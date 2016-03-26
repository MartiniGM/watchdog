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

# switch list. add more switches here if you got 'em
switches = ["10.42.0.3","10.42.0.4","10.42.0.5","10.42.0.6","10.42.0.7",
            "10.42.0.8","10.42.0.9","10.42.0.10","10.42.0.11","10.42.0.12",
            "10.42.0.13", "10.42.0.14","10.42.0.17","10.42.0.20","10.42.0.21"]

device_type_item_id = 5
device_name_item_id = 0
mac_address_item_id = 0
hostname_item_id = 4
ip_address_item_id = 1

interface_list = []
device_name_list = []
pi_list = []
pi_output_list = []

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

############################################################
#subfinder_switch: gets every item which matches the item name
############################################################             
def subfinder_switch(mylist, pattern):
    matches = []
    try:
        #and then gets every item where the device type matches the pattern 
        for item in mylist:
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

        device_name_item_id = find_item(list_of_lists, "Device Name")
        mac_address_item_id = find_item(list_of_lists, "Mac Address")

        # makes a list of every mac address and device name for which both exist
        for item in list_of_lists:
            mac_address = item[mac_address_item_id].replace(':','').lower()
            device_name = item[device_name_item_id]
            if mac_address is not None and mac_address != "":
                if device_name is not None and device_name != "" and device_name.lower() != "default":
                    item2 = (mac_address, device_name)
                    device_name_list.append(item2)

        print "made a list from master doc"
        print device_name_list

        device_type_item_id = find_item(list_of_lists, "Device Type")
        hostname_item_id = find_item(list_of_lists, "Device Name")
        ip_address_item_id = find_item(list_of_lists, "IP ADDRESS")
        alias_item_id = find_item(list_of_lists, "Device Name")
        description_item_id = find_item(list_of_lists, "Description")
        # sorts by device type
        list_of_lists.sort(key=lambda x: x[5])
        # creates list of pis
        pi_list = subfinder(list_of_lists, "berry")
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
#            print ("compare %s to %s" % (item[0].lower(), c))
            if item[0].lower() == c:
#                print "matched!!!"
                matches.append(item[1])
        except Exception, e:
            print "oops %s" % e
    return matches

############################################################
#do_pis: runs do_a_host on each pi and adds them to both lists
############################################################ 
def do_pis(mylist):
    global device_name_list
    for item in mylist:
        returnval = do_a_host(item, "pi")
        if returnval == []:
            continue
        else:
            pi_output_list.append(returnval)
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
            
        command = "/Users/Guest/watchdog/tcp_watchdog_server/get_pi_macaddr.exp " + str(ip_address) + " | grep 'eth0' | grep -v 'echo'"
        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
        for row in output.split('\n'):
            listy = row.split()
            if listy[0] == "send:":
                print "send detected, continue"
                return []
            else:
                returnitem = (listy[2].replace(':', '').lower(), device_name)
                print "%s: %s %s" % (str(ip_address), returnitem[1], returnitem[0])
                return returnitem

    except subprocess.CalledProcessError, e:
        return []
    except Exception, e:
        print "error in do_linux %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        #otherwise return an error
        return []

############################################################
#print_switch: prints matches for this switch and returns them
############################################################ 
def print_switch(switch):
    entries = ["\t"]*49
    this_switch = subfinder_switch(interface_list, switch)
    for item in this_switch:
        interface = item[3]
        number = interface.rsplit('/', 1)[-1]
        stringy = item[1] + "\t"
        entries[int(number)-1] = stringy
        print "%s: %s at %s" % (switch, item[1], interface) 
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

        command = "/Users/Guest/watchdog/get-mac-addr.exp meow %s | grep ' 16 ' | grep Fa" % str(ip_address)
        print "command " + command
        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
        for row in output.split('\n'):
            print row
            listy = row.split()
            # necessary because sometimes the output contains junk before the "16"
            try:
                first_row = listy.index("16")
#                print "first row is %d" % first_row
            except:
                # skips junk rows that don't have "16"
                continue
            if (len(listy) >= first_row + 4):
                mac_addr = listy[first_row+1].replace('.', '').lower()
                print "searching for %s" % mac_addr
                matches = return_name(mac_addr)
                if matches == []:
#                    print "blank match"
                    continue
                else:
                    if len(matches) != 1:
                        if (matches[0] != matches[1]):
                            print "Error: multiple identical MAC addresses %s" % matches
                        else:
                            print "%s matched %s" % (mac_addr, matches)
                            match = matches[0]
                            inter = listy[first_row+3].replace("Fa", "FastEthernet")
                            this_interface = (ip_address, match, mac_addr, inter)
                            interface_list.append(this_interface)
                    else:
                        print "%s matched %s" % (mac_addr, matches)
                        match = matches[0]
                        inter = listy[first_row+3].replace("Fa", "FastEthernet")
                        this_interface = (ip_address, match, mac_addr, inter)
                        interface_list.append(this_interface)
            else:
                print "line too short? %d" % len(listy)
    except subprocess.CalledProcessError, e:
        print "%s: no response" % str(ip_address)
        return []
    except Exception, e:
        print "error in do_a_switch %s" % e
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
        # otherwise return an error
        return -1

########################################################################
# MAIN MAIN MAIN MAIN etc yeah I said it, it's MAIN
########################################################################    

# you can use --skip-pis to make the script skip the (time consuming)
# pi mac address query.
# if it skips the query it'll just get them as-is from the Master Doc
parser = argparse.ArgumentParser()
parser.add_argument('--skip-pis',
                        action='store_true',
                        help='skips over querying Pis, which is time-consuming and may not be necessary if there are no new Pis on the network...' )
args = parser.parse_args()

# open the sheet & create lists, one of Pis and one of all items
open_googlesheet()

if args.skip_pis:
    print "---------SKIPPING PI QUERY, WILL GET PIS FROM MASTER DOC"
else:
    #back up the old copy of the pi map so we can sanity check before pasting it
    try:
        shutil.copy ("pi_map.txt", "pi_map.old")
        if not (os.path.isfile ("pi_map.old")): print "error backing up old file"
    except Exception, e:
        print "error backing up old pi_map file: %s" % e

    try:
        # go through the Pi list, run the expect script for each to get mac addresses
        print "----------NOW QUERYING PIS (hit ctrl-C a lot if you need to cancel each pi):"
        do_pis(pi_list)
        pi_target = open("pi_map.txt", 'w')
        for pi in pi_output_list:
        # puts the ":" back in so we can cut-n-paste these into the master doc
            s = pi[0]
            macaddr = ':'.join(s[i:i+2] for i in range(0, len(s), 2))
            item = "%s %s\n" % (pi[1], macaddr)
            # and writes each item out to pi_map.txt
            pi_target.write(item)

    except Exception, e:
        print("Hit error in pis within main: %s" % e)
        for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))

    print "----------DONE QUERYING PIS. Current device list is:"
    print device_name_list
    
# back up the old copy of the switch map so we can sanity check before pasting it
try:
    shutil.copy ("switch_map.txt", "switch_map.old")
    if not (os.path.isfile ("switch_map.old")): print "error backing up old file"
except Exception, e:
    print "error backing up old switch_map file: %s" % e
            
    # go through the switch list, run the expect script for each to get mac addresses for connected devices
try:
    print "----------NOW QUERYING SWITCHES:"
    for switch in switches:
        returnval = do_a_switch(switch)
        if returnval == []:
            #retry, sometimes they don't call back
            do_a_switch(switch)
    
        # go through the switch list, run the expect script for each to get mac addresses for connected devices
    #print interface_list
    print ""
    print "---------DETECTED ITEMS:"

    target = open("switch_map.txt", 'w')

    for switch in switches:
        switch_map = print_switch(switch)
        # writes out each switch with tabs so you can cut-n-paste the whole
        # map into the Master Doc. 
        for item in switch_map:
            target.write(item)
        target.write("\n")
        # 10.42.0.3 has two switches, second one isn't in use. print an extra newline
        if switch == "10.42.0.3":
            target.write("\n")
    print ""
    print "***Done. Check pi_map.txt and switch_map.txt for formatted output"
    print ""
except Exception, e:
    print("Hit error in switches within main: %s" % e)
    for frame in traceback.extract_tb(sys.exc_info()[2]):
            fname,lineno,fn,text = frame
            print( "     in %s on line %d" % (fname, lineno))
