

class Pendulum{
  //represents a pendulum
  
  Circle hanging_thing, pivot; // hanging_thing is tha hanging bob

  
  float current_theta, string_length, max_theta;
  float angular_speed;
  float angular_acceleration, minimum_h, maximum_h;
  float usefullness_coefficient;
  boolean indestructible;
  
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta, color colour){
    
    //note: theta in radians
    
    //initializing values:
    this.pivot = new Circle(new PVector(0, 0), coordinate_, circle_radius/2, colour);
    this.hanging_thing = new Circle(new PVector(0, 0), new PVector(0, 0), 10, colour);
    this.string_length = length_of_string;
  
    this.max_theta = theta;
    this.current_theta = theta;
    this.angular_acceleration = 0;
    this.angular_speed = 0;
    
    this.usefullness_coefficient = PENDULUM_VELOCITY_USEFULLNESS_COEFFICIENT; // explanation in Pendulum.collide()
    
    this.swing(); // we call swing once to properly initialize the coordinates of the hanging_thing
    this.indestructible = false;
  }
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta){
    this(coordinate_, circle_radius, length_of_string, theta, color(0,0,0));
  }
  

  void display(){
    //draws the pendulum onto the screen
    this.pivot.display();
    this.hanging_thing.display();
    line(this.pivot.coordinate.x, this.pivot.coordinate.y, this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y);
    stroke(color(255, 0, 0));
  }
  
  void update_velocity(){
    // computes the velocity of the pendulum and sets it equal to the bob's velocity
    // the angular velocity isn't necesarily the same as the velocity vector (for the hanging bob)
    this.hanging_thing.velocity = get_pendulum_velocity(this);
  }
  
  
  void swing(){
    /* 
    after separating Fg into it's components such that one component cancels out with the tension force, 
    the net force left is Fg*sin(theta)
    Fnet = Fg*sin(theta)
    ma = m*g*sin(theta)
    a = g*sin(theta) [inwards]
    since it's towards the center, a = -g*sin(theta)
    */
    this.angular_acceleration = -0.5*sin(current_theta)/this.string_length; // calculating acceleration (I later decided to divide by string_length due to the formula for torque)
    this.angular_speed += this.angular_acceleration; // acceleration updates velocity
    this.current_theta += this.angular_speed; // angular speed changes angle
    
    //finding new coordiantes with new theta:
    this.hanging_thing.change_position(new PVector(this.string_length * sin(this.current_theta) + this.pivot.coordinate.x,
                                                   this.string_length * cos(this.current_theta) + this.pivot.coordinate.y));
    
  }
  
  void collide(Substance obj){
    this.pivot.collide(obj); // the pivot always a velocity of 0 anyways so we don't need to multiply by some coefficient
    
    if (!this.hanging_thing.is_colliding(obj)) return; // technically checked twice (once here, then once in the collide function)

    
    // here, the velocity of the pendulum is too small to actually be usefull in most physics calculations
    // To counteract this, we have to multiply with some coefficient to make the velocity usefull
    // So here's a new physics rule: in our world, the velocity of a pendulum happens to magically become way more powerful in collisions
    this.update_velocity();
    this.hanging_thing.velocity.mult(this.usefullness_coefficient);
    this.hanging_thing.collide(obj);
    this.hanging_thing.velocity.mult(1/(this.usefullness_coefficient));

    obj.jumping = false; //objects can always jump off of pendulums
    
    // projecting to get the proper magnitude:
    PVector vel = get_pendulum_velocity(this);
    PVector projected = project(this.hanging_thing.velocity, vel);
    this.angular_speed = projected.mag();
    
    // since the magnitude is always positive, if the initial vector is pointing left we need to multiply by -1
    // adding the following single line to fix a bug took us an extreme amount of time 
    // in conclusion, the amount of pain that went into adding the following line is truly immeasurable
    // please know it's value
    if (projected.x < 0) this.angular_speed *= -1; // *priceless line <3 <3 <3*
    
  }

  
  void draw_velocity(){
    this.update_velocity(); //updates velocity
    
    
    this.hanging_thing.velocity.mult(10*this.usefullness_coefficient); //we have to multiply by this or it's not even visible
    this.hanging_thing.draw_velocity();
    this.hanging_thing.velocity.mult(1/(10*this.usefullness_coefficient));

  }
}
