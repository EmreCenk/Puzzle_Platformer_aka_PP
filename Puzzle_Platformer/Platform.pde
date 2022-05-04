



class Platform extends Substance{
  
  float width_, height_;
  float bounciness;
  Platform(PVector center_, float width_, float height_, color colour_){
    super(new PVector(0, 0), center_, height_/2, colour_);
    this.width_ = width_;
    this.height_ = height_;
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
    this.effected_by_gravity = false; // by default platforms are immune to gravity
  }
  

  
  void keep_object_above_platform(Substance some_substance){

    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);
    if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
      //return;
    }
    
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
    


      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      }
      else{
        some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }

      some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = false;

    }
    return; // for better readability
  }
  
  void display(){
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    //PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    
    stroke(color(255, 0, 0));
    strokeWeight(2);
    fill(this.colour);
    rect(top_left.x, top_left.y, this.width_, height_);
    //circle(top_left.x, top_left.y, 10);
    //circle(bottom_right.x, bottom_right.y, 10);
    stroke(255);
    fill(255);
    
  }

}

class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
    this.effected_by_gravity = true;
    this.bounciness = DEFAULT_PLAYBLOCK_BOUNCE;
  }
  
  void player_activated(Substance pl){
  // specific types of blocks will overwrite this
  }
  void keep_object_above_platform(Substance some_substance){

    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);

    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)) 
      elastic_collision_2d(this, some_substance);
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
      //println("inside", frameCount);
      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      }
      else{
        some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }

      some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = false;
      //elastic_collision_2d(this, some_substance);
    }
    
    if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
    }
    return; // for better readability
  }
  
  

}
  
