


class Player extends Circle{
  //represents a player in the physics universe
  
  int money;
  int invSize;
  ArrayList <Tool> inventory = new ArrayList <Tool>();
  
  boolean moving_down, moving_right, moving_left; // stores whether the player is moving in either of these directions
  float walking_speed, jump_power, terminal_velocity;
  boolean dynamic_colours; // feature for debugging (decides whether or not to change the color depending on if the jumping value is true or false)
  
  Tool equipped_tool; // the tool that the player has selected (from the top right corner)
  
  Player(PVector coordinates_, float radius_, color colour_, float walking_speed_, int inv, int money_, float weight){
    super(new PVector(0, 0), coordinates_, radius_, colour_);
    
    // initializing values:
    this.invSize = inv;
    this.money = money_;
    this.moving_down = false;
    this.moving_right = false;
    this.moving_left = false;
    this.walking_speed = walking_speed_;
    this.dynamic_colours = false;
    this.jump_power = 6;
    this.terminal_velocity = DEFAULT_PLAYER_HORIZONTAL_TERMINAL_VELOCITY;
    this.bounciness = DEFAULT_PLAYER_BOUNCINESS;
    this.mass = weight;
    this.equipped_tool = null;
}
  

  
  void jump(){
    // makes the player jump
    if (this.jumping) return; // if already jumping do nothing
    this.velocity.y -= this.jump_power;
    this.jumping = true;
    
  }
  void move(){
    // checking whether the player is being controlled by the user:
    if (this.moving_left) this.velocity.x = max(-this.terminal_velocity, this.velocity.x - this.walking_speed);
    if (this.moving_right) this.velocity.x = min(this.terminal_velocity, this.velocity.x + this.walking_speed);
    
    // proceed with normal velocity-position calculations:
    super.move();   

  }

  void key_press_movement(){
    // to process multiple inputs at once we have the keys control boolean values
    if (keyCode == UP) this.jump();
    //else if (keyCode == DOWN) this.moving_down = true;
    if (keyCode == RIGHT) this.moving_right = true;
    else if (keyCode == LEFT) this.moving_left = true;
  }
  

  void key_up_movement(){
    // same logic as key_press_movement
    
    //if (keyCode == UP) this.moving_up = false;
    //else if (keyCode == DOWN) this.moving_down = false;
    if (keyCode == RIGHT) this.moving_right = false;
    else if (keyCode == LEFT) this.moving_left = false;
  }
  void clicked_screen(PhysicsManager phys){
    // what to do when the user clicks on the screen
    // we check which tool the user has selected and take a specific action depending on the tool they have
    
    if (this.equipped_tool instanceof Block){
      // placing a block on the screen:
      PlayBlock some_block;
      if (this.equipped_tool instanceof BouncyBlock && this.equipped_tool.uses > 0){
        some_block = new BouncyPlayBlock(new PVector(mouseX, mouseY), 30);
        phys.add_block(some_block);
        this.equipped_tool.uses -= 1;
      }else{
        if(this.equipped_tool.uses > 0){
          some_block = new PlayBlock(new PVector(mouseX, mouseY), 30, color(0, 0, 0));
          phys.add_block(some_block);
          this.equipped_tool.uses -= 1;
        }
      }
      
    }
    
    else if (this.equipped_tool instanceof Pend_block && this.equipped_tool.uses > 0){
      phys.add_pendulum(new Pendulum(new PVector(mouseX, mouseY), 10, 100, radians(30)));
      this.equipped_tool.uses -= 1;
    }
    else if (this.equipped_tool instanceof Pickaxe && this.equipped_tool.uses > 0){
      // pickaxe destorying blocks
      ArrayList<PlayBlock> to_remove = new ArrayList<PlayBlock>();
      for (PlayBlock b: phys.blocks){ // loop through all blocks
        if (!b.indestructible){ // if indestructible we ignore
          if (circle_in_rect(b.get_top_left(), b.get_bottom_right(), new PVector(mouseX, mouseY), 0, 0) && this.equipped_tool.uses > 0){ // checking if mouse is on the block
            to_remove.add(b); // if the mouse is clicking the block, add the block to the list of blocks that are going to be deleted from the universe
            this.equipped_tool.uses -= 1;
          }
        }
      }    
      
      for (PlayBlock b: to_remove){
        if(this.equipped_tool.uses > 0 ){
          phys.blocks.remove(b); // removing the block(s) that the pickaxe has selected
          
        }
        
      }        
      
      
      // doing the exact same thing for pendulums and destroying them if needed:
      ArrayList<Pendulum> to_remove2 = new ArrayList<Pendulum>();
      for (Pendulum b: phys.pendulums){
        if (b.indestructible) continue;
  
        if (circle_in_rect(new PVector(b.pivot.coordinate.x - b.string_length, b.pivot.coordinate.y - b.string_length),
                           new PVector(b.pivot.coordinate.x + b.string_length, b.pivot.coordinate.y + b.string_length),
                           new PVector(mouseX, mouseY), 0, 0)){
          to_remove2.add(b);
          this.equipped_tool.uses -= 1;
        }
      }    
      for (Pendulum b: to_remove2){
        if(this.equipped_tool.uses > 0){
          phys.pendulums.remove(b);
        }
      }  
    }
    
  }
  
  void display(){
    // displays player
    color color_to_use;
    if (this.dynamic_colours && !this.jumping){
      color_to_use = lerpColor(this.colour, color(0, 255, 0), 1);
    }
    else{
      color_to_use = this.colour;
    }
    stroke(color_to_use);
    fill(color_to_use);
    circle(this.coordinate.x, this.coordinate.y, 2*this.radius);
  }
  
  void addItemToInv(Tool a){
    inventory.add(a);
  }
  
  void display_inventory_in_shop_window(){
    // displays the player's inventory in the shop window
    
    int x = 200;
    int y = 260;

    for( int j = 0 ; j < inventory.size(); j++){ 
      outline(x, y, size, 0);
      shopWindow.image(inventory.get(j).icon, x, y);
      x += size;
      
      if(j%4 == 3){
        x = 200;
        y += size;
      }
    }  
    
  }
 
 
  
  
  
  
}
