



class Platform extends Substance {

  float width_, height_;
  float bounciness;
  Platform(PVector center_, float width_, float height_, color colour_) {
    super(new PVector(0, 0), center_, height_/2, colour_);
    this.width_ = width_;
    this.height_ = height_;
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
    this.effected_by_gravity = false; // by default platforms are immune to gravity
  }


  PVector get_top_left() { // gets top left corner
    return new PVector(this.coordinate.x - this.width_/2, this.coordinate.y - height_/2);
  }
  PVector get_bottom_right() { //gets top right corner
    return new PVector(this.coordinate.x + this.width_/2, this.coordinate.y + height_/2);
  }

  void keep_object_outside(Substance some_substance) {

    // makes sure the substance doesn't go inside the platform


    PVector top_left = this.get_top_left();
    PVector bottom_right = this.get_bottom_right();

    // checking if substance is outside of y boundaries
    boolean outside_y = (some_substance.coordinate.y < top_left.y - some_substance.radius * 0.5 || some_substance.coordinate.y > bottom_right.y + some_substance.radius * 0.5);

    if (!outside_y) {
      // substance is withing y boundaries, let's fix it's x boundary
      if (abs(top_left.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = top_left.x - some_substance.radius;
      else if (abs(bottom_right.x - some_substance.coordinate.x) < some_substance.radius) some_substance.coordinate.x = bottom_right.x + some_substance.radius;
    }

    if (circle_in_rect(top_left, bottom_right, some_substance.coordinate, some_substance.radius, 0.5) ) {
      // substance is colliding with platform
      // fixing the y boundaries::
      if (abs(some_substance.coordinate.y - top_left.y) < abs(some_substance.coordinate.y - bottom_right.y)) {
        some_substance.coordinate.y = top_left.y - some_substance.radius;
      } else {
        some_substance.coordinate.y = bottom_right.y + some_substance.radius;
      }

      //modifying the velocity depending on the geometric mean of the bounciness values 
      some_substance.velocity.y *= -sqrt(bounciness * some_substance.bounciness);      
      some_substance.jumping = false; // you can always jump off of platforms since platforms are not effected by gravity
    }
  }

  void display() {
    //draws the rectangle

    PVector top_left = this.get_top_left();    
    stroke(color(255, 0, 0));
    fill(this.colour);
    rect(top_left.x, top_left.y, this.width_, height_);
  }
}
