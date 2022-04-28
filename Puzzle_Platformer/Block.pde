class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
    this.effected_by_gravity = true;
  }
  
  void collide(Substance some_substance){
    // NEW FEATURE: BLOCKS ARE MADE OUT OF SOLID OOBLECK:
    // WHEN YOU RUN INTO IT FAST, IT ACTS LIKE A LIQUID
    // WHEN YOU RUN INTO IT SLOW, YOU CAN ENTER IT. (not a bug, a feature)
   
    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    boolean valid = circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1.01);
    if (!valid) return;
    
    //println(frameCount);
    elastic_collision_2d(this, some_substance);
    //println(some_substance.velocity);
    //println(this.velocity);
    //println();
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);

    if (!outside_y){
    //if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
    }
    
    if (valid){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
   

      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      }
      else{
        //println(some_substance);
        //some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }
      
      //some_substance.velocity.mult(sqrt(bounciness * some_substance.bounciness));
      //some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = this.jumping;
    }
    return; // for better readability

    //PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    //PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    //if (!circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)) return;

    
    // now they can collide safely without being inside each other
    //elastic_collision_2d(some_substance, this);
    

  }
  
  //void display(){

    
    //color color_to_use;
    //if (!this.jumping){
    //  color_to_use = lerpColor(this.colour, color(0, 255, 0), 1);
    //}
    //else{
    //  color_to_use = this.colour;
    //}
    //PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    //PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    
    //stroke(color_to_use);
    //fill(color_to_use);
    //rect(top_left.x, top_left.y, this.width_, height_);


  //}
}
