#!/bin/bash
if cd /home/pi/watchdog; then git pull; else git clone https://github.com/MeowWolf/watchdog /home/pi/watchdog; fi