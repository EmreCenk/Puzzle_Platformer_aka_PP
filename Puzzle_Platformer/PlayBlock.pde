class PlayBlock extends Platform {
  // represents a block in our universe
  
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
  
  void keep_object_outside(Substance some_substance){
    // very similar to Platform.keep_object_outside
    // differences are noted in the comments below
    
    PVector top_left = this.get_top_left();
    PVector bottom_right = this.get_bottom_right();
    
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);
    
    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 1)){
      // blocks are effected by physics so they will obey elastic collision laws when the collide with things
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
      this.substance_collided(some_substance); // special action to take

    }
    

    // accounting for terminal velocities:
    this.velocity.x = sign(this.velocity.x) * min(abs(this.velocity.x), BLOCK_TERMINAL_VELOCITY);
    this.velocity.y = sign(this.velocity.y) * min(abs(this.velocity.y), BLOCK_TERMINAL_VELOCITY);
    
  }

}

class BouncyPlayBlock extends PlayBlock{
  
  // Represents a block that bounces you upwards
  float bounce_power;

  BouncyPlayBlock (PVector center_, float height_){
    super(center_, height_, color(0,206,209));
    this.bounce_power = 10;
  }
  
  void substance_collided(Substance pl){
    //if ( abs(pl.coordinate.y - this.get_top_left().y) > abs(pl.coordinate.y - this.get_bottom_right().y)) return;
    // every time this block collides with a substance, it launches the substance upwards at a rate of this.bounce_power units/s
    pl.velocity.y = min(DEFAULT_PLAYER_VERTICAL_TERMINAL_VELOCITY, pl.velocity.y - this.bounce_power);

  }
}
  
