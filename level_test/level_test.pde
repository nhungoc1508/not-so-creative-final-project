Level level;
String screen = "welcome";
PFont font;
int level_count = 0;
int buttonState, potenValue;
String[] academic_years = {"freshman", "sophomore", "junior", "senior"};

void setup() {
  fullScreen();

  String portname=Serial.list()[4]; //[4] "/dev/cu.usbmodem1101"
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  font = createFont("../data/fonts/PixelGameFont.ttf", 32);
  textFont(font);
  level = new Level(0);
}

void draw() {
  background(255);

  //text("Button: "+str(buttonState)+"\nPoten: "+str(potenValue), width/2, height*.3);
  //text("Distance: "+str(xPos), width/2, height*.3);

  if (abs(xPos-smoothedNum) < width*.3) {
    smoothedNum += (xPos-smoothedNum)*.2;
  }
  prevX = smoothedNum;
  level.player.position.x = smoothedNum;

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
    displayWin();
    break;
  case "lose":
    displayLose();
    break;
  }
}

void displayWelcome() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(0);
  String displayText;
  float choice = (float)map(potenValue, 0, 1023, 0, 100);
  if (choice < 50) {
    displayText = "WELCOME\n>> INSTRUCTION <<\nSTART";
    if (buttonState == 1) {
      screen = "instruction";
    }
  } else {
    displayText = "WELCOME\nINSTRUCTION\n>> START <<";
    if (buttonState == 1) {
      screen = "game";
    }
  }
  text(displayText, width/2, height/2);
}

void displayInstruction() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(0);
  String displayText = "INSTRUCTIONS\n press left to go back";
  text(displayText, width/2, height/2);
}

void displayWin() {
  //displayMetrics();
  String year = academic_years[level.levelNum].toUpperCase();
  text("YOU MADE IT THROUGH "+year+" YEAR\nWITH GREAT HEALTH AND FLYING COLORS!\npress right for next year", width/2, height/2);
}

void displayLose() {
  //displayMetrics();
  String year = academic_years[level.levelNum].toUpperCase();
  text(year+" YEAR HAS BEEN ROUGH!\nRESET LEVEL -- | -- RESET GAME", width/2, height/2);
}

void displayGraduate() {
  String displayText = "YOU'VE GRADUATED";
  text(displayText, width/2, height/2);
}

void keyPressed() {
  switch(screen) {
  case "welcome":
    if (keyPressed && keyCode == LEFT) {
      screen = "instruction";
    } else if (keyPressed && keyCode == RIGHT) {
      screen = "game";
    }
    break;
  case "instruction":
    if (keyPressed && keyCode == LEFT) {
      screen = "welcome";
    }
    break;
  case "win":
    if (keyPressed && keyCode == RIGHT) {
      level_count += 1;
      level = new Level(level_count);
      screen = "game";
    }
    break;
  case "lose":
    if (keyPressed) {
      if (keyCode == LEFT) {
        level = new Level(level_count);
      } else if (keyCode == RIGHT) {
        level = new Level(0);
      }
      screen = "game";
    }
    break;
  }
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  if (s!=null) {
    float values[] = float(split(s, ','));
    if (values.length==3) {
      buttonState = (int)(values[0]);
      potenValue = (int)(values[1]);
      xPos=(float)map(values[2], 0, 50, 0, width);
    }
  }
  myPort.write("\n");
}
