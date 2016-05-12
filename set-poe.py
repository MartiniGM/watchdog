#!/usr/bin/env python

# this script queries a switch for all interfaces on VLAN 16
# then turns PoE on or off (auto or never) for each interface

import pexpect
import sys
import re
import time

# this is all we really care about
interfaceRegex = re.compile(r'Fa\d/\d/\d')

try:
    powerArg = str(sys.argv[1])
    switchIP = str(sys.argv[2])
except:
    print("usage: " + str(sys.argv[0]) + " <auto|never> <ip address>")
    print( sys.exc_info()[0])
    sys.exit(2)

try:
    f1 = open('/Users/Aesir/Documents/watchdog/power_passphrase1.secret', 'r')
    ssh_pass = f1.readline()
    f1.close()
    f2 = open('/Users/Aesir/Documents/watchdog/power_passphrase2.secret', 'r')
    enable_pass = f2.readline()
    f2.close()
except IOError as e:
    print "I/O error({0}): {1}".format(e.errno, e.strerror)
    sys.exit(2)

try:
    s = pexpect.spawnu(u'ssh meow@' + switchIP )
    s.logfile = sys.stdout
    s.expect(u'[Pp]assword:')
    s.send(ssh_pass)

    s.expect(u'>')
    s.send(u'enable\r')
    s.expect(u'[Pp]assword:')
    s.send(enable_pass)
    s.expect(u'#')
    s.send(u'show vlan id 16\r')
    s.expect(u'#')
    matches = interfaceRegex.findall(s.before)

# sometimes we get duplicates, so get rid of them
    seen = set()
    uniqueMatches = []
    for x in matches:
        if x not in seen:
            uniqueMatches.append(x)
            seen.add(x)

    s.send(u'conf t\r')
    s.expect(u'\(config\)#')

    for interface in uniqueMatches:
        s.send(u'interface ' + interface + '\r')
        s.expect(u'\(config-if\)#')
        s.send(u'power inline ' + powerArg + '\r')
        s.expect(u'\(config-if\)#')
        s.send(u'exit\r')
        s.expect(u'\(config\)#')
except EOFError as e:
    print("eof error")
    print("debug information:")
    print(str(s))
except:
    print("unexpected exception was thrown!")
    print "Unexpected error:", sys.exc_info()[0]
    sys.exit(2)

if s.isalive():
    s.sendline('exit') # Try to ask ssh to exit.
    s.close()

# Print the final state of s. Normally isalive() should be FALSE.
if s.isalive():
    print('ssh did not exit gracefully.')
else:
    print('ssh exited gracefully.')
