// import java.util.ArrayDeque;

class Level {
  // Player player = new Player();
  /**
   * LIST OF ITEMS:
   * Should be a list of Item objects
   * ArrayDeque<> is currently a top choice because items should be poped out of
   * array in the order they were first added.
   * https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayDeque.html
   * 
   */
   // 

  int levelNum;
  int academic = 50;
  int health = 50;

  Level(int level_num) {
    levelNum = level_num;
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
