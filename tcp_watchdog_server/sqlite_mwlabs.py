#!/usr/bin/python

import sqlite3 as lite
import sys

locations = (('192.168.1.30', 'berry1'),
             ('192.168.1.187', 'stalagmite'),
             ('192.168.1.154', 'unknown'),
             ('192.168.1.189', 'portals door 1'),
             ('berry1/./piezo_wd_pipe', 'piezo'),
             ('berry1/./laser_wd_pipe', 'laser'),
             ('berry1/./chest_wd_pipe', 'chest'))

types = (('berry1/./piezo_wd_pipe', 'piduino'),
         ('berry1/./laser_wd_pipe', 'piduino'),
         ('berry1/./chest_wd_pipe', 'piduino'),
         ('192.168.1.30', 'pi'),
         ('192.168.1.187', 'pi'),
         ('192.168.1.154', 'unknown'),
         ('192.168.1.189', 'pi'))

con = lite.connect('c:\\watchdog\\tcp_watchdog_server_sqlite\\demosdb.db')

with con:
    
    cur = con.cursor()    
    
    cur.executemany("INSERT OR REPLACE INTO LOCATIONS VALUES(?, ?)", locations)
    cur.executemany("UPDATE DEVICES SET DEVICE_TYPE=? WHERE ID_NAME=?", types)
