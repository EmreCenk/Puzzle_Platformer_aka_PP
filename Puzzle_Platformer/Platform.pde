



class Platform{
  
  PVector top_left, bottom_right;
  float width_, height_;
  color colour;
  float bounciness;
  Platform(PVector center_, float width_, float height_, color colour_){
    this.colour = colour_;
    this.width_ = width_;
    this.height_ = height_;
    this.top_left = new PVector(center_.x - width_/2, center_.y - height_/2);
    this.bottom_right = new PVector(center_.x + width_/2, center_.y + height_/2);
    this.bounciness = DEFAULT_BOUNCE;
  }
  

  
  void do_job(Substance some_substance, PhysicsManager phys){
    // this method is the definition of "you had one job"
    // lifts the substance
    
    if (circle_in_rect(this.top_left, this.bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
      
      if (abs(some_substance.coordinate.y - this.top_left.y) < abs(some_substance.coordinate.y - this.bottom_right.y) ){
        some_substance.coordinate.y = this.top_left.y - some_substance.radius;
      }
      else{
        some_substance.coordinate.y = this.bottom_right.y + some_substance.radius;
      }
      some_substance.velocity.mult(-(this.bounciness + some_substance.bounciness) / 2);      
      some_substance.jumping = false;

    }
    return; // for better readability
  }
  
  void display(){
    stroke(this.colour);
    fill(this.colour);
    rect(this.top_left.x, this.top_left.y, this.width_, this.height_);
    circle(this.top_left.x, this.top_left.y, 10);
    circle(this.bottom_right.x, this.bottom_right.y, 10);
  }

}
