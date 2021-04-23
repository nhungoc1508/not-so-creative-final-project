import java.util.ArrayList;

class Level {
  Player player = new Player();
  /**
   * LIST OF ITEMS:
   * Should be a list of Item objects
   * ArrayDeque<> is currently a top choice because items should be poped out of
   * array in the order they were first added.
   * https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayDeque.html
   * 
   */

  String[] item_names = {"airplane5.png", "internship.png", "jterm2.png", "stipend2.png", "gym_slot.png", "campus_dirhams.png", "athletics.png", "swipe.png", 
    "anxiety.png", "handw.png", "nighter.png"};
  Integer[] frames = {3, 3, 1, 2, 2, 2, 6, 2, 3, 1, 2};
  ArrayList<Item> items;

  int levelNum;
  int academic = 50;
  int health = 50;
  float xOffset = width*.75;

  int random_number;

  Level(int level_num) {
    levelNum = level_num;
    items = new ArrayList();
    items.add(new Item(30, "jterm2.png", 100, 100, 1));
  }

  void testLevel() {
    player.display();
    int random_number = (int)random(0, 11);
    if (frameCount % 20 == 0) {
      items.add(new Item(30, item_names[random_number], 100, 100, frames[random_number]));
    }

    for (int i = 0; i < items.size(); i++) {
      items.get(i).display();
    }
    
    checkCollision();

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

  void checkCollision() {
    for (Item item : items) {
      if (colliding(item)) {
        item.posY = height+100;
      }
    }
  }

  boolean colliding(Item item) {
    if (item.posY + 50 >= height - player.yOffset) {
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
    academic += amount;
  }

  void decreaseAcademic(int amount) {
    academic -= amount;
  }

  void increaseHealth(int amount) {
    health += amount;
  }

  void decreaseHealth(int amount) {
    health -= amount;
  }
}
