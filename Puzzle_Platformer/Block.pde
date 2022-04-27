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
    
    //super.keep_object_above_platform(some_substance);
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
   
    
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1) ){
      elastic_collision_2d(this, some_substance);
    }    


    return; // for better readability

  }
}
