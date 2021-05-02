import processing.serial.*;
Serial myPort;
float xPos=0;
float yPos;
float smoothedNum = 0;
float prevX=0;

class Player {
  PVector position, dimension;
  float imgwidth, imgheight;
  PImage sprite_image;
  int num_frames, frame;
  String img_name;
  String directionX = "right";
  float yOffset = height/10;

  /**
   * Constructor of the Player object
   */
  Player() {
    position = new PVector(0, height-yOffset);
    imgwidth = 66;
    imgheight = 66;
    num_frames = 9;
    frame = 0;
    img_name = "../item_test/pngs/faiza.png";
    sprite_image = loadImage(img_name);
    dimension = new PVector(66, 66);
  }

  /**
   * Display the player according to the current moving direction
   */
  void display() {
    if (directionX == "right") {
      image(sprite_image, float(int(position.x - imgwidth/2)), float(int(position.y - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
    } else if (directionX == "left") {
      image(sprite_image, float(int(position.x - imgwidth/2)), float(int(position.y - imgheight/2)), imgwidth, imgheight, int((frame + 1) * imgwidth), 0, int(frame * imgwidth), int(imgheight));
    }
  }
}
