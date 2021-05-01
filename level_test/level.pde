import java.util.ArrayList;

class Level {
  Player player = new Player();
  String[] academic_years = {"freshman", "sophomore", "junior", "senior"};
  String[] item_names = {"airplane5", "anxiety", "athletics", "campus_dirhams", "capstone", "cheating", 
    "deadline", "fatigue", "gpa", "gym_slot", "handw", "internship", 
    "jterm2", "missed", "nighter", "procrastination", "stipend2", "swipe", "symptoms"};
  Integer[] frames = {3, 3, 6, 2, 1, 1, 2, 2, 2, 2, 1, 3, 1, 2, 2, 1, 2, 2, 2};
  StringList posAcademic = new StringList();
  StringList negAcademic = new StringList();
  StringList posHealth = new StringList();
  StringList negHealth = new StringList();
  ArrayList<Item> items;
  int levelNum;
  int academic = 50;
  int health = 50;
  float xOffset = width*.75;
  int default_value = 20;
  int random_number;

  Level(int level_num) {
    levelNum = level_num;

    posAcademic.append("airplane5");
    posAcademic.append("capstone");
    posAcademic.append("gpa");
    posAcademic.append("internship");
    posAcademic.append( "jterm2");

    negAcademic.append("cheating");
    negAcademic.append("deadline");
    negAcademic.append("procrastination");

    posHealth.append("athletics");
    posHealth.append("campus_dirhams");
    posHealth.append("gym_slot");
    posHealth.append("handw");
    posHealth.append("stipend2");
    posHealth.append("swipe");

    negHealth.append("anxiety");
    negHealth.append("fatigue");
    negHealth.append("nighter");
    negHealth.append("symptoms");

    items = new ArrayList();
    items.add(new Item(30, "jterm2", 100, 100, 1));
  }

  void testLevel() {
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

  void addItems() {
    int random_number = (int)random(0, 19);
    if (frameCount % 20 == 0) {
      items.add(new Item(30, item_names[random_number], 100, 100, frames[random_number]));
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
}
