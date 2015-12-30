#!/bin/bash

ALARM="False"
SWITCHES="10.42.0.16"
INITIAL_DELAY=3
LIST_DOWN=""

MYDIR=`pwd`
LOG=$MYDIR/logs/$0\.log
touch $LOG
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
      \"icon_emoji\": \":floppy_disk:\"}" ###<WEBHOOK>### 
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
        ( at now +$DELAY minutes -f $MYDIR/$0 $(($DELAY * 3)) ) >> $LOG
      else
        if [ "$DELAY" -ne "$INITIAL_DELAY" ]
        then
          MSG="something came back up!"
          DELAY=$INITIAL_DELAY
          sendSMS $MSG
          sendSlack $MSG
        fi
      fi
    done
  fi
done

