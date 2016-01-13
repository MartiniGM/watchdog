command="/home/pi/RUNNING/scripts/watchdog.py"
job="@reboot $command"
cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | crontab -