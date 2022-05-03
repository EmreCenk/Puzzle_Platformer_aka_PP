class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
    this.effected_by_gravity = true;
    this.bounciness = DEFAULT_PLAYBLOCK_BOUNCE;

    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);

    this.lines.add(new Line(new PVector(top_left.x, top_left.y), new PVector(top_left.x, bottom_right.y))); // top
    this.lines.add(new Line(new PVector(top_left.x, top_left.y), new PVector(bottom_right.x, top_left.y))); // left
    this.lines.add(new Line(new PVector(bottom_right.x, bottom_right.y), new PVector(bottom_right.x, top_left.y))); // right
    this.lines.add(new Line(new PVector(bottom_right.x, bottom_right.y), new PVector(top_left.x, bottom_right.y))); // bottom
    
  }
  
  void collide(Substance some_substance){

    
    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    boolean valid = circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.width_, 1.01);
    if (!valid) return;
    
    //println(frameCount);
    elastic_collision_2d(this, some_substance);
    //println(some_substance.velocity);
    //println(this.velocity);
    //println();
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.width_ * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.width_ * 0.5);

    if (!outside_y){
    //if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.width_) some_substance.coordinate.x = top_left.x - some_substance.width_;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.width_) some_substance.coordinate.x = bottom_right.x + some_substance.width_;
    }
    
    if (valid){
      // could be more efficient if we only checked if they are parralel but that is too much typing lol
   

      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.width_;
      }
      else{
        //println(some_substance);
        //some_substance.coordinate.y = bottom_right.y + some_substance.width_;
      }
      
      //some_substance.velocity.mult(sqrt(bounciness * some_substance.bounciness));
      //some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = this.jumping;
    }
    return; // for better readability

  }
 
  void display(){
  
    super.display();
    stroke(color(100, 100, 100));
    strokeWeight(3);
    for (int i = 0; i<this.lines.size(); i++){
      line(this.lines.get(i).p1.x, this.lines.get(i).p1.y, this.lines.get(i).p2.x, this.lines.get(i).p2.y);
    }
  }
}
