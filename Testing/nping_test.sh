#!/bin/bash
nping --udp -p 6666 192.168.254.5 --data-string "ERRPI_ACKCLEAR 10.42.16.190 3360" --rate 50 -c 500
