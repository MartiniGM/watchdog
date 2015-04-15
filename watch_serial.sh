#!/bin/bash
set -x
socat -d -d PTY: PTY: &
socat -d -d PTY: PTY: &
sleep 5
echo "now connect your Python script to /dev/pts/4, and its output to /dev/pts/5."
echo "if two using Arduinos, connect the second set as above, to /dev/pts/6 and /dev/pts/7."