#!/usr/bin/python

import sqlite3 as lite
import sys

con = lite.connect('demosdb.db')

with con:
    
    cur = con.cursor()    
    
    #recreate devices table (main table with all info for each device)
    cur.execute("DROP TABLE IF EXISTS DEVICES")
    cur.execute("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT, LAST_RESET_TIMESTAMP TEXT, LAST_UPTIME_SEC INT, ZONE TEXT, SPACE TEXT, DEVICE_NAME TEXT, DESCRIPTION TEXT, SWITCH_INTERFACE TEXT, MAC_ADDRESS TEXT, BOOT_ORDER INT, SHUTDOWN_ORDER INT, CUSTOM_DELAY INT)")
    
    #recreate locations table (stores locations, maybe not used anymore)
    cur.execute("DROP TABLE IF EXISTS LOCATIONS")
    cur.execute("CREATE TABLE LOCATIONS (ID_NAME TEXT PRIMARY KEY, LOCATION TEXT)")
    #recreate system info table (percent OK, number of devices detected)
    cur.execute("DROP TABLE IF EXISTS SYSTEM_INFO")
    cur.execute("CREATE TABLE SYSTEM_INFO (ID_NAME TEXT PRIMARY KEY, NUM_DEVICES INT, NUM_OKAY_DEVICES INT, PERCENT_OKAY INT)")
    
    #recreate googlesheet backup table to store latest update from google drive
    #['IP ADDRESS', 'Mac Address', 'Hostname', 'Device Name', 'Device Type', 'Zone', 'Space', 'Location Details', 'Description', 'Flow Chart LInk', 'Order', 'Switch Interface']
    cur.execute("DROP TABLE IF EXISTS GOOGLESHEET_BACKUP")
    cur.execute("CREATE TABLE GOOGLESHEET_BACKUP (IP_ADDRESS TEXT PRIMARY KEY, MAC_ADDRESS TEXT, HOSTNAME TEXT, DEVICE_NAME TEXT, DEVICE_TYPE TEXT, ZONE TEXT, SPACE TEXT, LOCATION TEXT, DESCRIPTION TEXT, SWITCH_INTERFACE TEXT, BOOT_ORDER INT, SHUTDOWN_ORDER INT, CUSTOM_DELAY INT)")

