

class LandingPage{
  
  PVector but1_center, but2_center;
  boolean started_game;
  LandingPage(){
    this.but1_center = new PVector(width/2, height*0.3);
    this.but2_center = new PVector(width/2, height*0.7);
    this.started_game = false;
  }
  
  PVector get_top_left(PVector center, float height_, float width_){ // gets top left corner
    return new PVector(center.x - width_/2, center.y - height_/2);
  }
  PVector get_bottom_right(PVector center, float height_, float width_){ //gets top right corner
    return new PVector(center.x + width_/2, center.y + height_/2);
  }
  
  void draw_buttons(){
    float w = 0.5;
    float k = 0.2;
    fill(color(255, 255, 255));
    rect(this.but1_center.x - width*w*0.5, this.but1_center.y, width*w, height*k);
    rect(this.but2_center.x - width*w*0.5, this.but2_center.y, width*w, height*k);
    
    
    fill(color(0, 0, 0));
    textAlign(CENTER, TOP);
    textSize(32);
    text("Sandbox Mode", this.but1_center.x, this.but1_center.y + height*k/4);
    text("Play a Level", this.but2_center.x, this.but2_center.y + height*k/4);
  }

}
