# set TCP watchdog IP and port here
host = '10.42.16.17'
remote_ip = ""
this_ip = ""
port = 6666

############################################################
# send_ok_now()
############################################################ 
# this sends an OK message (ERRDUINO_ACKCLEAR or ERRPI_ACKCLEAR) via UDP
# moved this up because for now watchdog.py doesn't send OK msgs for
# connected devices -- serial2pipe does that
def send_ok_now(pi_or_arduino, status, append_string):
    global this_ip

    print ('.'),
    sys.stdout.flush()
    if (USE_SOCKETS):
        try:
            if (pi_or_arduino == "PI"):
                ip = this_ip
                uptime_string , uptime_seconds = get_uptime()
                if (len(str(append_string)) == 0):
                    message = status + " " + ip + " " + str(uptime_seconds) + " " + str(uptime_string)                         
                else:
                    if append_string[0] != '/':
                        message = status + " " + ip + "/" + str(append_string) + " " + str(uptime_seconds) + " " + str(uptime_string)
                    else:
                        message = status + " " + ip + str(append_string) + " " + str(uptime_seconds) + " " + str(uptime_string)
                watchsock.sendto(message, (remote_ip, port))
        except socket.error as e:
            print( "Send failed! %s" % e, exc_info=True)
            for frame in traceback.extract_tb(sys.exc_info()[2]):
                fname,lineno,fn,text = frame
                print "     in %s on line %d" % (fname, lineno)
                if (status == 1):
                    print message
                    watchsock.sendto(message, (remote_ip, port))
                else:
                    print "failed to send"
                 #put retry here
        except IOError as e:
            print( "failed to send %s " % e, exc_info=True)
                 #put retry here

############################################################
# get_ip_address()
############################################################
# gets IP address of eth0 as a string
def get_ip_address(ifname):
    try:
        if os.name == 'nt':
            import socket
#        hostname = socket.gethostname()
#        IP = socket.gethostbyname(hostname)
#        print IP
#        return(IP)
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(('8.8.8.8', 0))  # connecting to a UDP address doesn't send packets
            local_ip_address = s.getsockname()[0]
            #        print local_ip_address
            return local_ip_address
        else:
            if sys.platform == 'linux' or sys.platform == 'linux2':
                import fcntl
                import socket
                s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
                return socket.inet_ntoa(fcntl.ioctl(
                        s.fileno(),
                        0x8915,  # SIOCGIFADDR
                        struct.pack('256s', ifname[:15])
                        )[20:24])
            else: #mac os probably
                import socket
                local_ip_address = socket.gethostbyname(socket.gethostname())
            #            print local_ip_address
                return local_ip_address
    except Exception, e:
        print ("error in get_ip_address: %s" % e, exc_info=True)
        return ""

############################################################
# socket_connect()
############################################################   
# connects to the TCP watchdog. See host/port above. Run in a loop to retry
def socket_connect():
    global watchsock
    global host
    global remote_ip
    global port
    global this_ip
    if (USE_SOCKETS):
        try:
            watchsock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
            remote_ip = socket.gethostbyname( host )
        except socket.error as e:
            print( 'Failed to create socket: %s' % e, exc_info=True)
            return 0
        else:
            print ('Socket created. Messages will be sent to: ' + remote_ip),
            sys.stdout.flush()
            return 1
    
###################################
# main() 
###################################  
                 
this_ip = get_ip_address('eth0')
socket_connect()
send_ok_now("PI", "ERRPI_NOREPLY", "ups")
time.sleep(1)
send_ok_now("PI", "ERRPI_NOREPLY", "ups")
time.sleep(1)
send_ok_now("PI", "ERRPI_NOREPLY", "ups")
time.sleep(1)
                
