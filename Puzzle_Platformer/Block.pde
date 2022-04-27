class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
 
  }
  void keep_object_above_platform(Substance obj){
    PVector top_left = new PVector(this.coordinate.x - width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + width_/2, this.coordinate.y + height_/2);
    
    if (circle_in_rect(top_left, bottom_right, obj.coordinate, obj.radius, 1)){
      elastic_collision_2d(obj, this);
      println("yes");
    }
  }
}
