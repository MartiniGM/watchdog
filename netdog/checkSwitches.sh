#!/bin/bash

ALARM="False"
SWITCHES="10.42.0.16"
INITIAL_DELAY=6
LIST_DOWN=""

MYDIR=`pwd`
LOG=$MYDIR/logs/$0\.log
if [ "$1" -eq "$1" ] 2>/dev/null
then
  DELAY=$1
else
  DELAY=$INITIAL_DELAY
fi

sendSlack()
{
  MSG="$@"
  echo "sending to slack" 
  curl -X POST --data-urlencode "payload={
      \"text\": \"$MSG\",
      \"channel\": \"#network\",
      \"username\": \"cricket\",
      \"icon_emoji\": \":floppy_disk:\"}" https://hooks.slack.com/services/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
}

sendSMS()
{
  MSG="$@"
  echo "sending to Matt" 
  curl http://textbelt.com/text -d number=5056157183 -d "message=$MSG"
  echo "sending to Chris" 
  curl http://textbelt.com/text -d number=5056999500 -d "message=$MSG"
}

while true
do
  if [ $ALARM = "False" ]
  then
    for s in $SWITCHES; do
      #echo "checking $s"
      P=`ping -c 1 $s | grep "Destination Host Unreachable"`
      #echo "here is p $P"
      if [ -n "$P" ]
      then
        ALARM="True"
        LIST_DOWN="$LIST_DOWN $s"
        MSG="[!] \t `date` \t LINK TO $s IS DOWN"
        echo "$MSG" 
        sendSlack $MSG
        MSG="[!] at `date` the link to $s went DOWN!"
        sendSMS $MSG
        # schedule me in exponential time
        at now +$(($DELAY * 2)) minutes -f $MYDIR/$0 >> $LOG
      else
        DELAY=$INITIAL_DELAY
      fi
    done
  fi
done

