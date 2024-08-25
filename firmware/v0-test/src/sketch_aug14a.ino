#include <Servo.h>

Servo myservo1;
Servo myservo2;

void setup(){
  myservo1.attach(2);
  myservo2.attach(0);
  
  myservo1.write(90);// move servos to 90°
  myservo2.write(90);// move servos to 90°
  delay(2000);  
} 

void loop(){
  double rad1 = (double)(millis() % 10100) / 10100.0 * 2 * PI;
  double rad2 = (double)(millis() % 7100) / 7100.0 * 2 * PI;

  myservo1.write(90 + (sin(rad1) * 20.0));
  myservo2.write(90 + (cos(rad2) * 10.0 - 10.0));

  delay(20);
}
