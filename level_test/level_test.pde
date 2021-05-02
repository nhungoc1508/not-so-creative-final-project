import processing.sound.*;

Level level;
String screen = "welcome";
PFont font;
int level_count = 0;
int buttonState, prevButtonState, potenValue;
String[] academic_years = {"freshman", "sophomore", "junior", "senior"};
color nyu = color(91, 15, 141);

int frame = 0;
int frame2 = 0;
PImage poten, button, items_guide, remote_control;

String audioName = "kill.mp3";
String path, path2;
SoundFile kill_sound, background_sound;

PImage bg_welcome, bg_graduate, bg_break;

void setup() {
  fullScreen();

  String portname=Serial.list()[4]; //[4] "/dev/cu.usbmodem1101"
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  font = createFont("../data/fonts/PixelGameFont.ttf", 32);
  textFont(font);

  path = sketchPath("kill.mp3");
  kill_sound = new SoundFile(this, path);

  path2 = sketchPath("background.mp3");
  background_sound = new SoundFile(this, path2);
  background_sound.loop();

  level = new Level(0);
  poten = loadImage("../data/welcome/poten.png");
  button = loadImage("../data/welcome/button.png");
  items_guide = loadImage("../data/welcome/items_guide.png");
  remote_control = loadImage("../data/welcome/remote_control.png");
  bg_welcome = loadImage("../data/images/welcome.png");
  bg_welcome.resize(width, 0);
  bg_break = loadImage("../data/images/break.png");
  bg_break.resize(0, height);
  bg_graduate = loadImage("../data/images/graduate.png");
  bg_graduate.resize(0, height);
}

void draw() {
  background(255);

  //text("Button: "+str(buttonState)+"\nPoten: "+str(potenValue), width/2, height*.3);
  //text("Distance: "+str(xPos), width/2, height*.3);

  if (abs(xPos-smoothedNum) < width*.3) {
    smoothedNum += (xPos-smoothedNum)*.2;
  }
  //prevX = smoothedNum;
  level.player.position.x = min(smoothedNum, width*.75);
  if (level.player.position.x != prevX) {
    if (frameCount % 5 == 0) {
      level.player.frame = (level.player.frame + 1) % (level.player.num_frames - 1);
    }
  } else if (level.player.position.x == prevX) {
    level.player.frame = level.player.num_frames - 1;
  }

  if (level.player.position.x > prevX) {
    level.player.directionX = "right";
  } else if (level.player.position.x < prevX) {
    level.player.directionX = "left";
  }
  prevX = smoothedNum;
  //prevX = level.player.position.x;

  switch(screen) {
  case "welcome":
    displayWelcome();
    break;
  case "instruction":
    displayInstruction();
    break;
  case "game":
    //displayLevel();
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

  //
  //for (Map.Entry me : level.rare_items_count.entrySet()) {
  //  print(me.getKey() + " count is ");
  //  println(me.getValue());
  //  print(me.getKey() + " catch is ");
  //  println(level.rare_items_catch.get(me.getKey()));
  //}
  //
}

void displayWelcome() {
  image(bg_welcome, 0, -100);
  fill(255, 255, 255, 20);
  rect(0, 0, width, height);
  pushStyle();
  if (frameCount % 20 == 0) {
    frame = (frame + 1) % 2;
  }
  imageMode(CENTER);
  image(poten, width/2-50, height-150, 100, 100, frame*100, 0, (frame + 1)*100, 100);
  image(button, width/2+50, height-150, 100, 100, frame*100, 0, (frame+1)*100, 100);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0);
  text("TO MAKE SELECTION", width/2, height-50);
  textSize(60);
  String welcomeText = "MARHABA";
  String instructionText = "INSTRUCTION";
  String startText = "START";
  String displayText;
  float choice = (float)map(potenValue, 0, 1023, 0, 100);
  if (choice < 50) {
    instructionText = ">> INSTRUCTION <<";
    if (buttonState == 1 && prevButtonState == 0) {
      screen = "instruction";
    }
  } else {
    startText = ">> START <<";
    if (buttonState == 1) {
      screen = "game";
    }
  }
  displayText = welcomeText + "\n" + instructionText + "\n" + startText;
  text(displayText, width/2, height/2);
  popStyle();
}

void displayInstruction() {
  image(bg_welcome, 0, -100);
  fill(255, 255, 255, 20);
  rect(0, 0, width, height);
  pushStyle();
  if (frameCount % 20 == 0) {
    frame = (frame + 1) % 2;
  }
  imageMode(CENTER);
  image(button, width*.9, height-150, 100, 100, frame*100, 0, (frame+1)*100, 100);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("TO GO BACK", width*.9, height-50);
  textSize(40);
  String ins0 = "certain items are good/bad for your academics/health\n";
  String ins1 = "catch good items and avoid bad ones to reach max\nAcademics and Health";
  String ins2 = "if either drops to 0, you fail the year";
  String ins3 = "move Faiza left and right using the Arduino set\n";
  String ins4 = "LED signifies current performance";
  String instructions = ins0.toUpperCase() + "\n\n" + ins1.toUpperCase() + "\n\n" + ins2.toUpperCase() + "\n\n" + ins3.toUpperCase() + "\n\n" + ins4.toUpperCase();
  textAlign(LEFT, CENTER);
  text(instructions, width*0.05, height/2);

  textSize(50);
  fill(0);
  String displayText = "INSTRUCTIONS";
  //text(displayText, width/2, 100);
  if (buttonState == 1 && prevButtonState == 0) {
    screen = "welcome";
  }

  int w = items_guide.width;
  int h = round(items_guide.height/4);
  PImage[] guide = new PImage[4];
  for (int y=0; y < 4; y++) {
    guide[y] = items_guide.get(0, y*h, w, h);
  }
  if (frameCount % 120 == 0) {
    frame2 = (frame2+1) % 4;
  }
  image(guide[frame2], width/2, height*0.25);
  image(remote_control, width/2, height*0.75);

  popStyle();
}

void displayWin() {
  pushStyle();
  image(bg_break, 0, 0);
  rectMode(CORNER);
  fill(255, 255, 255, 100);
  rect(0, 0, width, height);
  String year = academic_years[level.levelNum].toUpperCase();
  String next_year = academic_years[level.levelNum+1];
  if (frameCount % 20 == 0) {
    frame = (frame + 1) % 2;
  }
  imageMode(CENTER);
  image(button, width/2, height-150, 100, 100, frame*100, 0, (frame+1)*100, 100);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0);
  text("TO PROCEED TO " + next_year.toUpperCase() + " YEAR", width/2, height-50);
  textSize(50);

  text("YOU MADE IT THROUGH "+year+" YEAR\nWITH GREAT HEALTH AND FLYING COLORS!", width/2, height/2);
  if (buttonState == 1 && prevButtonState == 0) {
    level_count += 1;
    level = new Level(level_count);
    screen = "game";
  }
  popStyle();
}

void displayLose() {
  pushStyle();
  image(bg_break, 0, 0);
  rectMode(CORNER);
  fill(255, 255, 255, 100);
  rect(0, 0, width, height);
  if (frameCount % 20 == 0) {
    frame = (frame + 1) % 2;
  }
  imageMode(CENTER);
  image(poten, width/2-50, height-150, 100, 100, frame*100, 0, (frame + 1)*100, 100);
  image(button, width/2+50, height-150, 100, 100, frame*100, 0, (frame+1)*100, 100);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(0);
  text("TO MAKE SELECTION", width/2, height-50);
  textSize(50);

  String year = academic_years[level.levelNum].toUpperCase();
  String title = year + " YEAR HAS BEEN ROUGH!";
  String resetLevel = "RESET LEVEL";
  String resetGame = "RESET GAME";
  String displayText;
  float choice = (float)map(potenValue, 0, 1023, 0, 100);
  if (choice < 50) {
    //displayText = year+" YEAR HAS BEEN ROUGH!\n>> RESET LEVEL <<\nRESET GAME";
    resetLevel = ">> RESET LEVEL <<";
    if (buttonState == 1 && prevButtonState == 0) {
      level = new Level(level_count);
      screen = "game";
    }
  } else {
    //displayText = year+" YEAR HAS BEEN ROUGH!\nRESET LEVEL\n>> RESET GAME <<";
    resetGame = ">> RESET GAME <<";
    if (buttonState == 1) {
      level = new Level(0);
      level_count = 0;
      screen = "game";
    }
  }
  displayText = title + "\n" + resetLevel + "\n" + resetGame;
  text(displayText, width/2, height/2);
  popStyle();
}

void displayGraduate() {
  pushStyle();
  image(bg_graduate, 0, 0);
  rectMode(CORNER);
  fill(255, 255, 255, 100);
  rect(0, 0, width, height);
  String displayText = "YOU'VE GRADUATED";
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(0);
  text(displayText, width/2, height/2);

  if (frameCount % 20 == 0) {
    frame = (frame + 1) % 2;
  }
  imageMode(CENTER);
  image(button, width/2, height-150, 100, 100, frame*100, 0, (frame+1)*100, 100);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("TO RESET GAME", width/2, height-50);
  if (buttonState == 1) {
    level = new Level(0);
    level_count = 0;
    screen = "welcome";
  }
  popStyle();
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
