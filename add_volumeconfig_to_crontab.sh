crontab -l | grep -v "/home/pi/RUNNING/scripts/setupDACs.sh" | crontab -
command="/home/pi/RUNNING/scripts/setupDACs.sh &"
job="@reboot $command"
cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | crontab -
