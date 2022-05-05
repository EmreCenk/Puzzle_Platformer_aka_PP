import g4p_controls.*;
import java.awt.*;


int inventorySize = 8;
int money = 80;
boolean open = false;
Shop itemShop = new Shop();

//----------------- create items-----------------
Pickaxe pick;
Pickaxe pick2;
Block normal_block;
Block bouncy;
Block emreBlock;
Pend_block pe;
Robot robot;
//-----------------------------------------------

//-------------- emre stuff idk------------------
Player emre;
PhysicsManager physics;
Prison my_prison;
ArrayList<Pendulum> pendulums;
Platform p, p2, p3;
Pendulum mp1, mp2;
Circle circle;
BouncyPlayBlock b;
Circle goal_ball;

//-----------------------------------------------

Point mouse; // from library

//landing page:
LandingPage landing;

void setup() {
  fill(0);
  size(1200, 500);
  
  //initializing golden ball
  goal_ball = new Circle(new PVector(width*0.1, height*0.4), 10, color(100, 100, 0));
  goal_ball.mass = 4;
  physics = new PhysicsManager();
  physics.add_circle(goal_ball);


  // initializing player
  emre = new Player(new PVector(width/2, height*0.01), 25, color(0, 0, 0), 0.6, inventorySize, money, 3);
  emre.mass = 10;
  emre.jump_power = 10;
  physics.add_player(emre);

  // creating platforms:
  physics.add_platform(new Platform(new PVector(30, 230), 500, 20, color(255, 0, 0))); // red
  physics.add_platform(new Platform(new PVector(960, 475), 300, 20, color(0, 255, 0))); // green

  //creating a domino:
  physics.add_domino(new Domino(new PVector(100, 100), 100));
  
  //creating blocks:
  b = new BouncyPlayBlock(new PVector(width/2, height*0.5), 50);
  b.velocity = new PVector(0, 0);
  physics.add_block(b);

  
  //creating pendulums:
  physics.add_pendulum(new Pendulum(new PVector(450, 130), 10, 200, -PI/20, 8));
  physics.add_pendulum(new Pendulum(new PVector(130, 0), 10, 175, -PI/4, 8));


  createGUI();
  //----------------- create items ------------------------------\\
  // Tool(price, PImage, description, uses) 
  pick = new Pickaxe();
  normal_block = new NormalBlock();
  bouncy = new BouncyBlock();
  pe = new Pend_block();
  //--------------------------------------------------------------\\xs

  //------------------------ add items to shop -------------------------------\\
  itemShop.addToStock(pick);
  itemShop.addToStock(normal_block);
  itemShop.addToStock(bouncy);
  itemShop.addToStock(pe);
  //---------------------------------------------------------------------------\\

  physics.add_prison(new Prison());


  mouse.x = 0;
  itemShop.stock.get(0).shopClicked();



  itemShop.update();
  noLoop();
  landing = new LandingPage();
  landing.draw_buttons();
}

void draw() {
  if (!landing.started_game) return;
  frameRate(60);
  background(255);
  mouse = MouseInfo.getPointerInfo().getLocation(); // update the location of the mouse
  physics.update_universe(); // increment the universe by 1 timestamp
  showInvMain(width - size * min(emre.inventory.size(), 4), 0); // show inventory
}

void mousePressed() {
   
  if (!landing.started_game){
    landing.check_clicked();
    return;
  }
  
  boolean something_clicked = false;
  for (int i = 0; i < 4; i ++) {
    for (int j = 0; j < ceil(emre.inventory.size() / 4.0); j ++) {
      if (mouseX < width - size * i && mouseX > width - size - size * i && mouseY > size * j && mouseY < size + size * j) {
        int index = min(emre.inventory.size(), 4) - 1 - i + 4 * j;
        try {
          emre.inventory.get(index).mainClicked();
          something_clicked = true;
        }
        catch (Exception E) {
          // this error only happens when you click something that hasn't been bought yet, so we're bing chilling
          println("some index error happened in mousePressed, but this is fine");
          continue; //this is fine
        }
      }
    }
  }
  if (!something_clicked)
    emre.clicked_screen(physics);
}
boolean calibrated = false;

void calibrate() throws AWTException {
  // for some reason our gui doesn't load until an icon is clicked
  // to bypass this, we will literally drag the mouse and click an icon manually
  if (!calibrated) {
    robot = new Robot();
    robot.mouseMove(20, 273); //drag mouse to icon
    robot.mousePress(java.awt.event.InputEvent.BUTTON2_MASK); //click icon
    robot.mouseRelease(java.awt.event.InputEvent.BUTTON2_MASK); // release icon
    calibrated = true; // we only have to do this the first time, after that you don't need to repeat it
  }
}

void keyPressed() {
  emre.key_press_movement(); // what the player should do when a key is pressed
  
  if (key == 'p' || key == 'P') {
    // opening shop
    itemShop.opened();
     
    //calibrating shop window:
    try{calibrate();}
    catch (Exception E){println("oof: ", E);}
  }

}

void keyReleased() {
  emre.key_up_movement(); // what the player should do when a key is released
}

int tdToOd(int x, int y) {
  return(x + 4*y); // utility function
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
  //draws outline for an icon in the shop window
  shopWindow.stroke(col);
  shopWindow.strokeWeight(2);
  shopWindow.rect(x, y, size, size);
}

void outlineMain(int x, int y, int size, color col) {
  //draws icon on the game window
  stroke(col);
  strokeWeight(2);
  rect(x, y, size, size);
}

void showInvMain(int x, int y) {// displays the inventory to the main sketch window
  
  if(!(emre.equipped_tool == null)){
    fill(0);
    textSize(20);
    text("Uses: " + emre.equipped_tool.uses, width - size * min(emre.inventory.size(), 4) - 100, 30);
  }
  fill(255);
 
  int tempX = x;
  
  for( int i = 0; i < emre.inventory.size(); i++){
    if(emre.inventory.get(i).uses == 0){
      emre.inventory.remove(emre.inventory.get(i));
    }
  }


  for ( int j = 0; j < emre.inventory.size(); j++) {
    
    if (emre.inventory.get(j).mainSelected) {
      outlineMain(x, y, size, color(255, 0, 0));
    } else {
      outlineMain(x, y, size, 0);
    }
    image(emre.inventory.get(j).icon, x, y);
    x += size;
    if (j%4 == 3) {
      x = tempX;
      y += size;
    }
  }
}
