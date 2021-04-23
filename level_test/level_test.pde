Level level;

void setup() {
  fullScreen();
  level = new Level(1);
}

void draw() {
  background(255);
  level.testLevel();
}
