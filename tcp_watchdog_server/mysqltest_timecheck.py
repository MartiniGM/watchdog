import MySQLdb
import datetime
import time
two_timer = time.time()

try:
# Open database connection, create cursor
    db = MySQLdb.connect("localhost","testuser","test623","testdb" )
    cursor = db.cursor()
except Exception, e:
    print "Can't connect to testdb! %s" % e

#returns location/description string, given an id_name
def get_pis(pi_or_arduino):
    global cursor
    sql = """SELECT ID_NAME, TIMESTAMP, STATUS FROM %s""" % pi_or_arduino
    try:
        cursor.execute(sql)
        data = cursor.fetchall()
        for row in data:
            print "EEEEEEEE " + row[0] + " " + row[1] + " " + row[2]
        return data
    except Exception, e:
        print "SQL error! %s" % e
        return "" #blank location, will show as None in SQL

def parse_data(data):
    for row in data:
        print row[0] + " " + row[1] + " " + row[2]
        name = row[0]
        timestamp = row[1]
        status = row[2]
        if ("DISCON" not in status):
            print "didn't find discon, compare times"
            time_cur = datetime.datetime.now()
            print ("cur time " + datetime.datetime.now().strftime("%b %d, %\
Y %H:%M:%S"))
            time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%\
M:%S")
            total_seconds = ((time_cur-time_ts).seconds)
            print "total seconds between times: " + str(total_seconds)
            if (total_seconds > 120):
                    #more than 5 minutes
                print "More than 2 minutes for " + name
        else:
            print "found discon, skipping" + str(row)
                
while 1:
    if (time.time() - two_timer > 40):
        data = get_pis("PIS")
        parse_data(data)
        data2 = get_pis("ARDUINOS")
        parse_data(data2)

#        for row in data:
#            print row[0] + " " + row[1] + " " + row[2]
#            name = row[0]
#            timestamp = row[1]
#            status = row[2]
#            if ("DISCON" not in status):
#                print "didn't find discon, compare times"
#                time_cur = datetime.datetime.now()
#                print ("cur time " + datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
#                time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%M:%S")
#                total_seconds = ((time_cur-time_ts).seconds)
#                print "total seconds between times: " + str(total_seconds)
#                if (total_seconds > 120):
#                    #more than 5 minutes
#                    print "More than 2 minutes for " + name 
##            else:
#                print "found discon, skipping"
        two_timer = time.time()


