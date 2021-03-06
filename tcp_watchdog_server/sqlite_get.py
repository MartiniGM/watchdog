#!/usr/bin/python

import sqlite3 as lite
import sys


con = lite.connect('demosdb.db')

with con:    
    
    cur = con.cursor()    

#locations table
    
    cur.execute("SELECT * FROM LOCATIONS")

    rows = cur.fetchall()

    print "LOCATIONS:"
    for row in rows:
        print str(row[0]) + " " + str(row[1])

#googlesheet backup table
        
    cur.execute("SELECT * FROM GOOGLESHEET_BACKUP")

    rows = cur.fetchall()

    print "GOOGLESHEET_BACKUP:"
    for row in rows:
        print row

#main device table
        
    cur.execute("SELECT * FROM DEVICES")

    rows = cur.fetchall()

    print "DEVICES:"
    for row in rows:
#  cur.execute("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT, LAST_RESET_TIMESTAMP TEXT, LAST_UPTIME_SEC INT, MAX_ID_NAME TEXT, ZONE TEXT, SPACE TEXT, DEVICE_NAME TEXT, DESCRIPTION TEXT, SWITCH_INTERFACE TEXT, MAC_ADDRESS TEXT)")
#        print row
        print str(row[0]) + " " + str(row[5]) + ", TS: " + str(row[2]) + ", Uptime: " + str(row[3]) + " (" + str(row[4]) + " sec), last uptime: " + str(row[8]) + " last reset at: " + str(row[7]) + " type is " + str(row[6]) + " zone " + str(row[9]) + " space " + str(row[10]) + " device_name " + str(row[11]) + " description " + str(row[12]) + " switch " + str(row[13]) + " mac " + str(row[14])



