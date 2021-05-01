import java.util.ArrayList;
import java.util.Map;

class Level {
  Player player = new Player();
  String[] academic_years = {"freshman", "sophomore", "junior", "senior"};
  Table table0, table1;
  int numRow0, numRow1;
  ArrayList<String> item_names = new ArrayList<String>();
  HashMap<String, Integer> frames = new HashMap<String, Integer>();
  StringList posAcademic = new StringList();
  StringList negAcademic = new StringList();
  StringList posHealth = new StringList();
  StringList negHealth = new StringList();
  ArrayList<Item> items = new ArrayList<Item>();
  int levelNum;
  int academic = 50;
  int health = 50;
  float xOffset = width*.75;
  int default_value = 20;
  int random_number;
  PImage bg_freshman, bg_sophomore, bg_junior, bg_senior;

  Level(int level_num) {
    levelNum = level_num;
    loadData();
    //items.add(new Item(30, "jterm2", 100, 100, 1));

    bg_freshman = loadImage("../data/images/freshman.png");
    bg_freshman.resize(width, 0);
    bg_sophomore = loadImage("../data/images/nyc.png");
    bg_sophomore.resize(0, height);
    bg_junior = loadImage("../data/images/nyc2.png");
    bg_junior.resize(0, height);
    bg_senior = loadImage("../data/images/senior2.png");
    bg_senior.resize(0, height);
  }

  void testLevel() {
    displayBackground();
    player.display();
    addItems();
    displayItems();
    checkCollision();
    displayMetrics();
    if (won()) {
      screen = "win";
    }
    if (lost()) {
      screen = "lose";
    }

    //if (!items.isEmpty()) {
    //  for (int i=0; i<items.size(); i++) {
    //    Item cur_item = items.get(0);
    //    if (cur_item.outOfScreen()) {
    //      items.remove(cur_item);
    //    } else {
    //      cur_item.display();
    //    }
    //  }
    //}
  }

  void displayBackground() {
    if (levelNum == 0) {
      image(bg_freshman, 0, 0);
      pushStyle();
      rectMode(CORNER);
      fill(255, 255, 255, 100);
      rect(0, 0, width, height);
      popStyle();
    } else if (levelNum == 1) {
      image(bg_sophomore, 0, 0);
      pushStyle();
      rectMode(CORNER);
      fill(255, 255, 255, 80);
      rect(0, 0, width, height);
      popStyle();
    } else if (levelNum == 2) {
      image(bg_junior, 0, 0);
      pushStyle();
      rectMode(CORNER);
      fill(255, 255, 255, 100);
      rect(0, 0, width, height);
      popStyle();
    } else if (levelNum == 3) {
      image(bg_senior, 0, 0);
      pushStyle();
      rectMode(CORNER);
      fill(255, 255, 255, 75);
      rect(0, 0, width, height);
      popStyle();
    }
  }

  void addItems() {
    int random_number = (int)random(0, item_names.size());
    if (frameCount % 20 == 0) {
      items.add(new Item(30, item_names.get(random_number), 100, 100, frames.get(item_names.get(random_number))));
    }
  }

  void displayItems() {
    for (int i = 0; i < items.size(); i++) {
      items.get(i).display();
    }
  }

  void checkCollision() {
    for (Item item : items) {
      if (colliding(item)) {
        //kill_sound.play();
        item.posY = height+100;
        String img_name = item.img_name;
        if (posAcademic.hasValue(img_name)) {
          increaseAcademic(default_value);
        } else if (negAcademic.hasValue(img_name)) {
          decreaseAcademic(default_value);
        } else if (posHealth.hasValue(img_name)) {
          increaseHealth(default_value);
        } else if (negHealth.hasValue(img_name)) {
          decreaseHealth(default_value);
        }
      }
    }
  }

  void displayMetrics() {
    float x = width*.8;
    float y = height/2;
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(0);
    String year = academic_years[levelNum].toUpperCase();
    String displayText = "YEAR: "+year+"\nACADEMIC: "+str(academic)+"\nHEALTH: "+str(health);
    text(displayText, x, y);
  }

  boolean colliding(Item item) {
    if (item.posY + 50 >= height-player.yOffset && item.posY < height+100) {
      if (item.posX-100 <= player.position.x && player.position.x <= item.posX+100) {
        return true;
      }
    }
    return false;
  }

  boolean lost() {
    return (academic <= 0 || health <= 0);
  }

  boolean won() {
    return (academic >= 100 && health >= 100);
  }

  /**
   * Add to academic metric
   * @param int amount: the value of the increment
   *            amount should = value of the item
   */
  void increaseAcademic(int amount) {
    academic = min(100, academic+amount);
  }

  void decreaseAcademic(int amount) {
    academic = max(0, academic-amount);
  }

  void increaseHealth(int amount) {
    health = min(100, health+amount);
  }

  void decreaseHealth(int amount) {
    health = max(0, health-amount);
  }

  void loadData() {
    table0 = loadTable("../data/items-list/items-list"+str(levelNum)+".csv", "csv");
    int numRow0 = table0.getRowCount();
    for (int i=0; i<numRow0; i++) {
      TableRow row = table0.getRow(i);
      String item_name = row.getString(0);
      int item_frame = row.getInt(1);
      item_names.add(item_name);
      frames.put(item_name, item_frame);
    }

    table1 = loadTable("../data/items-list/pos_academic.csv", "csv");
    numRow1 = table1.getRowCount();
    for (int i=0; i<numRow1; i++) {
      TableRow row = table1.getRow(i);
      String item_name = row.getString(0);
      posAcademic.append(item_name);
    }

    table1 = loadTable("../data/items-list/neg_academic.csv", "csv");
    numRow1 = table1.getRowCount();
    for (int i=0; i<numRow1; i++) {
      TableRow row = table1.getRow(i);
      String item_name = row.getString(0);
      negAcademic.append(item_name);
    }

    table1 = loadTable("../data/items-list/pos_health.csv", "csv");
    numRow1 = table1.getRowCount();
    for (int i=0; i<numRow1; i++) {
      TableRow row = table1.getRow(i);
      String item_name = row.getString(0);
      posHealth.append(item_name);
    }

    table1 = loadTable("../data/items-list/neg_health.csv", "csv");
    numRow1 = table1.getRowCount();
    for (int i=0; i<numRow1; i++) {
      TableRow row = table1.getRow(i);
      String item_name = row.getString(0);
      negHealth.append(item_name);
    }
  }
}
