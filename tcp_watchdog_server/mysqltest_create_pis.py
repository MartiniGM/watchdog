#!/usr/bin/python

import MySQLdb

# Open database connection
db = MySQLdb.connect("localhost","testuser","test623","testdb" )

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Drop table if it already exists using execute() method. Uncomment to delete/recreate entire table.
#cursor.execute("DROP TABLE IF EXISTS ARDUINOS")

# Create table as below
sql = """CREATE TABLE PIS (
         ID_NAME  CHAR(50) NOT NULL,
         LOCATION  CHAR(50),
         TIMESTAMP  CHAR(100),
         STATUS CHAR(20) )"""

cursor.execute(sql)

#then set ID_NAME as primary so that the UPDATE statement works later
sql= """ALTER TABLE PIS ADD PRIMARY KEY(ID_NAME)"""
cursor.execute(sql)

# disconnect from server
db.close()