#include <SPI.h>
#include <Ethernet.h>
 
unsigned long watchdog_millis = 0;

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {
  0x02, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 1, 177);
char *ipstr = "192.168.1.177";

// Enter the IP address of the server you're connecting to:
// watchdog server at .66, hail satan
IPAddress server(192, 168, 1, 66);

// Initialize the Ethernet client library
// with the IP address and port of the server

EthernetClient client;

void setup() {
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // give the Ethernet shield a second to initialize:
  delay(1000);
  Serial.println("Connecting...");

  // if you get a connection, report back via serial:
  if (client.connect(server, 6666)) {
    Serial.println("Successfully connected");
  }
  else {
    // if you didn't get a connection to the server:
    Serial.println("Failed connection");
  }
}

void loop()
{
   unsigned long curmillis = millis();
   char message[100];
   if (client.connected()) {
   if (curmillis - watchdog_millis > 120000) {
     sprintf(message, "ERRDUINO_ACKCLEAR %s", ipstr);  
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
}




