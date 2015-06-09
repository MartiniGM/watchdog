#!/usr/bin/python

import MySQLdb

# Open database connection, create cursor
db = MySQLdb.connect("localhost","testuser","test623","testdb" )
cursor = db.cursor()

#set up variables for testing
id_name = "192.168.1.107"
location = "Dad\'s room"
timestamp = "3/04/2015 06:06:60"
status = "ERRDUINO_ACKCLEAR"

#insert & commit, updating if the ID_NAME already exists. otherwise rollback
try:
    cursor.execute("""INSERT INTO PIS(ID_NAME, LOCATION, TIMESTAMP, STATUS)
             VALUES (%s, %s, %s, %s)  
             ON DUPLICATE KEY UPDATE
             TIMESTAMP = VALUES(TIMESTAMP),
             STATUS = VALUES(STATUS) ;
      """, (id_name,location,timestamp,status))
    db.commit()
except:
    db.rollback()

# disconnect from server
db.close()
