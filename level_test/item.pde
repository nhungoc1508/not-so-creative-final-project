class Item {
  float posX, posY, radius, velocityY, imgwidth, imgheight;
  PImage sprite_image;
  int num_frames, frame;
  String img_name;
  int value;

  /**
   * Construction of Item class
   */
  Item(float r, String image_name, float img_w, float img_h, int number_frames, int item_value) {
    posX = random(50, width*.75);
    posY = 0;
    radius = r;
    velocityY = random(2, 6);
    img_name = image_name;
    image_name = "../item_test/pngs/" + image_name +".png";
    sprite_image = loadImage(image_name);
    imgwidth = img_w;
    imgheight = img_h;
    num_frames= number_frames;
    value = item_value;
    frame = 0;
  }

  /**
   * Update position of item
   */
  void update() {
    posY += velocityY;

    if (frameCount % 12 == 0) {
      frame = (frame + 1) % num_frames;
    }
  }

  /**
   * Display item on the screen
   */
  void display() {
    update();
    image(sprite_image, float(int(posX - imgwidth/2)), float(int(posY - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
  }

  /**
   * Check if item is off the screen
   */
  boolean outOfScreen() {
    return (posY >= width);
  }
}
