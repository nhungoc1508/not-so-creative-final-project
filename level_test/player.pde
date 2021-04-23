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
  }
}
