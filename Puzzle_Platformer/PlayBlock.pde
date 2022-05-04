class PlayBlock extends Platform {
  
  float price;
  PlayBlock (PVector center_, float height_, color colour_){
    super(center_, height_, height_, colour_); 
    this.effected_by_gravity = true;
    this.bounciness = DEFAULT_PLAYBLOCK_BOUNCE;
  }
  
  void substance_collided(Substance pl){
    // any additional thing to do when a substance collides with the block
    // every specific type of block will overwrite this. 
    // for instance, the bouncy block launches the substance upwards when they collide
  }
  void keep_object_above_platform(Substance some_substance){

    // lifts the substance
    PVector top_left = new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
    PVector bottom_right = new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
    
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);

    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)){
      elastic_collision_2d(this, some_substance);
    }
    if (!outside_y){
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
    }
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ){

      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y) ){
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      }
      else{
        some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }

      some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = false;
      this.substance_collided(some_substance);

    }
    

    
    this.velocity.x = sign(this.velocity.x) * min(abs(this.velocity.x), BLOCK_TERMINAL_VELOCITY);
    this.velocity.y = sign(this.velocity.y) * min(abs(this.velocity.y), BLOCK_TERMINAL_VELOCITY);
    
    return; // for better readability
  }

}

class BouncyPlayBlock extends PlayBlock{
  float bounce_power;

  BouncyPlayBlock (PVector center_, float height_){
    super(center_, height_, color(0,206,209));
    this.bounce_power = 10;

  }
  void substance_collided(Substance pl){
    println("boo", frameCount);
    pl.velocity.y = min(DEFAULT_PLAYER_VERTICAL_TERMINAL_VELOCITY, pl.velocity.y - this.bounce_power);
    println(pl, pl.velocity);
  }
}
  
