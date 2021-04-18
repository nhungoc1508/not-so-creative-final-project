import processing.serial.*;
Serial myPort;
int xPos=0;
int yPos;

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
  ellipse(xPos, yPos, 50, 50);
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  if (s!=null) {
    println(s);
    int value = int(s);
    println(value);
    xPos=(int)map(value, 0, 50, 0, width);
  }
  myPort.write("\n");
}
