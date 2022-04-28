class Player extends Circle{
  int money;
  int invSize;
  ArrayList <Tool> inventory = new ArrayList <Tool>();
  
  boolean moving_down, moving_right, moving_left;
  float walking_speed, jump_power, terminal_velocity;
  boolean dynamic_colours;
  
  Player(PVector coordinates_, float radius_, color colour_, float walking_speed_, int inv, int m, float weight){
    super(new PVector(0, 0), coordinates_, radius_, colour_);
    invSize = inv;
    money = m;
    this.moving_down = false;
    this.moving_right = false;
    this.moving_left = false;
    this.walking_speed = walking_speed_;
    this.dynamic_colours = true;
    
    this.jump_power = 6;

    this.terminal_velocity = DEFAULT_TERMINAL_VELOCITY;
    this.bounciness = DEFAULT_PLAYER_BOUNCINESS;
    this.mass = weight;
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
    shopWindow.stroke(255);
    shopWindow.fill(255);
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
