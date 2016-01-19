crontab -l | sed "/^#.*/home/pi/RUNNING/scripts/watchdog.py/s/^#//" | crontab -
command="/home/pi/RUNNING/scripts/watchdog.py > /dev/null &"
job="@reboot $command"
cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | crontab -