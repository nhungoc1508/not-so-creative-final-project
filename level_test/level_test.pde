Level level;
String screen = "welcome";
PFont font;
int level_count = 0;
int buttonState, prevButtonState, potenValue;
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
    if (level.levelNum < 3) {
      displayWin();
    } else {
      displayGraduate();
    }
    break;
  case "lose":
    displayLose();
    break;
  }

  prevButtonState = buttonState;
}

void displayWelcome() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(0);
  String displayText;
  float choice = (float)map(potenValue, 0, 1023, 0, 100);
  if (choice < 50) {
    displayText = "WELCOME\n>> INSTRUCTION <<\nSTART";
    if (buttonState == 1 && prevButtonState == 0) {
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
  String displayText = "INSTRUCTIONS\n press button to go back";
  text(displayText, width/2, height/2);
  if (buttonState == 1 && prevButtonState == 0) {
    screen = "welcome";
  }
}

void displayWin() {
  //displayMetrics();
  String year = academic_years[level.levelNum].toUpperCase();
  String next_year = academic_years[level.levelNum+1];
  text("YOU MADE IT THROUGH "+year+" YEAR\nWITH GREAT HEALTH AND FLYING COLORS!\npress button to proceed to "+next_year+" year", width/2, height/2);
  if (buttonState == 1 && prevButtonState == 0) {
    level_count += 1;
    level = new Level(level_count);
    screen = "game";
  }
}

void displayLose() {
  String year = academic_years[level.levelNum].toUpperCase();
  String displayText;
  float choice = (float)map(potenValue, 0, 1023, 0, 100);
  if (choice < 50) {
    displayText = year+" YEAR HAS BEEN ROUGH!\n>> RESET LEVEL <<\nRESET GAME";
    if (buttonState == 1 && prevButtonState == 0) {
      level = new Level(level_count);
      screen = "game";
    }
  } else {
    displayText = year+" YEAR HAS BEEN ROUGH!\nRESET LEVEL\n>> RESET GAME <<";
    if (buttonState == 1) {
      level = new Level(0);
      screen = "game";
    }
  }
  text(displayText, width/2, height/2);
}

void displayGraduate() {
  String displayText = "YOU'VE GRADUATED";
  text(displayText, width/2, height/2);
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
  if (screen == "game") {
    if (level.academic >= 50 && level.health >= 50) {
      myPort.write("2");
    } else if (level.academic <= 25 || level.health <= 25) {
      myPort.write("0");
    } else {
      myPort.write("1");
    }
  } else {
    myPort.write("3");
  }
  myPort.write("\n");
}
