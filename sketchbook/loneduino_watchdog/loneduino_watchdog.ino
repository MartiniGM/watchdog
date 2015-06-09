#include <watchdog.h>
#include <SPI.h>
#include <Ethernet.h>
#include <EthernetUdp.h>  
#include <OSCMessage.h>

EthernetUDP Udp;
//unsigned long watchdog_millis = 0;
const unsigned int outPort = 8011;

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {
  0x02, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 1, 177);
//char *ipstr = "192.168.1.177";

// Enter the IP address of the server you're connecting to:
// watchdog server at .66, hail satan
IPAddress server(192, 168, 1, 66);
int server_port = 6666;
// Initialize the Ethernet client library
// with the IP address and port of the server

Watchdog watchdog(ip, mac, server, server_port);

void setup() {
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);
  watchdog.setup();   
  Udp.begin(8888);
  // Open serial communications and wait for port to open:
  //Serial.begin(9600);
  //while (!Serial) {
    //; // wait for serial port to connect. Needed for Leonardo only
  //}
  // give the Ethernet shield a second to initialize:
  delay(1000);   
}

void loop()
{
 watchdog.sendMsg("ERRPI_ACKCLEAR");

/*  unsigned long curmillis = millis();
   char message[100];

   if (client.connected()) {
   if (curmillis - watchdog_millis > 120000) {
     sprintf(message, "ERRPI_ACKCLEAR %s", ipstr);  
     client.write(message);
     watchdog_millis = millis();
   }
   }
  
  // if the server's disconnected, loop to reconnect
  if (!client.connected()) {
    client.stop();
    Serial.println("Reconnecting...");
  if (client.connect(server, 6666)) {
    Serial.println("Connected");
  }
  else {
    // if you didn't get a connection to the server:
    Serial.println("Failed connection");
  }
  }
*/
}




