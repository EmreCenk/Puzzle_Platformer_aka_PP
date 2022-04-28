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
    if (!circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)) return;
    elastic_collision_2d(this, some_substance);
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);

    if (!outside_y){
    //if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
    }
    
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
   

      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      }
      else{
        println(some_substance);
        //some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }

      some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = false;
    }
    return; // for better readability

    //PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    //PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    //if (!circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)) return;

    
    // now they can collide safely without being inside each other
    //elastic_collision_2d(some_substance, this);
    
  

  }
}
