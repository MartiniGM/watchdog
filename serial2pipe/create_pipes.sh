#!/bin/bash
if [ $# -ne 1 ]
    then
      echo "create_pipes.sh: creates named pipes for data transfer."
      echo "Usage: create_pipes.sh [number for this pair]"
      exit
fi

echo "mkfifo watchdog_pipe$1"
mkfifo watchdog_pipe$1
echo "mkfifo arduino_pipe$1"
mkfifo arduino_pipe$1