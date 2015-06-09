#!/usr/bin/python

import MySQLdb

# Open database connection
db = MySQLdb.connect("localhost","demo-user","plaintext","demosdb" )

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Drop table if it already exists using execute() method. Uncomment to delete/recreate entire table.
#cursor.execute("DROP TABLE IF EXISTS LOCATIONS")

# Create table as below
sql = """CREATE TABLE LOCATIONS (
         ID_NAME  CHAR(50) NOT NULL,
         LOCATION  CHAR(50))"""

cursor.execute(sql)

#then set ID_NAME as primary so that the UPDATE statement works later
sql= """ALTER TABLE LOCATIONS ADD PRIMARY KEY(ID_NAME)"""
cursor.execute(sql)

# disconnect from server
db.close()
