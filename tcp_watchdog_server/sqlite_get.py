#!/usr/bin/python

import sqlite3 as lite
import sys


con = lite.connect('demosdb.db')

with con:    
    
    cur = con.cursor()    

    cur.execute("SELECT * FROM LOCATIONS")

    rows = cur.fetchall()

    print "LOCATIONS:"
    for row in rows:
        print str(row[0]) + " " + str(row[1])

    cur.execute("SELECT * FROM DEVICES")

    rows = cur.fetchall()

    print "DEVICES:"
    for row in rows:
#    cur.execute("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, LAST_UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT, LAST_RESET_TIMESTAMP TEXT)")

        print str(row[0]) + " " + str(row[5]) + ", TS: " + str(row[2]) + ", Uptime: " + str(row[3]) + " (" + str(row[4]) + " sec), last uptime: " + str(row[8]) + " last reset at: " + str(row[7])



