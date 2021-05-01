const int trigPin = 11;
const int echoPin = 12;
const int buttonPin = 2;
const int potenPin = A0;

const int pinRed = 6, pinGreen = 5, pinBlue = 3;
int color = 0;

float distance;
int buttonState, potenValue;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("0");
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buttonPin, INPUT);
  pinMode(potenPin, INPUT);

  pinMode(pinBlue, OUTPUT);
  pinMode(pinGreen, OUTPUT);
  pinMode(pinRed, OUTPUT);

  analogWrite(pinBlue, 0);
  analogWrite(pinGreen, 0);
  analogWrite(pinRed, 0);
}

void loop() {
  // put your main code here, to run repeatedly:
  //  distance = getDistance();
  //  Serial.println(distance);
  while (Serial.available()) {
    color = Serial.parseInt();
    if (Serial.read() == '\n') {
      distance = getDistance();
      buttonState = digitalRead(buttonPin);
      potenValue = analogRead(potenPin);
      delay(1);

      Serial.print(buttonState);
      Serial.print(',');
      Serial.print(potenValue);
      Serial.print(',');
      Serial.println(distance);

      if (color == 0) {
        setColorBrightness('r', 255);
        setColorBrightness('g', 0);
        setColorBrightness('b', 0);
      }
      else if (color == 1) {
        setColorBrightness('r', 200);
        setColorBrightness('g', 50);
        setColorBrightness('b', 0);
      }
      else if (color == 2) {
        setColorBrightness('r', 0);
        setColorBrightness('g', 200);
        setColorBrightness('b', 0);
      }
      else if (color == 3) {
        setColorBrightness('r', 0);
        setColorBrightness('g', 0);
        setColorBrightness('b', 0);
      }
    }
  }
}

float getDistance()
{
  float echoTime;                   //variable to store the time it takes for a ping to bounce off an object
  float calculatedDistance;         //variable to store the distance calculated from the echo time

  //send out an ultrasonic pulse that's 10ms long
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  echoTime = pulseIn(echoPin, HIGH);      //use the pulsein command to see how long it takes for the
  //pulse to bounce back to the sensor

  // calculatedDistance = echoTime / 148.0;  //calculate the distance of the object that reflected the pulse (half the bounce time multiplied by the speed of sound)
  calculatedDistance = echoTime / 58.0;

  return calculatedDistance;              //send back the distance that was calculated
}

void setColorBrightness(char color, int brightness)
{
  //if else tree used to select the correct color control pin
  if (color == 'r')
  {
    analogWrite(pinRed, brightness);//Write to pwm pin 6  (red control)
  }
  else if (color == 'g')
  {
    analogWrite(pinGreen, brightness);//Write to pwm pin 5  (green control)
  }
  else if (color == 'b')
  {
    analogWrite(pinBlue, brightness);//Write to pwm pin 3  (blue control)
  }

  return;
}
