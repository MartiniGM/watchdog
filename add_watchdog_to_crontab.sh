#!/bin/bash
#adds the watchdog to the crontab, but only if it's not already in there
command="/home/pi/RUNNING/scripts/watchdog.py"
job="@reboot $command"
cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | crontab -