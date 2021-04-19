Item item;

void setup() {
  size(1024, 768);
  item = new Item(25, "gpa.png", 70, 56, 1);
}

void draw() {
  background(255);
  item.display();
}
