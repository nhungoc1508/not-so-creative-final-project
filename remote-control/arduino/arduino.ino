const int trigPin = 11;
const int echoPin = 12;
const int buttonPin = 2;
const int potenPin = A0;

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
}

void loop() {
  // put your main code here, to run repeatedly:
//  distance = getDistance();
//  Serial.println(distance);
  while (Serial.available()) {
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
