import g4p_controls.*;
import java.awt.*;


int inventorySize = 4;
int money = 100;
boolean open = false;
Shop itemShop = new Shop();

//----------------- create items-----------------
Pickaxe pick;
Pickaxe pick2;
Block dirt;
Block diamond;

//-----------------------------------------------


//-------------- emre stuff idk------------------
Player emre;
PhysicsManager physics;
Prison my_prison;
ArrayList<Pendulum> pendulums;
Platform p, p2, p3;
Pendulum mp1, mp2;
Circle circle;
PlayBlock b;

//-----------------------------------------------

Point mouse;

void setup() {
  fill(0);

  size(1200, 500);
  createGUI();
  //shopWindow.setVisible(open);
  //----------------- create items ------------------------------\\
  // Tool(price, PImage, description, uses) 
  pick = new Pickaxe(20, loadImage("images/pick.png"), "A sexy pickaxe aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 10);
  pick2 = new Pickaxe(10, loadImage("images/badPick.png"), "An ugly pickaxe aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 10);
  dirt = new Block(10, loadImage("images/dirt.png"), "Literally a dirt block what more can I say?", 10);
  diamond = new Block(30, loadImage("images/diamond.png"), "DIAMOND AAAAAAA", 10);
  
  //--------------------------------------------------------------\\
  
  b = new PlayBlock(new PVector(100, 300), 50, color(0));
  //------------------------ add items to shop -------------------------------\\
  itemShop.addToStock(pick);
  itemShop.addToStock(pick2);
  itemShop.addToStock(dirt);
  itemShop.addToStock(diamond);
  //---------------------------------------------------------------------------\\

  
  
  //PVector center_, float height_, float length_, color colour_
  pendulums = new ArrayList<Pendulum>();
  int n = 0;
  for (int i = 0; i < n; i++){
    pendulums.add(new Pendulum(new PVector(i * width/n, 100), 5, ((i + 1) * 10), ((i+1)*n/2)%n, color(0,0,0)));
  }
  
  mp1 = new Pendulum(new PVector(width*0.4, 100), 10, 150, PI/20, 10);
  mp2 = new Pendulum(new PVector(width*0.6, 100), 10, 225, PI/20, 10);
  mp2.current_theta = -PI/14;
  

  
  //circle = new Circle(new PVector(0,_, PVector coordinates_, float radius_, color colour_);
  p = new Platform(new PVector(width*0.1, 300), 100, 20, color(0, 0, 0));
  p2 = new Platform(new PVector(width*0.3, 350), 1300, 20, color(0, 0, 0));
  p3 = new Platform(new PVector(width*0.3, 200), 100, 20, color(0, 0, 0));

  my_prison = new Prison();
  emre = new Player(new PVector(width*0.7, 90 + mp2.string_length), 25, color(0, 0, 0), 0.6, inventorySize, money);
  //emre.velocity = new PVector(70, 0);
  
  physics = new PhysicsManager();
  physics.add_obj(emre);
  physics.add_obj(p);
  physics.add_obj(b);
  
  itemShop.update();
}
void draw() {
  mouse = MouseInfo.getPointerInfo().getLocation();
  //println(mouse.x, mouse.y);
  background(255);
  physics.apply_gravity_to_universe();
  physics.apply_friction_to_universe();


  emre.move();
  p.move();
  
  b.keep_object_above_platform(emre);
  b.move();
  b.display();
  
  p.keep_object_above_platform(emre);
  p2.keep_object_above_platform(emre);
  p3.keep_object_above_platform(emre);
  
  p.keep_object_above_platform(b);
  p2.keep_object_above_platform(b);
  p3.keep_object_above_platform(b);

  my_prison.imprison(emre);
  my_prison.imprison(b);

  my_prison.imprison(p);

  emre.display();
  p.display();
  p2.display();
  p3.display();

  mp1.swing();
  mp1.collide(emre);
  mp1.display();
  mp1.draw_velocity();
  
  
  mp2.swing();
  mp2.collide(emre);
  mp2.display();
  mp2.draw_velocity();
  for (int i = 0; i < pendulums.size(); i++){
    pendulums.get(i).swing();
    pendulums.get(i).collide(emre);
    pendulums.get(i).display();
  }
  
}

void keyPressed() {
  emre.key_press_movement();
  if(key == 'p'){
    itemShop.opened();
  }
}

void keyReleased() {
  emre.key_up_movement();
}

// raw top left of gui : (0, 230), bottom right : (400, 730)
// icons start at top left : (0, 228), stop at bottom right : (200, 728)

int tdToOd(int x, int y){
  return(x + 4*y);
}



void iconClicked(){
  int xOffset = 0;
  int yOffset = 230;
  for(int y = 0; y < ceil(itemShop.stock.size() / 4.0); y++){
    for(int x = 0; x < 4; x++){
      if(mouse.x > xOffset + x * 50 && mouse.x < xOffset + 50 + x * 50){
        if(mouse.y > yOffset + y*50 && mouse.y < yOffset + 50 + y * 50){
          itemShop.stock.get(tdToOd(x, y)).clicked();
          
        }
      }
    }
  }
}

void shopBackground(){
  shopWindow.background(255);
}

int size = 50;
void outline(int x, int y, int size, color col){
  shopWindow.stroke(col);
  shopWindow.strokeWeight(2);
  shopWindow.rect(x, y, size, size);
}
