
class Item {
  float posX, posY, radius, velocityY, imgwidth, imgheight;
  PImage sprite_image;
  int num_frames, frame;
  
  Item(float r, String image_name, float img_w, float img_h, int number_frames) {
    posX = random(0, width); // to be changed based on whether or not the full sprite appears
    posY = 0; // to be changed based on where the item starts falling from
    radius = r;
    velocityY = random(2,6); // might be changed
    image_name = "pngs/" + image_name;
    sprite_image = loadImage(image_name);
    imgwidth = img_w;
    imgheight = img_h;
    num_frames= number_frames;
    frame = 0;
  }
  
  void update() {
    posY += velocityY;
    
    if (frameCount % 12 == 0){
        frame = (frame + 1) % num_frames;
    }
  }
  
  void display() {
    update();
    image(sprite_image, float(int(posX - imgwidth/2)), float(int(posY - imgheight/2)), imgwidth, imgheight, int(frame * imgwidth), 0, int((frame + 1) * imgwidth), int(imgheight));
    //ellipse(posX, posY, radius, radius);
  }
  
}
