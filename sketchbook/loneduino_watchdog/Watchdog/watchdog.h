#ifndef Watchdog_h
#define Watchdog_h

#include "Arduino.h"
#include <Ethernet.h>
#include <EthernetUdp.h>

class Watchdog
{
  public:
  Watchdog(IPAddress arduino_ip, byte arduino_mac[], IPAddress server_ip, int server_port);
  void sendMsg(char *msg); //sends "msg" over Ethernet with IP and uptime
  void setup(); //initializes variables & connection
  private:
  EthernetClient _client;
  unsigned long _uptime; //total uptime. Figured by adding 120 sec each msgSend
  unsigned long _watchdog_millis; //total milliseconds since the last msgSend
  unsigned long _curmillis; //global var for msgSend
  IPAddress _arduino_ip; //IPAddress for the arduino
  byte _arduino_mac[]; //mac address for the arduino
  IPAddress _server_ip; //IPAddress for the server
  int _server_port; //port number for the server
  char _message[200]; //global var for msgSend
  
};

#endif
