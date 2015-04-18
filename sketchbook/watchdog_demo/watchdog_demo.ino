unsigned long watchdog_time = millis();
int pattime = 0;
char pattime_str[200];

void setup() {
  Serial.begin(115200);
  randomSeed(analogRead(0));
}

void loop() {
  
  if (millis() - watchdog_time > pattime) { //pat the dog every N sec
  pattime = (int)rand() % 25000 + 4000; //choose next pat time 
  sprintf(pattime_str, "patting in %d", pattime); 
  Serial.println(pattime_str); //and send it to Python on the Pi
  watchdog_time = millis();
  }
  //otherwise blah blah lights, blah sound
}
