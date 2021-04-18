import processing.serial.*;
Serial myPort;
float xPos=0;
float yPos;
float smoothedNum = 0;
float prevX=0;

void setup() {
  //size(960, 720);
  fullScreen();
  yPos=height/2;
  //printArray(Serial.list());
  String portname=Serial.list()[4]; //[4] "/dev/cu.usbmodem1101"
  //println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw() {
  background(255);
  fill(100, 200, 200);
  noStroke();
  if (abs(xPos-smoothedNum) < width*.3) {
    smoothedNum += (xPos-smoothedNum)*.2;
  }
  ellipse(smoothedNum, yPos, 50, 50);
  prevX = smoothedNum;
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  if (s!=null) {
    println(s);
    int value = int(s);
    println(value);
    xPos=(float)map(value, 0, 50, 0, width);
  }
  myPort.write("\n");
}
