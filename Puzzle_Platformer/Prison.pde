
class Prison {
  // this class creates the wall boundaries that beyblades bounce off of

  float bounciness; // between 0-1. Represents what percent of velocity is preserved when a wall is hit. If the bounciness is above 1, the walls will act like trampolines (making the balls speed up after bouncing)
  PVector top_left, bottom_right; // top left and bottom right coordinates of the rectangle the frame will be in

  Prison(float x1, float y1, float x2, float y2) {
    this.top_left = new PVector(x1, y1);
    this.bottom_right = new PVector(x2, y2);
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
  }

  Prison(float x1, float y1, float x2, float y2, float bounce_loss) {
    // gives option to initialize with bounciness and angular loss
    this(x1, y1, x2, y2); // initialize all other fields
    this.bounciness = bounce_loss; // optional bounciness level
  }

  Prison() {
    this(0, 0, width, height);
  }

  void imprison(Substance obj) {
    // makes sure ball isn't out of boundaries

    if (obj.coordinate.y < this.top_left.y + obj.radius) {
      ////top wall
      obj.coordinate.y = this.top_left.y + obj.radius;
      obj.velocity.y *= (-(this.bounciness + obj.bounciness) / 2);
    } else if (obj.coordinate.y > this.bottom_right.y - obj.radius) {
      //bottom wall
      obj.coordinate.y = this.bottom_right.y - obj.radius;
      obj.velocity.y *= (-(this.bounciness + obj.bounciness) / 2);
      obj.jumping = false;
    }

    //  if (obj.coordinate.x < this.top_left.x + obj.radius){
    //    // left wall
    //    obj.set_velocity(new PVector(-obj.velocity.x, obj.velocity.y)); // reflect along line
    //    obj.set_center(new PVector(this.top_left.x + obj.radius, obj.coordinate.y));
    //    obj.set_velocity(obj.velocity.mult(this.bounciness)); 
    //    obj.set_angular_speed(obj.angular_speed * this.angular_loss);

    //  }

    //  else if (obj.coordinate.x > this.bottom_right.x - obj.radius){
    //    // right wall
    //    obj.set_velocity(new PVector(-obj.velocity.x, obj.velocity.y)); // reflect line
    //    obj.set_center(new PVector(this.bottom_right.x - obj.radius, obj.coordinate.y));
    //    obj.set_velocity(obj.velocity.mult(this.bounciness)); 
    //    obj.set_angular_speed(obj.angular_speed * this.angular_loss);

    //  }
  }
}
