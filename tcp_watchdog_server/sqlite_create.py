#!/usr/bin/python

import sqlite3 as lite
import sys

con = lite.connect('demosdb.db')

with con:
    
    cur = con.cursor()    
    
    cur.execute("DROP TABLE IF EXISTS DEVICES")
    cur.execute("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, LAST_UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT, LAST_RESET_TIMESTAMP TEXT)")
    cur.execute("DROP TABLE IF EXISTS LOCATIONS")
    cur.execute("CREATE TABLE LOCATIONS (ID_NAME TEXT PRIMARY KEY, LOCATION TEXT)")



