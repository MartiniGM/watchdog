#!/usr/bin/python 
import socket, select
import MySQLdb
#from Tkinter import * 

connected = 1;
 
def disconnect():
    global connected
    if (connected == 1):
        print "Disconnect detected!"
        connected = 0;

def mysql_data(data, pi_or_arduino):
    print "got data: " + data
    data_list = data.split();
    status = data_list[0]
                        #print "err " + status
    id_name = data_list[1]
                        #print "id " + id_name
    strr = " "
    timestamp = strr.join(data_list[2:])
                        #print "time " + timestamp
    location = "Dad\'s room"
                        #insert & commit, otherwise rollback
    try:
        query = """INSERT INTO %s(ID_NAME, LOCATION, TIMESTAMP, STATUS)  
             VALUES (%%s, %%s, %%s, %%s)                                           
             ON DUPLICATE KEY UPDATE                                           
             TIMESTAMP = VALUES(TIMESTAMP),                                    
             STATUS = VALUES(STATUS) ;                                         
      """ % (pi_or_arduino)
#        print query
        cursor.execute(query, (id_name,location,timestamp,status))
        db.commit()
    except Exception, e:
        print "mysql error: %s" % e
        db.rollback()
    else:
        print "db_update okay!"
        sock.send('OK ... ' + data)
        

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
    # this has no effect, why ?
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(("0.0.0.0", PORT))
    server_socket.listen(10)
 
    # Add server socket to the list of readable connections
    CONNECTION_LIST.append(server_socket)
 
    print "Chat server started on port " + str(PORT)
 
    while 1:
        # Get the list sockets which are ready to be read through select
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[])

        for sock in read_sockets:
             
            #New connection
            if sock == server_socket:
                # Handle the case in which there is a new connection recieved through server_socket
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                print "Client (%s, %s) connected" % addr
                 
            #Some incoming message from a client
            else:
                # Data recieved from client, process it
                try:
                    #In Windows, sometimes when a TCP program closes abruptly,
                    # a "Connection reset by peer" exception will be thrown
                    data = sock.recv(RECV_BUFFER)
                    # echo back the client message
                    if not sock:
                        print "No socket, popping an error"
                        disconnect()
                    else:
                   #     print "got data: " + data
                   #     data_list = data.split();
                   #     status = data_list[0]
                   #     id_name = data_list[1]
                   #     strr = " "
                   #     timestamp = strr.join(data_list[2:])
                   #     location = "Dad\'s room"
                        #insert & commit, otherwise rollback
                   #     try:
                   #         cursor.execute("""INSERT INTO ARDUINOS(ID_NAME, LOCATION, TIMESTAMP, STATUS)
           #  VALUES (%s, %s, %s, %s)  
           #  ON DUPLICATE KEY UPDATE
           #  TIMESTAMP = VALUES(TIMESTAMP),
           #  STATUS = VALUES(STATUS) ;
     # """, (id_name,location,timestamp,status))
      #                      db.commit()
       #                 except Exception, e:
        #                    print "mysql error: %s" % e
         #                   db.rollback()
          #              else:
           #                 print "db_update okay!"
            #            sock.send('OK ... ' + data)
                        mysql_data(data, "ARDUINOS")
                        connected = 1;

                # client disconnected, so remove from socket list
                except Exception, e:
                    print "Client (%s, %s) is offline" % addr
                    print "due to %s" % e
                    sock.close()
                    disconnect()
                    CONNECTION_LIST.remove(sock)
                    continue

# disconnect from mysql server
    db.close()         
    server_socket.close()
