#!/usr/bin/python 
import socket, select
import sqlite3 as lite
import datetime
import time
import os
import re
import logging
import logging.handlers
import sys
import signal
import traceback

####################
# GLOBALS & SETTINGS
####################                

# give a time (in seconds) for the periodic data check here
# every N seconds the watchdog will compare timestamps for all entries in the 
# database to the current time, and set NONRESPONSIVE if each hasn't replied
# within this time period.
periodic_period = 120 #seconds 
periodic_timer = time.time() #initialize timer

# give a filename for the watchdog's SQLite database here
DB_FILENAME = 'c:\\watchdog\\tcp_watchdog_server_sqlite\\demosdb.db'

PORT = 6666 # port number to watch
NUM_QUEUED_CONNECTIONS = 10 # number of backlogged connections
SOCKET_TIMEOUT = 5.0 # timeout in seconds

# give a filename for the watchdog's log file here
LOG_FILENAME = 'tcp_watchdog_server.out'
# give the size for each rolling log segment, in bytes
LOG_SIZE = 2000000 #2 MB, in bytes
# give the number of rolling log segments to record before the log rolls over
LOG_NUM_BACKUPS = 5 # five .out files before they roll over

####################
# EXIT HANDLER
####################                

# upon exit, log exit msg, disconnect from mysql server and close sockets
def exit_func():
    logger.warning ("     Watchdog server STOPPED on port " + str(PORT))
    con.close()
    server_socket.close()
    sys.exit(0)
    
# exits the program cleanly, logging exit time
def signal_handler(signal, frame):
    print ""
    exit_func()

signal.signal(signal.SIGINT, signal_handler)

####################
# FUNCTIONS
####################                

############################################################
#return_status()
############################################################
# returns new human-friendly status strings, given internal codes

def return_status(stat):
    if ('CLEAR' in stat):
        return "OKAY"
    else:
        if ('DISCON' in stat):
            return "DISCONNECT"
        else:
            if ('PIPE' in stat):
                return "BROKEN_PIDUINO_LINK"
            else:
                if ('NOREPLY' in stat):
                    return "NONRESPONSIVE"
                else:
                    # if not recognized, return status as-is
                    return stat
    
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
        logger.error(" SQL error! %s" % e)
        return "" #blank location, will show as None in SQL

############################################################
# pi_status_update_sqlite()
############################################################        
# creates a Pi status update with current timestamp (as list of tuples)
# and sends it to sql_data_sqlite

def pi_status_update_sqlite(addr, status):
    id_name = addr
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
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
    data_list = data.split();
    status = data_list[0]
    new_status = return_status(status)
    id_name = data_list[1]
    uptime_sec = data_list[2]
    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    strr = " "
    uptime = strr.join(data_list[3:])
    return [(id_name, timestamp, new_status, uptime_sec, uptime)]

############################################################
# sql_data_sqlite()
############################################################        
# parses data (as a list of tuples, either from SQLite or listify_data) a
# and updates SQLite

def sql_data_sqlite(data, pi_or_arduino):
    global con
    if len(data) == 0:
        return
    logger.debug(data)
    datalist = data[0]
    id_name = datalist[0]
    timestamp = datalist[1]
    status = datalist[2]
    new_status = return_status(status)
    uptime_sec = datalist[3]
    uptime = datalist[4]
    if (len(uptime) == 0):
        # for now only loneduinos fail to send uptime as a string.
        # if so, create a string from the number of seconds rec'd
        sec = int(uptime_sec)
        mins = sec/60
        hours = mins/60
        days = hours / 24

        sec=sec-(mins*60)     # subtract the coverted seconds to minutes 
        mins=mins-(hours*60)  # subtract the coverted minutes to hours 
        hours=hours-(days*24) # subtract the coverted hours to days 
        uptime = "%d days, %02d:%02d:%02d" % (days, hours, mins, sec)

    timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
    location = get_location_sqlite(id_name)

    logger.info(id_name + " reports " + new_status + " with uptime " + uptime)

    # insert & commit, otherwise rollback
    try:
        cur = con.cursor()
        cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, LOCATION, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME) values (?, ?, ?, ?, ?, ?)",  (id_name,location,timestamp,new_status, uptime_sec,uptime))
        con.commit()
    except lite.Error, e:
        logger.error(" mysql error: %s" % e)
        con.rollback()

############################################################
# parse_data_sqlite()
############################################################        
# parses/checks for periodic disconnects; if found, inserts NOREPLY into SQLite

def parse_data_sqlite(data):
    for row in data:
        id_name = row[0]
        timestamp = row[1]
        status = row[2]
        new_status = return_status(status)
        location = get_location_sqlite(id_name)
        uptime_sec = row[3]
        uptime = row[4]
        time_cur = datetime.datetime.now()
        time_ts = datetime.datetime.strptime(timestamp, "%b %d, %Y %H:%M:%S")
        total_seconds = ((time_cur-time_ts).seconds)
#        logger.debug("total seconds between times: " + str(total_seconds))
        if (total_seconds > periodic_period):
            # more than X seconds since last message. update this entry with NOREPLY
#            logger.debug("More than %d minutes for %s" % (periodic_period / 60, id_name))
            timestamp = str(datetime.datetime.now().strftime("%b %d, %Y %H:%M:%S"))
            status = "NONRESPONSIVE"
            table = "DEVICES"
            logger.info(id_name + " silent for " + str(total_seconds) + " seconds, setting " + status + " with uptime " + uptime)
            try:
                cur = con.cursor()
                cur.execute("INSERT OR REPLACE INTO DEVICES(ID_NAME, LOCATION, TIMESTAMP, STATUS, UPTIME_SEC, UPTIME) values (?, ?, ?, ?, ?, ?)",  (id_name,location,timestamp,status, uptime_sec,uptime))
                con.commit()
            except lite.Error, e:
                logger.error("mysql error: %s" % e)
                con.rollback()

############################################################                
############################################################
# main()
############################################################
############################################################

if __name__ == "__main__":
      
    CONNECTION_LIST = []    # list of socket clients
    RECV_BUFFER = 4096      # Advisable to keep it as an exponent of 2

    ##################
    # LOGGING SETUP
    ##################
    
    # defines log levels for the log file. Default is 'info' and above.
    # Run program with "debug" on the command line for extra debugging output
    LEVELS = { 'debug':logging.DEBUG,
            'info':logging.INFO,
            'warning':logging.WARNING,
            'error':logging.ERROR,
            'critical':logging.CRITICAL,
            }
    
    # default log level is info (prints info, warning, error, etc).
    # run with "tcp_watchdog_sqlite.py debug" to print/log debug messages
    if len(sys.argv) > 1:
        level_name = sys.argv[1]
        level = LEVELS.get(level_name, logging.NOTSET)
        logging.basicConfig(level=level)
    else:
        level = LEVELS.get('info', logging.NOTSET)
        logging.basicConfig(level=level)

    # creates our logger with the settings above/below
    logger = logging.getLogger('WDLog')

    # Add the log message handler to the logger. Creates a rolling/circular log
    # with LOG_NUM_BACKUPS backups, each of size LOG_SIZE bytes
    handler = logging.handlers.RotatingFileHandler(LOG_FILENAME,
                                                   maxBytes=LOG_SIZE,
                                                   backupCount=LOG_NUM_BACKUPS)
    
    # sets the message & timestamp format for the log
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
    handler.setFormatter(frmt)
    logger.addHandler(handler)

    #########################
    # DATABASE SETUP (SQLITE)
    #########################
    
    try:
        # Open database connection, create cursor
        if os.name == 'nt':
            con = lite.connect(DB_FILENAME)
        else:
            con = lite.connect('demosdb.db')     
    except Exception, e:
        logger.error("Can't connect to demosdb! %s" % e)

    ##################
    # SOCKET SETUP
    ##################
        
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.settimeout(SOCKET_TIMEOUT) 
 
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
    server_socket.listen(NUM_QUEUED_CONNECTIONS)
 
    # Add server socket to the list of readable connections
    CONNECTION_LIST.append(server_socket)
 
    logger.info ("     Watchdog server started on port " + str(PORT))

    #######################
    # MAIN LOOP
    #######################
    
    while 1:
        
        #######################
        # PERIODIC DATA CHECK
        #######################
        # periodic data check. Checks SQLite every X seconds for lack of replies

        if (time.time() - periodic_timer > periodic_period):
            data = get_pis_sqlite("DEVICES")
            parse_data_sqlite(data)
            periodic_timer = time.time()

        # Get the list of sockets which are ready to be read through select
        # thirty second timeout so the periodic data check will still work
        # if nothing is connected
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[], 30.0)
        
        for sock in read_sockets:

            #######################
            # NEW CONNECTION
            #######################

            if sock == server_socket:
                # Handle a new connection
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                logger.info("     Client (%s) connected" % addr[0])
                addr_str = str(addr[0])
            else:

                #######################
                # EXISTING CONNECTION
                #######################
                # Data recieved, process it

                try:
                    data = sock.recv(RECV_BUFFER)
                    if not sock:
                        logger.error("No socket, popping an error")
                    else:
                        
                        #######################
                        # CONNECTION CLOSED
                        #######################
                        # If nothing's rec'd from recv, this indicates the client has closed the connection

                        if data == '':
                            logger.info("     Client (%s) is offline" % addr[0])
                            logger.info("     due to client disconnected / closed.")
                            sock.close()
                            CONNECTION_LIST.remove(sock)
                        else:

                        #######################
                        # DATA RECEIVED
                        #######################
                        # at this point we got data, so log it

                            if data.count("ERRPI") + data.count("ERRDUINO") > 1:
                                # we may get more than one message at a time
                                # due to the way TCP works. If so, split 'em.
                                datas = re.split('(ERR)', data)
                                for data in datas:
                                    if data != "" and data != "ERR":
                                        data2 = "ERR"+data
                                        logger.debug("line is " + data2)
                                        data3 = listify_data(data2)
                                        sql_data_sqlite(data3, "ARDUINOS")
                            # otherwise, just log one message
                            else:
                                data2 = listify_data(data)
                                sql_data_sqlite(data2, "ARDUINOS")

                # just ignore socket timeouts, as they do not break the conn
                except socket.timeout:
                    logger.error("socket timeout!")
                    continue

                #######################
                # ERROR / EXCEPTION
                #######################
                # other exceptions cause the client to be removed from the list

                except Exception, e:
                    logger.info("     Client (%s) is offline" % addr[0])
                    logger.info("     due to %s" % e)
                    # prints line number info
                    for frame in traceback.extract_tb(sys.exc_info()[2]):
                        fname,lineno,fn,text = frame
                        logger.info("     in %s on line %d" % (fname, lineno))
                    sock.close()
                    addr_str = str(addr[0])
                    CONNECTION_LIST.remove(sock)
                    continue

    ##################
    # EXIT
    ##################                
    # upon exit, disconnect from mysql server and close sockets
    exit_func()
