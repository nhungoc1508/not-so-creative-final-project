Level level;

void setup() {
  fullScreen();
  level = new Level(1);
  println("Lost?", level.lost());
  println("Won?", level.won());
}

void draw() {
  background(255);
}
