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
#ur.execute("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT )

        print str(row[0]) + ": " + str(row[5]) + " at " + str(row[1]) + ", TS: " + str(row[2]) + ", Uptime: " + str(row[3]) + " " + str(row[4]) + " type: " + str(row[6])



