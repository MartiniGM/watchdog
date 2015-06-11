#include "Arduino.h"
#include "watchdog.h"

Watchdog::Watchdog(IPAddress arduino_ip, byte arduino_mac[], IPAddress server_ip, int server_port) {
  //copies over / initializes all the variables
  _watchdog_millis = millis();
  _arduino_ip[0] = arduino_ip[0];
  _arduino_ip[1] = arduino_ip[1];
  _arduino_ip[2] = arduino_ip[2];
  _arduino_ip[3] = arduino_ip[3];
  _arduino_mac[0] = arduino_mac[0];
  _arduino_mac[1] = arduino_mac[1];
  _arduino_mac[2] = arduino_mac[2];
  _arduino_mac[3] = arduino_mac[3];
  _arduino_mac[4] = arduino_mac[4];
  _arduino_mac[5] = arduino_mac[5];
  _server_ip[0] = server_ip[0];
  _server_ip[1] = server_ip[1];
  _server_ip[2] = server_ip[2];
  _server_ip[3] = server_ip[3];
  _server_port = server_port;
  _uptime = 0;

}

/* Tries to make the initial connection to the server */ 
/* Needs to be called in the SETUP loop of your function. Note that it calls
   Ethernet.begin() (as there's no way to check if it's been called), so call 
   this BEFORE you do anything with the internet, otherwise what you do may 
   get overwritten by the second begin() call... */
void Watchdog::setup() {
  
  Ethernet.begin(_arduino_mac, _arduino_ip);
  if (_client.connect(_server_ip, _server_port)) {
    // if you get a connection, report back via serial:
    if (Serial)
      Serial.println("Successfully connected");
  } else {
    // if you didn't get a connection to the server:
    if (Serial)
      Serial.println("Failed connection");
  }
}

/* Checks to see if the Ethernet client is connected. If so, sends a message over the wire if at least 120 seconds have passed since last send. If not, tries to reconnect. Also increases uptime by 120 seconds. */

void Watchdog::sendMsg(char *msg) {
  if (_client.connected()) {
    _curmillis = millis();
    /*    if (Serial) {
      Serial.println(_curmillis - _watchdog_millis);
    }
    */
    if (_curmillis - _watchdog_millis > 60000) {
      _uptime += 60000;
      sprintf(_message, "%s %d.%d.%d.%d %lu ", msg, _arduino_ip[0], _arduino_ip[1],
	      _arduino_ip[2], _arduino_ip[3], _uptime/1000);
      
      _client.write(_message);
      if (Serial)
	Serial.println(_message);
      _watchdog_millis = millis();
    }
  }
  
  // if the server's disconnected, loop to reconnect
  if (!_client.connected()) {
    _client.stop();
    if (Serial)
      Serial.println("Reconnecting...");
    if (_client.connect(_server_ip, _server_port)) {
      if (Serial)
	Serial.println("Connected");
    }
    else {
      // if you didn't get a connection to the server:
      if (Serial)
	Serial.println("Failed connection");
    }
  }
}
  



