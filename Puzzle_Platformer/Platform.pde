



class Platform extends Substance{
  
  float width_, height_;
  float bounciness;
  Platform(PVector center_, float width_, float height_, color colour_){
    super(new PVector(0, 0), center_, height_/2, colour_);
    this.width_ = width_;
    this.height_ = height_;
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
  }
  

  
  void keep_object_above_platform(Substance some_substance){
    // this method is the definition of "you had one job"
    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + width_/2, this.coordinate.y + height_/2);
    
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
    PVector top_left = new PVector(this.coordinate.x - width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + width_/2, this.coordinate.y + height_/2);
    
    stroke(this.colour);
    fill(this.colour);
    rect(top_left.x, top_left.y, width_, height_);
    circle(top_left.x, top_left.y, 10);
    circle(bottom_right.x, bottom_right.y, 10);
    stroke(255);
    fill(255);
    
  }

}
