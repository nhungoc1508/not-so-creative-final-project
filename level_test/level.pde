import java.util.ArrayList;
import java.util.Map;

class Level {
  Player player = new Player();
  String[] academic_years = {"freshman", "sophomore", "junior", "senior"};
  Table table0, table1;
  int numRow0, numRow1;
  ArrayList<String> item_names = new ArrayList<String>();
  HashMap<String, Integer> frames = new HashMap<String, Integer>();
  HashMap<String, Integer> values = new HashMap<String, Integer>();
  StringList posAcademic = new StringList();
  StringList negAcademic = new StringList();
  StringList posHealth = new StringList();
  StringList negHealth = new StringList();

  StringList positives = new StringList();
  StringList negatives = new StringList();

  HashMap<String, Integer> rare_items_count = new HashMap<String, Integer>();
  HashMap<String, Integer> rare_items_catch = new HashMap<String, Integer>();

  ArrayList<Item> items = new ArrayList<Item>();
  int levelNum;
  int academic = 50;
  int health = 50;
  float xOffset = width*.75;
  int default_value = 20;
  int random_number;
  PImage bg_freshman, bg_sophomore, bg_junior, bg_senior, bg_away1, bg_away2;
  boolean away = false;
  color nyu = color(91, 15, 141);

  Level(int level_num) {
    levelNum = level_num;
    loadData();
    //items.add(new Item(30, "jterm2", 100, 100, 1));

    bg_freshman = loadImage("../data/images/freshman.png");
    bg_freshman.resize(width, 0);
    bg_sophomore = loadImage("../data/images/sophomore.png");
    bg_sophomore.resize(0, height);
    bg_junior = loadImage("../data/images/junior.png");
    bg_junior.resize(0, height);
    bg_senior = loadImage("../data/images/senior2.png");
    bg_senior.resize(0, height);
    bg_away1 = loadImage("../data/images/nyc.png");
    bg_away1.resize(0, height);
    bg_away2 = loadImage("../data/images/nyc2.png");
    bg_away2.resize(0, height);
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
      if (!away) {
        image(bg_sophomore, 0, 0);
      } else {
        image(bg_away1, 0, 0);
      }
      pushStyle();
      rectMode(CORNER);
      fill(255, 255, 255, 80);
      rect(0, 0, width, height);
      popStyle();
    } else if (levelNum == 2) {
      if (!away) {
        image(bg_junior, 0, 0);
      } else {
        image(bg_away2, 0, 0);
      }
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
    //int random_number = (int)random(0, item_names.size());
    //if (frameCount % 20 == 0) {
    //  items.add(new Item(30, item_names.get(random_number), 100, 100, frames.get(item_names.get(random_number)), values.get(item_names.get(random_number))));
    //}
    //int rand_pos = (int)random(0, positives.size());
    if (frameCount % 60 == 0) {
      boolean item_added = false;
      while (!item_added) {
        int rand_pos = (int)random(0, positives.size());
        String item_pos = positives.get(rand_pos);
        if (!rare_items_count.containsKey(item_pos)) {
          items.add(new Item(30, item_pos, 100, 100, frames.get(item_pos), values.get(item_pos)));
          item_added = true;
        } else {
          if (rare_items_count.get(item_pos) == 3 || rare_items_catch.get(item_pos) == 1) {
            continue;
          } else {
            int prev_count = rare_items_count.get(item_pos);
            rare_items_count.put(item_pos, prev_count+1);
            items.add(new Item(30, item_pos, 100, 100, frames.get(item_pos), values.get(item_pos)));
            item_added = true;
          }
        }
      }
      //int rand_pos = (int)random(0, positives.size());
      //String item_pos = positives.get(rand_pos);
      //items.add(new Item(30, item_pos, 100, 100, frames.get(item_pos), values.get(item_pos)));
    }
    if (frameCount % 60 == 0) {
      int rand_neg = (int)random(0, negatives.size());
      String item_neg = negatives.get(rand_neg);
      items.add(new Item(30, item_neg, 100, 100, frames.get(item_neg), values.get(item_neg)));
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
        if (img_name.equals("airplane5")) {
          away = true;
        }
        if (posAcademic.hasValue(img_name)) {
          increaseAcademic(item.value);
        } else if (negAcademic.hasValue(img_name)) {
          decreaseAcademic(item.value);
        } else if (posHealth.hasValue(img_name)) {
          increaseHealth(item.value);
        } else if (negHealth.hasValue(img_name)) {
          decreaseHealth(item.value);
        }
        if (rare_items_catch.containsKey(img_name)) {
          rare_items_catch.put(img_name, 1);
        }
      }
    }
  }

  void displayMetrics() {
    pushStyle();
    float x = width*.9;
    float y = height/2;
    rectMode(CENTER);
    fill(0, 0, 0, 100);
    noStroke();
    rect(width*.915, height/2, width*.25, height);
    textSize(40);
    textAlign(CENTER, CENTER);
    fill(255);
    String year = academic_years[levelNum].toUpperCase() + "\nYEAR";
    //text(year, x, height*0.15);
    String metrics = "ACADEMIC\n"+str(academic)+"\n\nHEALTH\n"+str(health);
    String displayText = year + "\n\n" + metrics;
    text(displayText, x, y);
    popStyle();
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
      int item_value = row.getInt(2);
      item_names.add(item_name);
      frames.put(item_name, item_frame);
      values.put(item_name, item_value);
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

    for (int i=0; i<item_names.size(); i++) {
      String item = item_names.get(i);
      if (posAcademic.hasValue(item) || posHealth.hasValue(item)) {
        positives.append(item);
      } else {
        negatives.append(item);
      }
    }

    if (item_names.contains("airplane5")) {
      rare_items_count.put("airplane5", 0);
      rare_items_catch.put("airplane5", 0);
    }
    if (item_names.contains("capstone")) {
      rare_items_count.put("capstone", 0);
      rare_items_catch.put("capstone", 0);
    }
    if (item_names.contains("jterm2")) {
      rare_items_count.put("jterm2", 0);
      rare_items_catch.put("jterm2", 0);
    }
  }
}
