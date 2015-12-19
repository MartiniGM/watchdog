#!/usr/bin/python 
import socket
import sqlite3 as lite
import datetime
import time
import os
import re
import sys
import signal
import traceback
from natsort import natsorted
from collections import defaultdict
import argparse

# give a filename for the watchdog's SQLite database here, on Windows
WINDOWS_DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server\\demosdb.db'
#and for Linux & OSX, I just used the local directory (where this file is) 
LINUX_OSX_DB_FILENAME = '/Users/Aesir/Documents/Max 7/Library/velostat/velostat.db'

############################################################                
############################################################
# main()
############################################################
#########################slibr###################################

def getKey(item):
#    print "key is %d" % item[0]
    return item[0] # sorts on electrode

if __name__ == "__main__":

    id_name = "stalagmite"
    table_name = "stalagmite"
    row_name = "electrode"
    sql_query = ""
    
    if os.name == 'nt':
        file_name = (WINDOWS_DB_FILENAME)
    else:
        file_name = (LINUX_OSX_DB_FILENAME)  
    
    parser = argparse.ArgumentParser()
    parser.add_argument('--verbose', '-v',
                        action='store_true',
                        help='verbose flag' )
    parser.add_argument('--single', '-s',
                        action='store_true',
                        help='return only one value (given by --row)' )
    parser.add_argument('--multi', '-m',
                        action='store_true',
                        help='return muliple values (sorted by --row)' )
    parser.add_argument('--database', '-d',
                        type=str,
                        help='path to sqlite database (i.e. /path/to/velostat.db)' )
    parser.add_argument('--table', '-t',
                        type=str,
                        help='name of sqlite table (i.e. velostat)' )
    parser.add_argument('--row', '-r',
                        type=str,
                        help='name of primary row to be returned (-s) or sorted by (-m)' )
    parser.add_argument('--id_name', '-i',
                        type=str,
                        help='name of id to search for (i.e. squirell)' )
    parser.add_argument('--sql', '-q',
                        type=str,
                        help='custom SQL query to run' )
    
    args = parser.parse_args()
    
    if args.verbose:
        print("Verbose/Debug mode. DO NOT use from nagios!")

    if not (args.single or args.multi):
        parser.error('No action requested, add -s for one item or -m for multiple items')

    if args.database:
        file_name = args.database
    if args.table:
        table_name = args.table
    if args.row:
        row_name = args.row
    if args.id_name:
        id_name = args.id_name
    if args.sql:
        sql_query = args.sql

    if args.verbose:
        print "file " + file_name
        print "table " + table_name
        print "row " + row_name
        print "id " + id_name
        print "sql " + sql_query
        
    #########################
    # DATABASE SETUP (SQLITE)
    #########################

    if args.multi:    
        try:
            # Open database connection, create cursor
            if os.name == 'nt':
                con = lite.connect(file_name)
            else:
                con = lite.connect(file_name)     
        except Exception, e:
            print("Can't connect to database! %s" % e)

            #get all!
        try:
            # this gets the max number of items to read in the next step.
            # the row name should just be the number of items
            cur = con.cursor()
            query = "SELECT max(%s) as %s from %s;" % (row_name, row_name, table_name) 
            cur.execute(query)
            data = cur.fetchall()
            for row in data:
                num_electrodes = row[0]
#                print (num_electrodes)
            cur = con.cursor()
            query = "SELECT %s,value,time FROM %s ORDER BY (time) DESC limit %s;" % (row_name, table_name, num_electrodes) 
            cur.execute(query)
            data = cur.fetchall()
            electrodes = []
            for row in data:
                electrode = row[0]
                value = row[1]
                time = row[2]
                item = (electrode, value, time)
                electrodes.append(item)
            electrodes = natsorted(electrodes)
            #        print electrodes
            stringy = "Return OK at %s|" % item[2]
            for item in electrodes:
                stringy += "%s%s=%s " % (row_name, item[0], item[1])
            print stringy
        except Exception, e:
            print("database error! %s" % e)
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print( "     in %s on line %d" % (fname, lineno))
            
    if args.single:
        try:
            # Open database connection, create cursor
            if os.name == 'nt':
                con = lite.connect(file_name)
            else:
                con = lite.connect(file_name)     
        except Exception, e:
            print("Can't connect to database! %s" % e)

            #get all!
        try:
            cur = con.cursor()
            query = "SELECT %s,time FROM %s WHERE name LIKE ? ORDER BY (time) DESC LIMIT 1;" % (row_name, table_name) 
            cur.execute(query, ('%'+id_name+'%',))
            data = cur.fetchall()
            for row in data:
                value = row[0]
                last_time = row[1]
            print "Return OK at %s|%s=%s;" % (last_time, row_name, value)
        except Exception, e:
            print("database error! %s" % e)
