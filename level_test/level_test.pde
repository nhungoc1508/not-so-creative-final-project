Level level;
String screen = "welcome";
PFont font;

void setup() {
  fullScreen();
  font = createFont("../data/fonts/PixelGameFont.ttf", 32);
  textFont(font);
  level = new Level(1);
}

void draw() {
  background(255);
  // Display welcome
  // |- Display Instructions
  // |- Display Game (level 1)
  // |- - Display Game
  // |- - Display Win
  // |- - - Exit
  // |- - - Display Game (level 2) ...
  // |- - Display Lost
  // |- - - Restart game
  // |- - - Restart level
  // |- - - Exit
  switch(screen) {
  case "welcome":
    displayWelcome();
    break;
  case "instruction":
    displayInstruction();
    break;
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

void displayWelcome() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(0);
  String displayText = "WELCOME\nINSTRUCTION | START";
  text(displayText, width/2, height/2);
}

void displayInstruction() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(0);
  String displayText = "INSTRUCTIONS\n press left to go back";
  text(displayText, width/2, height/2);
}

void keyPressed() {
  if (screen == "welcome") {
    if (keyPressed) {
      if (keyCode == LEFT) {
        screen = "instruction";
      } else if (keyCode == RIGHT) {
        screen = "game";
      }
    }
  } else if (screen == "instruction") {
    if (keyPressed) {
      if (keyCode == LEFT) {
        screen = "welcome";
      }
    }
  }
}
