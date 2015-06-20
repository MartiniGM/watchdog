#!/usr/bin/python 
import socket, select
import MySQLdb
import sqlite3 as lite
import datetime
import time
import os
connected = 1;
periodic_timer = time.time()
periodic_period = 240 #check for NOREPLY every 4 minutes

#reports disconnect, prepares for reconnect 
def disconnect():
    global connected
    if (connected == 1):
#        print "Disconnect detected!"
        connected = 0;

#returns data from arduinos and pis
def get_pis_sqlite(pi_or_arduino):
    global con
    with con:
        cur = con.cursor()
        sql = """SELECT ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME FROM %s""" % pi_or_arduino
        cur.execute(sql)
        data = cur.fetchall()
        return data

#returns location/description string, given an id_name
def get_location_sqlite(id_name):
    global con
    try:
        cur = con.cursor()
        cur.execute("SELECT ID_NAME, LOCATION FROM LOCATIONS WHERE ID_NAME LIKE\
 ?", ('%'+id_name+'%',))
        data = cur.fetchall()
        for row in data:
            return row[1]
    except lite.Error, e:
        if con:
            con.rollback()
        print "SQL error! %s" % e
        return "" #blank location, will show as None in SQL

#creates a Pi status update with current timestamp, sends it to sql_data_sqlite
def pi_status_update_sqlite(addr, status):
    id_name = addr

#    print "id_name " + id_name
#    print "status " + status
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
#    print "timestamp " + timestamp
    data = [(id_name, timestamp, status, 0, "unknown")]
    sql_data_sqlite(data, "DEVICES")
 
#splits string input into a list and passes it on 
def listify_data(data):
    if len(data) == 0:
        return
#    print "got data sql_data: " + data
    data_list = data.split();
    status = data_list[0]
    id_name = data_list[1]
    uptime_sec = data_list[2]
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    strr = " "
    uptime = strr.join(data_list[3:])
    return [(id_name, timestamp, status, uptime_sec, uptime)]

def sql_data_sqlite(data, pi_or_arduino):
    global con
    if len(data) == 0:
        return
#[(u'berry5/serial2pipe/arduino_pipe1', u'Jun 19, 2015 23:28:02', u'ERRDUINO_BROKENPIPE', 0, u'unknown')]
    print data
    datalist = data[0]
#    print "got data sql_data: " + str(data)
    id_name = datalist[0]
    timestamp = datalist[1]
    status = datalist[2]
    uptime_sec = datalist[3]
    uptime = datalist[4]
    if (len(uptime) == 0):
#for now only loneduinos fail to send time
        sec = int(uptime_sec)
        mins = sec/60
        hours = mins/60
        days = hours / 24

        sec=sec-(mins*60) #subtract the coverted seconds to minutes 
        mins=mins-(hours*60) #subtract the coverted minutes to hours 
        hours=hours-(days*24) #subtract the coverted hours to days 
        if (days == 0):
            uptime = "%02d:%02d:%02d" % (hours, mins, sec)
        else:
            if (days == 1):
                uptime = "%d day, %02d:%02d:%02d" % (days, hours, mins, sec)
            else:
                uptime = "%d days, %02d:%02d:%02d" % (days, hours, mins, sec)

        pi_or_arduino = "DEVICES"

    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    location = get_location_sqlite(id_name)

    print "got data: " + status + " " + id_name + " " + timestamp + " Uptime: " + str(uptime_sec) + ", " + uptime

#insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, LOCATION, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME) values (?, ?, ?, ?, ?, ?)",  (id_name,location,timestamp,status, uptime_sec,uptime))
        con.commit()
    except lite.Error, e:
        print "mysql error: %s" % e
        con.rollback()
    else:
        print "db_update okay!"

#parses data
def parse_data_sqlite(data):
    for row in data:
        print row[0] + " " + row[1] + " " + row[2] + " " + str(row[3]) + " " + row[4]
        id_name = row[0]
        timestamp = row[1]
        status = row[2]
        location = get_location_sqlite(id_name)
        uptime_sec = row[3]
        uptime = row[4]
        if ("DISCON" not in status):
 #           print "didn't find discon, compare times"
            time_cur = datetime.datetime.now()
            print ("cur time " + datetime.datetime.now().strftime("%b %d, %\
Y %H:%M:%S"))
            time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%\
M:%S")
            total_seconds = ((time_cur-time_ts).seconds)
            print "total seconds between times: " + str(total_seconds)
            total_seconds = 400
            if (total_seconds > periodic_period):
                    #more than X minutes
                print "More than %d minutes for %s" % (periodic_period / 60, id_name)
                timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))

                status = "ERRDUINO_NOREPLY"
                table = "DEVICES"
                try:
                    cur = con.cursor()
                    cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, LOCATION, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME) values (?, ?, ?, ?, ?, ?)",  (id_name,location,timestamp,status, uptime_sec,uptime))
                    con.commit()
                except lite.Error, e:
                    print "mysql error: %s" % e
                    con.rollback()
                else:
                    print "db_update okay!"
        else:
            print "DISCON found, skipping" + str(row)

if __name__ == "__main__":
      
    CONNECTION_LIST = []    # list of socket clients
    RECV_BUFFER = 4096 # Advisable to keep it as an exponent of 2
    PORT = 6666

    try:
# Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect('c:\\watchdog\\tcp_watchdog_server_sqlite\\demosdb.db')
        else:
            con = lite.connect('demosdb.db')     
#        db = MySQLdb.connect("localhost","demo-user","plaintext","demosdb" )
#        cursor = db.cursor()
    except Exception, e:
        print "Can't connect to demosdb! %s" % e
 
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.settimeout(5.0) 
 
    # check and turn on TCP keepalive -- this ensures that we'll get 
    # disconnect errors from clients that go away
    x = server_socket.getsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE)
    if (x == 0):
        x = server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
        #60 secs to 1st timeout, 4 retries @ 15 secs per = 2 mins til timeout

        # overrides value (in seconds) shown by sysctl net.ipv4.tcp_keepalive_time. Only works on linux, not on windows

        if (os.name == 'linux'):
            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPIDLE, 60)
            # overrides value shown by sysctl net.ipv4.tcp_keepalive_probes
            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPCNT, 4)
            # overrides value shown by sysctl net.ipv4.tcp_keepalive_intvl
            server_socket.setsockopt(socket.SOL_TCP, socket.TCP_KEEPINTVL, 15)
    
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(("0.0.0.0", PORT))
    server_socket.listen(10)
 
    # Add server socket to the list of readable connections
    CONNECTION_LIST.append(server_socket)
 
    print "Watchdog server started on port " + str(PORT)
 
    while 1:
        #new stuff for periodic data check
        if (time.time() - periodic_timer > periodic_period):
            data = get_pis_sqlite("DEVICES")
            parse_data_sqlite(data)
            periodic_timer = time.time()

        # Get the list of sockets which are ready to be read through select
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[])

        for sock in read_sockets:
             
            if sock == server_socket:
                # Handle the case in which there is a new connection received through server_socket
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                print "-----Client (%s, %s) connected" % addr
                addr_str = str(addr[0])
                #took this out now that pis & arduinos send their own OK msgs
                #pi_status_update(addr_str, "ERRPI_ACKCLEAR")
                
            else:
                # Data recieved, process it
                try:
                    #In Windows, sometimes when a TCP program closes abruptly,
                    # a "Connection reset by peer" exception will be thrown
                    data = sock.recv(RECV_BUFFER)
                    if not sock:
                        print "No socket, popping an error"
                        disconnect()
                        #pi_status_update(addr_str, "ERRPI_DISCON")
                    else:
                        if data == '':
                            print "-----Client (%s, %s) is offline" % addr
                            print "-----due to client disconnected / closed."
                            sock.close()
                            disconnect()
                            addr_str = str(addr[0])
                         #   pi_status_update(addr_str, "ERRPI_DISCON")
                            CONNECTION_LIST.remove(sock)
                        else:
                        # at this point we got data, so log it
                            data2 = listify_data(data)
                            sql_data_sqlite(data2, "ARDUINOS")
                            connected = 1;

                # client disconnected, so remove it from the socket list
                except socket.timeout:
                    print "socket timeout!"
                    continue
                except Exception, e:
                    print "-----Client (%s, %s) is offline" % addr
                    print "-----due to %s" % e
                    sock.close()
                    disconnect()
                    addr_str = str(addr[0])
                    CONNECTION_LIST.remove(sock)
                    continue

# disconnect from mysql server
    con.close()
 #   db.close()         
    server_socket.close()
