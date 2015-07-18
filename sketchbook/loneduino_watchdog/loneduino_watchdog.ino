#include <watchdog.h>
#include <SPI.h>
#include <Ethernet.h>
#include <EthernetUdp.h>  
#include <OSCMessage.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {
  0x02, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 1, 177);

// Enter the IP address of the watchdog server you're connecting to:
IPAddress server(192, 168, 1, 66);
int server_port = 6666;

// Initializes the watchdog with the IP address and port of the server
Watchdog watchdog(ip, mac, server, server_port);

void setup() {
  // starts the Ethernet connection:
  watchdog.setup();   
  // Opens serial communications. Uncomment these lines if you want feedback
  // over the Serial Monitor.
//  Serial.begin(9600);
 // while (!Serial) {
  //  ; // wait for serial port to connect. Needed for Leonardo only
 // }
  
  // give the Ethernet shield a second to initialize:
  delay(1000);   
}

void loop()
{
  //sends an ERRPI_ACKCLEAR every 120 seconds, reconnects if necessary
 watchdog.sendMsg("ERRPI_ACKCLEAR");
 
 /* [...] Do other things here */
}




