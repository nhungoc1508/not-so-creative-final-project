// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2, c3;

void setup() {
  size(360, 640);

  // Define colors
  b1 = color(255);
  b2 = color(0);
  //c1 = color(204, 102, 0);
  //c2 = color(0, 102, 153);
  c1 = color(255, 30, 30);
  c2 = color(255, 255, 100);
  c3 = color(30, 255, 30);

  noLoop();
}

void draw() {
  // Background
  setGradient(0, 0, width/2, height, b1, b2, X_AXIS);
  setGradient(width/2, 0, width/2, height, b2, b1, X_AXIS);
  // Foreground
  setGradient(90, 50, 80, 540, c1, c2, Y_AXIS);
  setGradient(190, 50, 80, 540, c2, c1, X_AXIS);
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c3, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
