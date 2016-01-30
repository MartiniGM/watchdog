#!/bin/bash
# good data
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 10.42.16.190 3360" --rate 1 -c 2
# with uptime timestamp because sure, why not
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 10.42.16.190 3360 1 day, 21:23:44" --rate 1 -c 2
# uh oh, no IP
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 3360" --rate 1 -c 2
# uh oh, no uptime
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 10.42.16.190" --rate 1 -c 2
# uh oh, super long uptime
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 10.42.16.190 66666666666666666666666666" --rate 1 -c 2
# uh oh, bad timestamp
nping --udp -p 6666 10.42.34.14 --data-string "ERRPI_ACKCLEAR 10.42.16.190 66666 blah blah blah blip" --rate 1 -c 2
# uh oh, bad status code
nping --udp -p 6666 10.42.34.14 --data-string "ERR_BLAH 10.42.16.190 66666 blah blah blah blip" --rate 1 -c 2
#uh oh, no status code (which is seen as a bad ID name)
nping --udp -p 6666 10.42.34.14 --data-string "10.42.16.190 66666 blah blah blah blip" --rate 1 -c 2
#uh oh, just crap
nping --udp -p 6666 10.42.34.14 --data-string "ksajdhfkajhg adskjhkjgdh asjkdfha" --rate 1 -c 2
#uh oh, just crap with a valid ID (so uptime is a string)
nping --udp -p 6666 10.42.34.14 --data-string "ksajdhfkajhg 10.42.16.190 adskjhkjgdh asjkdfha" --rate 1 -c 2
#uh oh, buffer overflow?
nping --udp -p 6666 10.42.34.14 --data-string "ksajdhfkajhgajsdfkljfdglkjlgkjlkjlksjdlkjglkajlkjslkdjljdglkjdsglkajsdglkdjglajdlkjaslkjasldkgjlkasjglksdjfglksjdglkjgdlkjdfglkjadglkjlkjdglkjadglkjdlkalkjerglakjljdlgjljldksjglkdjglkajsdgljasdljdglkjglkjagslkjadglkjdgslkjdsgljagdlskjdglkjasdglkjasglkjdgslkjgljasdglkjaldgskjglwjarilgjwoiejgoijgoijgoijsgoijsdfjaklsclkankawjfjkag;jg;j 10.42.16.190 adskjhkjgdh asjkdfha" --rate 1 -c 2
#uh oh, buffer overflow #2
nping --udp -p 6666 10.42.34.14 --data-string "OKAY 10.42.16.190 adskjhkjgdh asjkdfhasajdhfkajhgajsdfkljfdglkjlgkjlkjlksjdlkjglkajlkjslkdjljdglkjdsglkajsdglkdjglajdlkjaslkjasldkgjlkasjglksdjfglksjdglkjgdlkjdfglkjadglkjlkjdglkjadglkjdlkalkjerglakjljdlgjljldksjglkdjglkajsdgljasdljdglkjglkjagslkjadglkjdgslkjdsgljagdlskjdglkjasdglkjasglkjdgslkjgljasdgljaldgskjglwjarilgjwoiejgoijgoijgoijsgoijsdfjaklsclkankawjfjkag;jg;j" --rate 1 -c 2
#uh oh, nothin' at all
nping --udp -p 6666 10.42.34.14 --data-string " " --rate 1 -c 2