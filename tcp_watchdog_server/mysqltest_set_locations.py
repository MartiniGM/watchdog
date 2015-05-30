#!/usr/bin/python

import MySQLdb

# Open database connection, create cursor
db = MySQLdb.connect("localhost","testuser","test623","testdb" )
cursor = db.cursor()

#set up variables for testing
id_name = ["raspberrypi/serial2pipe/watchdog_pipe2", "raspberrypi/serial2pipe/watchdog_pipe1", "127.0.0.1", "192.168.1.67", "berry5/serial2pipe/watchdog_pipe2", "berry5/serial2pipe/watchdog_pipe1", "192.168.1.177"]
location = ["Dad\'s room Arduino #2", "Dad\'s room Arduino #1", "localhost", "berry5", "Pi 5 Arduino #1", "Pi 5 Arduino #2", "loneduino"]

i = 0
while i < len(id_name):
#insert & commit, updating if the ID_NAME already exists. otherwise rollback
    try:
        cursor.execute("""INSERT INTO LOCATIONS(ID_NAME, LOCATION)
             VALUES (%s, %s)  
             ON DUPLICATE KEY UPDATE
             LOCATION = VALUES(LOCATION) ;
      """, (id_name[i],location[i]))
        db.commit()
    except:
        db.rollback()
    i = i + 1
# disconnect from server
db.close()
