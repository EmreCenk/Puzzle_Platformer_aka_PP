class Player extends Circle{
  int money;
  int invSize;
  ArrayList <Tool> inventory = new ArrayList <Tool>();
  
  boolean moving_down, moving_right, moving_left;
  float walking_speed, jump_power, terminal_velocity;
  boolean dynamic_colours;
  
  Tool equipped_tool;
  
  Player(PVector coordinates_, float radius_, color colour_, float walking_speed_, int inv, int m, float weight){
    super(new PVector(0, 0), coordinates_, radius_, colour_);
    invSize = inv;
    money = m;
    this.moving_down = false;
    this.moving_right = false;
    this.moving_left = false;
    this.walking_speed = walking_speed_;
    this.dynamic_colours = false;
    
    this.jump_power = 6;

    this.terminal_velocity = DEFAULT_TERMINAL_VELOCITY;
    this.bounciness = DEFAULT_PLAYER_BOUNCINESS;
    this.mass = weight;
    
    this.equipped_tool = null;
}
  

  
  void jump(){
    if (this.jumping) return;
    this.velocity.y -= this.jump_power;
    this.jumping = true;
    
  }
  void move(){
    if (this.moving_left) this.velocity.x = max(-this.terminal_velocity, this.velocity.x - this.walking_speed);
    if (this.moving_right) this.velocity.x = min(this.terminal_velocity, this.velocity.x + this.walking_speed);
    
    super.move();    

    //if (this.moving_left) this.velocity.x += this.walking_speed;
    //if (this.moving_right) this.velocity.x -= this.walking_speed;
    

  }
  //void check_player_movement(){
    //if (this.moving_up) this.move_up();
    //if (this.moving_down) this.move_down();
    //if (this.moving_right) this.walk_right();
    //if (this.moving_left) this.walk_left();
  //}
  
  void key_press_movement(){
    if (keyCode == UP) this.jump();
    //else if (keyCode == DOWN) this.moving_down = true;
    if (keyCode == RIGHT) this.moving_right = true;
    else if (keyCode == LEFT) this.moving_left = true;
  }
  

  void key_up_movement(){
    //if (keyCode == UP) this.moving_up = false;
    //else if (keyCode == DOWN) this.moving_down = false;
    if (keyCode == RIGHT) this.moving_right = false;
    else if (keyCode == LEFT) this.moving_left = false;
  }
  
  void clicked_screen(PhysicsManager phys){
    if (this.equipped_tool instanceof Block){
      phys.add_block(new PlayBlock(new PVector(mouseX, mouseY), 30, color(0, 0, 0)));
    }
    else if (this.equipped_tool instanceof Pend_block){
      phys.add_pendulum(new Pendulum(new PVector(mouseX, mouseY), 10, 30, 30));
    }
    else if (this.equipped_tool instanceof Pickaxe){
      ArrayList<PlayBlock> to_remove = new ArrayList<PlayBlock>();
      for (PlayBlock b: phys.blocks){
        if (circle_in_rect(b.get_top_left(), b.get_bottom_right(), new PVector(mouseX, mouseY), 0, 0)){
          to_remove.add(b);
        }
      }    
      for (PlayBlock b: to_remove){
        phys.blocks.remove(b);
      }        
    }
  
  }
  
  void display(){
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
  
  void displayInventory(){
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
