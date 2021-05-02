import processing.serial.*;
Serial myPort;
float xPos=0;
float yPos;
float smoothedNum = 0;
float prevX=0;

class Player {
  PVector position, dimension;
  float radius, imgwidth, imgheight;
  PImage sprite_image;
  int num_frames, frame;
  String img_name;
  String directionX = "right";
  float yOffset = height/10;

  Player() {
    position = new PVector(0, height-yOffset);
    radius = 27;
    imgwidth = 66;
    imgheight = 66;
    num_frames = 9;
    frame = 0;
    img_name = "../item_test/pngs/faiza.png";
    sprite_image = loadImage(img_name);
    dimension = new PVector(66, 66);
  }

  void display() {
    //update();
    // Temporary: a circle of radius 15

    if (directionX == "right") {
      image(sprite_image, float(int(position.x - imgwidth/2)), float(int(position.y - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
    } else if (directionX == "left") {
      image(sprite_image, float(int(position.x - imgwidth/2)), float(int(position.y - imgheight/2)), imgwidth, imgheight, int((frame + 1) * imgwidth), 0, int(frame * imgwidth), int(imgheight));
    }
    //rectMode(CENTER);
    //rect(position.x, position.y, dimension.x, dimension.y);
  }

  void update() {
    // Temporary: change position using mouse
    position.x = min(mouseX, width*.75);
    //position.x = min(smoothedNum, width*0.75);
  }
}
