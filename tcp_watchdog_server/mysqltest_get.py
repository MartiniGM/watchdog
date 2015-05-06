#!/usr/bin/python

import MySQLdb

# Open database connection
db = MySQLdb.connect("localhost","testuser","test623","testdb" )

# prepare a cursor object using cursor() method
cursor = db.cursor()

#dumps entire table for testing
sql = """SELECT ID_NAME, LOCATION, TIMESTAMP, STATUS FROM ARDUINOS
      """
try:
    cursor.execute(sql)
    data = cursor.fetchall()
    for row in data:
        print row[0], row[1], row[2], row[3]
except Exception, e:
    print "Error! %s" % e

# disconnect from server
db.close()
