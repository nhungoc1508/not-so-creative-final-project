Player player;

void setup() {
  fullScreen();
  player = new Player();
}

void draw() {
  background(255);
  noStroke();
  fill(246, 124, 96);
  player.display();
  player.update();
}
