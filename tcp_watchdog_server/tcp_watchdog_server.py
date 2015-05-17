#!/usr/bin/python 
import socket, select
import MySQLdb
import datetime

connected = 1;

#reports disconnect, prepares for reconnect 
def disconnect():
    global connected
    if (connected == 1):
        print "Disconnect detected!"
        connected = 0;

#returns location/description string, given an id_name
def get_location(id_name):
    sql = """SELECT ID_NAME, LOCATION FROM LOCATIONS WHERE ID_NAME LIKE %s
""" 
    try:
        cursor.execute(sql, (('%' + id_name + '%',)))
        data = cursor.fetchall()
        for row in data:
            return row[1]
    except Exception, e:
        print "SQL error! %s" % e
        return "" #blank location, will show as None in SQL

#creates a Pi status update with current timestamp, sends it to mysql_data
def pi_status_update(addr, status):
    id_name = addr
#    print "id_name " + id_name
#    print "status " + status
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
#    print "timestamp " + timestamp
    data = status + " " + id_name + " " + timestamp
    mysql_data(data, "PIS")
    
#writes Pi & Arduino status updates out to mysql
def mysql_data(data, pi_or_arduino):
    if len(data) == 0:
        return

    print "got data: " + data
    data_list = data.split();
    print data_list
    status = data_list[0]
    id_name = data_list[1]
    strr = " "
    timestamp = strr.join(data_list[2:])
    if (len(timestamp) == 0):
        timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
        pi_or_arduino = "ARDUINOS" #for now only loneduinos fail to send time
    location = get_location(id_name)
#insert & commit, otherwise rollback
    try:
        query = """INSERT INTO %s(ID_NAME, LOCATION, TIMESTAMP, STATUS)  
             VALUES (%%s, %%s, %%s, %%s)                                           
             ON DUPLICATE KEY UPDATE                                           
             TIMESTAMP = VALUES(TIMESTAMP),
             LOCATION = VALUES(LOCATION),
             STATUS = VALUES(STATUS) ;                                         
      """ % (pi_or_arduino)
        cursor.execute(query, (id_name,location,timestamp,status))
        db.commit()
    except Exception, e:
        print "mysql error: %s" % e
        db.rollback()
    else:
        print "db_update okay!"

if __name__ == "__main__":
      
    CONNECTION_LIST = []    # list of socket clients
    RECV_BUFFER = 4096 # Advisable to keep it as an exponent of 2
    PORT = 6666

    try:
# Open database connection, create cursor
        db = MySQLdb.connect("localhost","testuser","test623","testdb" )
        cursor = db.cursor()
    except Exception, e:
        print "Can't connect to testdb! %s" % e
 
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.settimeout(5.0) 
 
    # check and turn on TCP keepalive -- this ensures that we'll get 
    # disconnect errors from clients that go away
    x = server_socket.getsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE)
    if (x == 0):
        x = server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
        #60 secs to 1st timeout, 4 retries @ 15 secs per = 2 mins til timeout

        # overrides value (in seconds) shown by sysctl net.ipv4.tcp_keepalive_time
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
        # Get the list of sockets which are ready to be read through select
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[])

        for sock in read_sockets:
             
            if sock == server_socket:
                # Handle the case in which there is a new connection recieved through server_socket
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                print "Client (%s, %s) connected" % addr
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
                        pi_status_update(addr_str, "ERRPI_DISCON")
                    else:
                        if data == '':
                            print "Client (%s, %s) is offline" % addr
                            print "due to client disconnected / watchdog closed."
                            sock.close()
                            disconnect()
                            addr_str = str(addr[0])
                            pi_status_update(addr_str, "ERRPI_DISCON")
                            CONNECTION_LIST.remove(sock)
                        else:
                        # at this point we got data, so log it
                            mysql_data(data, "ARDUINOS")
                            connected = 1;

                # client disconnected, so remove it from the socket list
                except socket.timeout:
                    print "socket timeout!"
                    continue
                except Exception, e:
                    print "Client (%s, %s) is offline" % addr
                    print "due to %s" % e
                    sock.close()
                    disconnect()
                    addr_str = str(addr[0])
                    pi_status_update(addr_str, "ERRPI_DISCON")
                    CONNECTION_LIST.remove(sock)
                    continue

# disconnect from mysql server
    db.close()         
    server_socket.close()
