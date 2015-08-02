#!/usr/bin/python 
import socket, select
import sqlite3 as lite
import datetime
import time
import os
import re
#connected = 1;
periodic_timer = time.time() 
periodic_period = 120 #check for NOREPLY every X seconds

############################################################
#disconnect()
############################################################
# reports disconnect, prepares for reconnect. does nothing anymore so removed 
#def disconnect():
#    global connected
#    if (connected == 1):
#        connected = 0;

############################################################
# get_pis_sqlite()
############################################################        
# returns data from arduinos and pis (as a list of tuples)
def get_pis_sqlite(pi_or_arduino):
    global con
    with con:
        cur = con.cursor()
        sql = """SELECT ID_NAME, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME FROM %s""" % pi_or_arduino
        cur.execute(sql)
        data = cur.fetchall()
        return data
    
############################################################
# get_location_sqlite()
############################################################        
# returns location/description string, given an id_name
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

############################################################
# pi_status_update_sqlite()
############################################################        
# creates a Pi status update with current timestamp (as list of tuples), sends it to sql_data_sqlite
def pi_status_update_sqlite(addr, status):
    id_name = addr

#    print "id_name " + id_name
#    print "status " + status
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
#    print "timestamp " + timestamp
    data = [(id_name, timestamp, status, 0, "unknown")]
    sql_data_sqlite(data, "DEVICES")

############################################################
# listify_data()
############################################################            
# splits string input into a formatted list of tuples and returns it.
# this is intended to match the way SQLite returns values, so we can use the
# same functions to parse both.
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

############################################################
# sql_data_sqlite()
############################################################        
# parses data (as a list of tuples, either from SQLite or listify_data) and updates SQLite
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
        # for now only loneduinos fail to send uptime as a string.
        # if so, create a string from the number of seconds rec'd
        sec = int(uptime_sec)
        mins = sec/60
        hours = mins/60
        days = hours / 24

        sec=sec-(mins*60) #subtract the coverted seconds to minutes 
        mins=mins-(hours*60) #subtract the coverted minutes to hours 
        hours=hours-(days*24) #subtract the coverted hours to days 
#        if (days == 0):
#            uptime = "%02d:%02d:%02d" % (hours, mins, sec)
#        else:
#            if (days == 1):
#                uptime = "%d day, %02d:%02d:%02d" % (days, hours, mins, sec)
#            else:
        uptime = "%d days, %02d:%02d:%02d" % (days, hours, mins, sec)

#        pi_or_arduino = "DEVICES"

    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    location = get_location_sqlite(id_name)

    print "got data: " + status + " " + id_name + " " + timestamp + " Uptime: " + str(uptime_sec) + ", " + uptime

    # insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, LOCATION, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME) values (?, ?, ?, ?, ?, ?)",  (id_name,location,timestamp,status, uptime_sec,uptime))
        con.commit()
    except lite.Error, e:
        print "mysql error: %s" % e
        con.rollback()
    else:
        print "db_update okay!"

############################################################
# parse_data_sqlite()
############################################################        
#parses & checks for periodic disconnects; if found, inserts NOREPLY into SQLite
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
            if (total_seconds > periodic_period):
            # more than X seconds since last message. update this entry with NOREPLY
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

############################################################
# main()
############################################################        
# checks for TCP connections, recvs and parses data if present

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
    except Exception, e:
        print "Can't connect to demosdb! %s" % e
 
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.settimeout(5.0) 
 
    # check and turn on TCP keepalive -- this ensures that we'll get 
    # disconnect errors from clients that go away
    x = server_socket.getsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE)
    if (x == 0):
        x = server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)

        # overrides value (in seconds) for the TCP keepalives. Only works on linux, not on windows
        # 60 secs to 1st timeout, 4 retries @ 15 secs per = 2 mins til timeout
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
        # periodic data check. Checks SQLite every X seconds for lack of replies
        if (time.time() - periodic_timer > periodic_period):
            data = get_pis_sqlite("DEVICES")
            parse_data_sqlite(data)
            periodic_timer = time.time()

        # Get the list of sockets which are ready to be read through select
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[])

        for sock in read_sockets:
             
            if sock == server_socket:
                # Handle a new connection
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                print "-----Client (%s, %s) connected" % addr
                addr_str = str(addr[0])
                
            else:
                # Data recieved, process it
                try:
                    data = sock.recv(RECV_BUFFER)
                    if not sock:
                        print "No socket, popping an error"
#                        disconnect()
                        #pi_status_update(addr_str, "ERRPI_DISCON")
                    else:
                        # If nothing's rec'd from recv, this indicates the client has closed the connection
                        if data == '':
                            print "-----Client (%s, %s) is offline" % addr
                            print "-----due to client disconnected / closed."
                            sock.close()
#                            disconnect()
#                            addr_str = str(addr[0])
                         #   pi_status_update(addr_str, "ERRPI_DISCON")
                            CONNECTION_LIST.remove(sock)
                        else:                            
                        # at this point we got data, so log it
                            if data.count("ERRPI") + data.count("ERRDUINO") > 1:
                                # we may get more than one message at a time
                                # due to the way TCP works. If so, split 'em.
                                datas = re.split('(ERR)', data)
                                for data in datas:
                                    if data != "" and data != "ERR":
                                        data2 = "ERR"+data
                                        print "line is " + data2
                                        data3 = listify_data(data2)
                                        sql_data_sqlite(data3, "ARDUINOS")
#                                        connected = 1;
                            # otherwise, just log one message
                            else:        
                                data2 = listify_data(data)
                                sql_data_sqlite(data2, "ARDUINOS")
#                                connected = 1;

                # just ignore socket timeouts, as they do not break the conn
                except socket.timeout:
                    print "socket timeout!"
                    continue
                # other exceptions cause the client to be removed from the list
                except Exception, e:
                    print "-----Client (%s, %s) is offline" % addr
                    print "-----due to %s" % e
                    sock.close()
#                    disconnect()
                    addr_str = str(addr[0])
                    CONNECTION_LIST.remove(sock)
                    continue

# upon exit, disconnect from mysql server and close sockets
    con.close()
    server_socket.close()
