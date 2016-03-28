#!/usr/bin/python

import logging
import logging.handlers

VOLUME_FILENAME = '/home/pi/RUNNING/scripts/volume.txt'
volume = "50%" #default volume if we can't read the volume file

LOG_FILENAME = '/home/pi/RUNNING/scripts/set_volume.out'
LOCAL_LOG_FILENAME = 'set_volume.out' #if the above doesn't work, we'll use this

####################
# EXIT HANDLER
####################
# ensures we can kill the script with ctrl-C for testing
def signal_handler(signal, frame):
    logger.info('Exiting...')
    watchsock.close()
    os._exit(0) 

signal.signal(signal.SIGINT, signal_handler)

####################
# setup_logger()
####################
# sets up circular error logging
def setup_logger():
    global logger
    # defines log levels for the log file. Default is 'info' and above.
    # Run program with "debug" on the command line for extra debugging output
    LEVELS = { 'debug':logging.DEBUG,
               'info':logging.INFO,
               'warning':logging.WARNING,
               'error':logging.ERROR,
               'critical':logging.CRITICAL,
               }

    # default log level is info (prints info, warning, error, etc).
    # run with "watchdog.py debug" to print/log debug messages
    if len(sys.argv) > 1:
        level_name = sys.argv[1]
        level = LEVELS.get(level_name, logging.NOTSET)
        logging.basicConfig(level=level)
    else:
        level = LEVELS.get('info', logging.NOTSET)
        logging.basicConfig(level=level)
    
    # creates our logger with the settings above/below
    logger = logging.getLogger('VolumeLog')
    try:
    # Add the log message handler to the logger. Creates a rolling/circular log
    # with LOG_NUM_BACKUPS backups, each of size LOG_SIZE bytes
        handler = logging.handlers.RotatingFileHandler(LOG_FILENAME,
                                                   maxBytes=LOG_SIZE,
                                                   backupCount=LOG_NUM_BACKUPS)
    except:
        handler = logging.handlers.RotatingFileHandler(LOCAL_LOG_FILENAME,
                                                       maxBytes=LOG_SIZE,
                                                       backupCount=LOG_NUM_BACKUPS)
        # sets the message & timestamp format for the log, if exception
        frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
        handler.setFormatter(frmt)
        logger.addHandler(handler)
    # sets the message & timestamp format for the log, normal completion
    frmt = logging.Formatter('%(asctime)s - %(message)s',"%d/%m/%Y %H:%M:%S")
    handler.setFormatter(frmt)
    logger.addHandler(handler)

####################
# read_volume_file()
####################
# reads the volume file and returns it as a list of lists
def read_volume_file():
    global volume
    returnlist = []
    endl = os.linesep;
    try:
        if os.path.exists(VOLUME_FILENAME):
            try:
                with open(VOLUME_FILENAME, 'r') as infile:
                    for line in infile:
                        #don't include newline
                        templist = line.rstrip(endl).split()
                        returnlist.append(templist)
            except Exception, e:
                logger.warning( "optional volume read error: %s" % e, exc_info=True)
    except:
        logger.warning( "no optional volume file found? %s" % e, exc_info=True)   
#####################
# start_proc()
#####################
# starts a proc. expects full path name as a list
def start_proc(process_name):
    if sys.platform == 'linux' or sys.platform == 'linux2': 
        try:
        # preexec_fn=os.setsid, close_fds=True is the key to not killing the
        # process when the watchdog dies or is ctrl-c'd, and not letting
        # child processes hold onto the watchdog's own ports
            tmp_process = subprocess.Popen(process_name, preexec_fn=os.setsid, close_fds=True)
        except Exception, e:
            print "error in start-proc: can't start %s: %s" % (process_name, e)
    else:
        if os.name == 'nt':
            try:
        # preexec_fn=os.setsid, close_fds=True is the key to not killing the
        # process when the watchdog dies or is ctrl-c'd, and not letting
        # child processes hold onto the watchdog's own ports
                tmp_process = subprocess.Popen(process_name, close_fds=True)
            except Exception, e:
                print "error in start-proc: can't start %s: %s" % (process_name, e)

####################
# set_volume()
####################
# sets the volume on this Pi
def set_volume():
    #command is like: amixer -c <card number> -- sset <Headphone|Speaker> playback <value>

setup_logger()
items = read_volume_file()
for item in items:
    (card_number, item_name, volume_amount) = item
    command = ["amixer", "-c", card_number, "--", "sset", item_name, "playback", volume_amount]
    set_volume(command)
