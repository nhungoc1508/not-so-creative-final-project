import java.util.ArrayList;

ArrayList<Item> items = new ArrayList<Item>();
int i = 1;
int random_number;

String[] item_names = {"airplane5.png", "internship.png", "jterm2.png", "stipend2.png", "gym_slot.png", "campus_dirhams.png", "athletics.png", "swipe.png",
                       "anxiety.png", "handw.png", "nighter.png"}; 

void setup() {
  fullScreen();
  //size(1024, 768);
  items.add(new Item(30, "jterm2.png", 100, 100, 1));
}

void draw() {
  background(255);
  
  if (frameCount % 20 == 0) {
    random_number = (int)random(0, 11);
    if (random_number == 0){
      items.add(new Item(30, item_names[random_number], 100, 100, 3));
      i++;
    }
    if (random_number == 1){
      items.add(new Item(30, item_names[random_number], 100, 100, 3));
      i++;
    }
    if (random_number == 2){
      items.add(new Item(30, item_names[random_number], 100, 100, 1));
      i++;
    }
    if (random_number == 3){
      items.add(new Item(30, item_names[random_number], 100, 100, 2));
      i++;
    }
    if (random_number == 4){
      items.add(new Item(30, item_names[random_number], 100, 100, 2));
      i++;
    }
    if (random_number == 5){
      items.add(new Item(30, item_names[random_number], 100, 100, 2));
      i++;
    }
    if (random_number == 6){
      items.add(new Item(30, item_names[random_number], 100, 100, 6));
      i++;
    }
    if (random_number == 7){
      items.add(new Item(30, item_names[random_number], 100, 100, 2));
      i++;
    }
    if (random_number == 8){
      items.add(new Item(30, item_names[random_number], 100, 100, 3));
      i++;
    }
    if (random_number == 9){
      items.add(new Item(30, item_names[random_number], 100, 100, 1));
      i++;
    }
    if (random_number == 10){
      items.add(new Item(30, item_names[random_number], 100, 100, 2));
      i++;
    }
  }
  
  
  for (int j = 0; j < i; j++){
    items.get(j).display();
  }
}
