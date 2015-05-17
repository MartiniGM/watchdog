#include <SPI.h>
#include <Ethernet.h>

unsigned long watchdog_millis = millis();

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {
  0x02, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
IPAddress ip(192, 168, 1, 177);
char *ipstr = "192.168.1.177";

// Enter the IP address of the server you're connecting to:
// watchdog server at .66
IPAddress server(192, 168, 1, 66);

// Initialize the Ethernet client library
// with the IP address and port of the server

EthernetClient client;

void setup() {
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);
  // Open serial communications and wait for port to open:
//  Serial.begin(9600);
//  while (!Serial) {
//    ; // wait for serial port to connect. Needed for Leonardo only
//  }


  // give the Ethernet shield a second to initialize:
  delay(1000);
//  Serial.println("connecting...");

/*
  // if you get a connection, report back via serial:
  if (client.connect(server, 6666)) {
    Serial.println("connected");
  }
  else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
  }
*/
}

void loop()
{
  
  if (millis() - watchdog_millis > 8000) {
     char message[2000];
    //two minutes are up, send an update
    sprintf(message, "ERRPI_ACKCLEAR %s", ipstr);
    client.write(message);   
  }
  
  
  // if the server's disconnected, stop the client:
  if (!client.connected()) {
  //  Serial.println();
  //  Serial.println("disconnecting.");
    client.stop();
    // do nothing:
    while (true);
  }
}




