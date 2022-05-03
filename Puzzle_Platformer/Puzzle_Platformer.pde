import g4p_controls.*;
import java.awt.*;

int inventorySize = 8;
int money = 2000;
boolean open = false;
Shop itemShop = new Shop();

//----------------- create items-----------------
Pickaxe pick;
Pickaxe pick2;
Block dirt;
Block bouncy;
Block emreBlock;
Pend_block pe;

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
  //----------------- create items ------------------------------\\
  // Tool(price, PImage, description, uses) 
  pick = new Pickaxe(20, loadImage("images/pick.png"), "A better pickaxe.", 10);
  pick2 = new Pickaxe(10, loadImage("images/badPick.png"), "An ugly pickaxe.", 10);
  dirt = new Block(10, loadImage("images/dirt.png"), "Literally a dirt block what more can I say?", 10);
  bouncy = new Block(30, loadImage("images/diamond.png"), "BLUE BOUNCY BLOCK.", 10);
  emreBlock = new Block(90, loadImage("images/emre.png"), "EMREEEEEEEEEEEEEE.", 1);
  pe = new Pend_block(100, loadImage("images/pend.png"), "A pendulum", 1);
  //--------------------------------------------------------------\\xs

  //------------------------ add items to shop -------------------------------\\
  itemShop.addToStock(pick);
  itemShop.addToStock(pick2);
  itemShop.addToStock(dirt);
  itemShop.addToStock(bouncy);
  itemShop.addToStock(emreBlock);
  itemShop.addToStock(pe);
  //---------------------------------------------------------------------------\\
  goal_ball = new Circle(new PVector(width/2, height*0.4), 10, color(100, 100, 0));
  goal_ball.mass = 4;
  physics = new PhysicsManager();
  physics.add_circle(goal_ball);

  emre = new Player(new PVector(width/2, height*0.01), 25, color(0, 0, 0), 0.6, inventorySize, money, 3);
  emre.mass = 10;
  emre.jump_power = 15; //for debugging
  physics.add_player(emre);

  physics.add_platform(new Platform(new PVector(30, 230), 500, 20, color(255, 0, 0))); // red
  physics.add_platform(new Platform(new PVector(width/2, 400), 400, 50, color(0, 0, 0))); // black
  physics.add_platform(new Platform(new PVector(960, 475), 300, 20, color(0, 255, 0))); // green

  physics.add_domino(new Domino(new PVector(100, 100), 100));
  PlayBlock b = new PlayBlock(new PVector(width/2, height*0.5), 50, color(0));
  println(b.bounciness, emre.bounciness);
  physics.add_block(b);


  //physics.add_pendulum(new Pendulum(new PVector(130, 0), 10, 175, -PI/4, 8));
  physics.add_pendulum(new Pendulum(new PVector(450, 130), 10, 200, -PI/20, 8));

  physics.add_pendulum(new Pendulum(new PVector(130, 0), 10, 175, -PI/4, 8));

  physics.add_prison(new Prison());
  physics.display_universe();
  itemShop.stock.get(0).shopClicked();
  itemShop.update();
  noLoop();
}

void draw() {
  frameRate(60);
  //println(frameRate);
  //println(mouse.x, mouse.y);
  mouse = MouseInfo.getPointerInfo().getLocation();
  background(255);

  physics.update_universe();


  stroke(color(255, 0, 0));
  line(emre.coordinate.x, emre.coordinate.y, emre.previous_coordinate.x, emre.previous_coordinate.y);
  showInvMain(width - size * min(emre.inventory.size(), 4), 0);
  //saveFrame("export/frame####.png");
}

void mousePressed() {
  for (int i = 0; i < 4; i ++) {
    for (int j = 0; j < ceil(emre.inventory.size() / 4.0); j ++) {
      if (mouseX < width - size * i && mouseX > width - size - size * i) {
        if (mouseY > size * j && mouseY < size + size * j) {
          int index = min(emre.inventory.size(), 4) - 1 - i + 4 * j;
          emre.inventory.get(index).mainClicked();
        }
      }
    }
  }
}

void keyPressed() {
  emre.key_press_movement();
  if (key == 'p' || key == 'P') {
    itemShop.opened();
  }

  if (key == 's') {
    loop();
  }
}

void keyReleased() {
  emre.key_up_movement();
}

int tdToOd(int x, int y) {
  return(x + 4*y);
}

void iconClicked() {
  int xOffset = 0;
  int yOffset = 230;
  for (int y = 0; y < ceil(itemShop.stock.size() / 4.0); y++) {
    for (int x = 0; x < 4; x++) {
      if (mouse.x > xOffset + x * size && mouse.x < xOffset + size + x * size) {
        if (mouse.y > yOffset + y * size && mouse.y < yOffset + size + y * size) {
          itemShop.stock.get(tdToOd(x, y)).shopClicked();
        }
      }
    }
  }
}

void shopBackground() {
  shopWindow.background(255);
}

int size = 50;
void outline(int x, int y, int size, color col) {
  shopWindow.stroke(col);
  shopWindow.strokeWeight(2);
  shopWindow.rect(x, y, size, size);
}

void outlineMain(int x, int y, int size, color col) {
  stroke(col);
  strokeWeight(2);
  rect(x, y, size, size);
}

void showInvMain(int x, int y) {
  int tempX = x;
  shopWindow.stroke(255);
  shopWindow.fill(255);
  for ( int j = 0; j < emre.inventory.size(); j++) { 
    outlineMain(x, y, size, 0);
    image(emre.inventory.get(j).icon, x, y);
    x += size;
    if (j%4 == 3) {
      x = tempX;
      y += size;
    }
  }
}
