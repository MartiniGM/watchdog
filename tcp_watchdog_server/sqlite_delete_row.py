#!/usr/bin/python

import sqlite3 as lite
import sys
import time
import argparse

try:
    parser = argparse.ArgumentParser()
    parser.add_argument('--ip', 
                        type=str,
                        help='IP address to use (i.e. 10.42.16.166)' )
    args = parser.parse_args()
    if args.ip:
        remote_ip = args.ip

    con = lite.connect('demosdb.db')

    with con:
    
        cur = con.cursor()    
    
        #recreate devices table (main table with all info for each device)
        sql = "DELETE FROM DEVICES WHERE ID_NAME LIKE '%s'" % remote_ip
        cur.execute(sql)

except lite.Error, e:
    print(" SQL error! %s" % e)   

    
