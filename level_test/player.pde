import processing.serial.*;
Serial myPort;
float xPos=0;
float yPos;
float smoothedNum = 0;
float prevX=0;

class Player {
  PVector position, dimension;
  float yOffset = height/10;
  
  Player() {
    position = new PVector(0, height-yOffset);
    dimension = new PVector(100, 30);
  }
  
  void display() {
    update();
    // Temporary: a circle of radius 15
    rectMode(CENTER);
    rect(position.x, position.y, dimension.x, dimension.y);
  }
  
  void update() {
    // Temporary: change position using mouse
    position.x = min(mouseX, width*.75);
    //position.x = min(smoothedNum, width*0.75);
  }
}
