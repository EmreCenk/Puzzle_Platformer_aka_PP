import g4p_controls.*;
import java.awt.*;


int inventorySize = 8;
int money = 200;
boolean open = false;
Shop itemShop = new Shop();

//----------------- create items-----------------
Pickaxe pick;
Pickaxe pick2;
Block dirt;
Block bouncy;
Block emreBlock;

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
Circle goal_ball;

//-----------------------------------------------

Point mouse;

void setup() {
  fill(0);

  size(1200, 500);
  createGUI();
  //shopWindow.setVisible(open);
  //----------------- create items ------------------------------\\
  // Tool(price, PImage, description, uses) 
  pick = new Pickaxe(20, loadImage("images/pick.png"), "A better pickaxe.", 10);
  pick2 = new Pickaxe(10, loadImage("images/badPick.png"), "An ugly pickaxe.", 10);
  dirt = new Block(10, loadImage("images/dirt.png"), "Literally a dirt block what more can I say?", 10);
  bouncy = new Block(30, loadImage("images/diamond.png"), "BLUE BOUNCY BLOCK.", 10);
  emreBlock = new Block(90, loadImage("images/emre.png"), "EMREEEEEEEEEEEEEE.", 1);
  
  //--------------------------------------------------------------\\


  //------------------------ add items to shop -------------------------------\\
  itemShop.addToStock(pick);
  itemShop.addToStock(pick2);
  itemShop.addToStock(dirt);
  itemShop.addToStock(bouncy);
  itemShop.addToStock(emreBlock);
  //---------------------------------------------------------------------------\\


  //mp1 = new Pendulum(new PVector(width*0.4, 100), 10, 150, PI/20, 10);
  //p2 = new Platform(new PVector(width*0.3, 350), 1300, 20, color(0, 0, 0));
  emre = new Player(new PVector(130, 170), 25, color(0, 0, 0), 0.6, inventorySize, money, 3);
  emre.mass = 5;
  goal_ball = new Circle(new PVector(0,0), new PVector(230, 185), 10, color(100, 100, 0));
  goal_ball.mass = 4;

  my_prison = new Prison();
  //emre.velocity = new PVector(70, 0);
  //b = new PlayBlock(new PVector(100, 300), 50, color(0));
  emre.mass = 3;
  goal_ball.mass = 4;
  physics = new PhysicsManager();
  physics.add_circle(goal_ball);
  physics.add_player(emre);
  physics.add_platform(new Platform(new PVector(30, 230), 500, 20, color(255,0,0))); // red
  physics.add_platform(new Platform(new PVector(530, 430), 400, 50, color(0,0,0))); // black
  physics.add_platform(new Platform(new PVector(960, 450), 300, 20, color(0,255,0))); // green
  
  
  physics.add_pendulum(new Pendulum(new PVector(130, 0), 10, 175, -PI/4, 8));
  
  PlayBlock b = new PlayBlock(new PVector(570, 380), 50, color(0));
  physics.add_block(b);
  
  b = new PlayBlock(new PVector(630, 380), 50, color(0));
  physics.add_block(b);

  physics.add_prison(my_prison);
  itemShop.update();
  physics.display_universe();
  itemShop.stock.get(0).clicked();
  noLoop();
}

void draw() {
  //frameRate(1);
  //println(frameRate);
  //println(mouse.x, mouse.y);
  mouse = MouseInfo.getPointerInfo().getLocation();
  background(255);
  
  physics.update_universe();
  physics.apply_friction_to_universe();
  physics.apply_gravity_to_universe();
  physics.update_positions_in_universe();
  physics.apply_collision_in_universe();
  physics.display_universe();
  
}

void keyPressed() {
  emre.key_press_movement();
  if (key == 'p' || key == 'P') {
    itemShop.opened();
  }
  
  if (key == 's'){
    loop();
  }
}

void keyReleased() {
  emre.key_up_movement();
}

// raw top left of gui : (0, 230), bottom right : (400, 730)
// icons start at top left : (0, 228), stop at bottom right : (200, 728)

int tdToOd(int x, int y) {
  return(x + 4*y);
}

void iconClicked() {
  int xOffset = 0;
  int yOffset = 230;
  for (int y = 0; y < ceil(itemShop.stock.size() / 4.0); y++) {
    for (int x = 0; x < 4; x++) {
      if (mouse.x > xOffset + x * 50 && mouse.x < xOffset + 50 + x * 50) {
        if (mouse.y > yOffset + y*50 && mouse.y < yOffset + 50 + y * 50) {
          itemShop.stock.get(tdToOd(x, y)).clicked();
        }
      }
    }
  }
  
}

void shopBackground() {
  shopWindow.loop();
  shopWindow.background(255);
}

int size = 50;
void outline(int x, int y, int size, color col) {
  shopWindow.stroke(col);
  shopWindow.strokeWeight(2);
  shopWindow.rect(x, y, size, size);
}
