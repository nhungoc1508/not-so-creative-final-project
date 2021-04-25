Level level;
String screen = "game";

void setup() {
  fullScreen();
  level = new Level(1);
}

void draw() {
  background(255);
  background(255);
  switch(screen) {
    case "game":
      level.testLevel();
      break;
    case "win":
      level.displayWin();
      break;
    case "lose":
      level.displayLose();
      break;
  }
}
