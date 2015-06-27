#!/usr/bin/python

import sqlite3 as lite
import sys

#("CREATE TABLE DEVICES(ID_NAME  TEXT PRIMARY KEY, LOCATION  TEXT, TIMESTAMP TEXT, UPTIME TEXT, UPTIME_SEC INT, STATUS TEXT, DEVICE_TYPE TEXT )

devices = (
    ('berry5/serial2pipe/arduino_pipe1', 'None', 'Jun 19, 2015 22:31:54', '2 days, 02:57:38', 183458, 'ERRDUINO_NOREPLY', 'arduino')
)

locations = (('berry5/serial2pipe/arduino_pipe2', 'arduino2'),
             ('berry5/serial2pipe/arduino_pipe1', 'arduino1'),
             ('berry5/serial2pipe/watchdog_pipe1', 'WD1'),
             ('berry5/serial2pipe/watchdog_pipe2', 'WD2'),
             ('192.168.1.187', 'loneduino1'),
             ('192.168.1.177', 'loneduino2'),
             ('192.168.1.67', 'berry5'))

types = (('berry5/serial2pipe/arduino_pipe2', 'piduino'),
             ('berry5/serial2pipe/arduino_pipe1', 'piduino'),
             ('berry5/serial2pipe/watchdog_pipe1', 'piduino'),
             ('berry5/serial2pipe/watchdog_pipe2', 'piduino'),
             ('192.168.1.187', 'loneduino'),
             ('192.168.1.177', 'loneduino'),
             ('192.168.1.67', 'pi'))

con = lite.connect('demosdb.db')

with con:
    
    cur = con.cursor()    
    
#    cur.execute("INSERT OR REPLACE INTO DEVICES VALUES(?, ?, ?, ?, ?, ?, ?)", devices)
    cur.executemany("INSERT OR REPLACE INTO LOCATIONS VALUES(?, ?)", locations)
    cur.executemany("UPDATE DEVICES SET DEVICE_TYPE=? WHERE ID_NAME=?", types)
