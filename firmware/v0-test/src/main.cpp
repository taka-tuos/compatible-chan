#include <Arduino.h>

#include <MD_MAX72xx.h>

#define HARDWARE_TYPE MD_MAX72XX::FC16_HW
#define MAX_DEVICES  2

#define CLK_PIN   13  // or SCK
#define DATA_PIN  12  // or MOSI
#define CS_PIN    15  // or SS

#include <Servo.h>

Servo myservo1;
Servo myservo2;

MD_MAX72XX mx = MD_MAX72XX(HARDWARE_TYPE, DATA_PIN, CLK_PIN, CS_PIN, MAX_DEVICES);

void setup() {
  myservo1.attach(2);
  myservo2.attach(0);
  
  myservo1.write(90);// move servos to 90°
  myservo2.write(90);// move servos to 90°
  delay(2000);  
  
  mx.begin();

  mx.setRow(0,0,0b00000100);
  mx.setRow(0,1,0b00000100);
  mx.setRow(0,2,0b00000000);
  mx.setRow(0,3,0b00100000);
  mx.setRow(0,4,0b00000000);
  mx.setRow(0,5,0b00000000);
  mx.setRow(0,6,0b00000000);
  mx.setRow(0,7,0b00000000);

  mx.setRow(1,0,0b00000000);
  mx.setRow(1,1,0b00000000);
  mx.setRow(1,2,0b00000000);
  mx.setRow(1,3,0b00000000);
  mx.setRow(1,4,0b00100000);
  mx.setRow(1,5,0b00000000);
  mx.setRow(1,6,0b00000100);
  mx.setRow(1,7,0b00000100);
}

void loop() {
  double rad1 = (double)(millis() % 10100) / 10100.0 * 2 * PI;
  double rad2 = (double)(millis() % 7100) / 7100.0 * 2 * PI;

  myservo1.write(90 + (sin(rad1) * 20.0));
  myservo2.write(90 + (cos(rad2) * 10.0 - 10.0));
}