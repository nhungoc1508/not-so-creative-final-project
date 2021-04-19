class Player {
  PVector position;
  float yOffset = height/3;
  
  Player() {
    position = new PVector(0, height-yOffset);
  }
  
  void display() {
    // Temporary: a circle of radius 15
    circle(position.x, position.y, 30);
  }
  
  void update() {
    // Temporary: change position using mouse
    position.x = mouseX;
  }
}
