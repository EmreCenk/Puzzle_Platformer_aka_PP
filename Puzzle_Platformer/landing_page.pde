

class LandingPage{
  
  PVector but1_center, but2_center;
  boolean started_game;
  String game_mode;
  float w, k;
  LandingPage(){
    this.but1_center = new PVector(width/2, height*0.3);
    this.but2_center = new PVector(width/2, height*0.7);
    this.started_game = false;
    w = 0.5 * width;
    k = 0.2 * height;
  }
  
  PVector get_top_left(PVector center){ // gets top left corner
    return new PVector(center.x - w/2, center.y - k/2);
  }
  PVector get_bottom_right(PVector center){ //gets top right corner
    return new PVector(center.x + w/2, center.y + k/2);
  }
  
  void draw_buttons(){

    fill(color(255, 255, 255));
    PVector a = this.get_top_left(this.but1_center);
    rect(a.x, a.y, w, k);
    
    PVector b = this.get_top_left(this.but2_center);
    rect(b.x, b.y, w, k);
    
    
    fill(color(0, 0, 0));
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Sandbox Mode", this.but1_center.x, this.but1_center.y);
    text("Play a Level", this.but2_center.x, this.but2_center.y);
  }
  
  void check_clicked(){

    if (circle_in_rect(this.get_top_left(this.but1_center), this.get_bottom_right(this.but1_center), new PVector(mouseX, mouseY), 0, 0)){
      loop();
      this.started_game = true;
      emre.money = 999999; // infinite money
      for(int i = 0; i < itemShop.stock.size(); i ++){
        itemShop.stock.get(i).uses = 1000000000; // infinite uses
      }
      
      set_up_gui_values();
      physics = new PhysicsManager(); // empty the universe
    }
    else if (circle_in_rect(this.get_top_left(this.but2_center), this.get_bottom_right(this.but2_center), new PVector(mouseX, mouseY), 0, 0)){
      loop();
      this.started_game = true;
      set_up_gui_values();
    }
  }

}
