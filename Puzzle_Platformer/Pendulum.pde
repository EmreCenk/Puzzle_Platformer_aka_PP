


class Pendulum{
  
  Circle hanging_thing, pivot;
  float current_theta, string_length, time_period;
  float frame, angular_speed;
  float angular_acceleration, minimum_h, maximum_h;
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta, color colour){
    
    //note: theta in radians
    this.pivot = new Circle(new PVector(0, 0), coordinate_, circle_radius/2, colour);
    this.hanging_thing = new Circle(new PVector(0, 0), new PVector(0, 0), 10, colour);
    this.string_length = length_of_string;
    this.time_period = 2*PI*sqrt(this.string_length/9.81); // todo: replace with gravity intensity
    this.frame = this.current_theta;
    
    this.current_theta = theta;
    this.angular_acceleration = 0;
    this.angular_speed = 0;
    
    this.initialize_height();
  }
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta){
    this(coordinate_, circle_radius, length_of_string, theta, color(0,0,0));
  }
  
  void initialize_height(){
    // coordinates at min velocity (aka at top of pendulum):
    //float x = this.string_length * sin(this.angular_speed * 0) + this.pivot.coordinate.x;
    float y = this.string_length * cos(this.angular_speed * 0) + this.pivot.coordinate.y;
    
    // coordinates at max velocity (aka at bottom of pendulum):
    //float x1 = this.string_length * sin(this.angular_speed * this.theta) + this.pivot.coordinate.x;
    float y1 = this.string_length * cos(this.angular_speed * this.current_theta) + this.pivot.coordinate.y;
    this.minimum_h = y1;
    this.maximum_h = y;
  }
  void display(){
    this.pivot.display();
    this.hanging_thing.display();
    line(this.pivot.coordinate.x, this.pivot.coordinate.y, this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y);
    this.hanging_thing.draw_velocity();
  }
  
  void update_velocity(){
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
    this.angular_acceleration = -g*sin(current_theta)/this.string_length; // calculating acceleration
    this.angular_speed += this.angular_acceleration; // acceleration updates velocity
    this.current_theta += this.angular_speed; // angular speed changes angle
    
    //storing previous coordinates:
    this.hanging_thing.previous_coordinate = new PVector(hanging_thing.coordinate.x, hanging_thing.coordinate.y);
    
    //finding new coordinates:
    this.hanging_thing.coordinate.x = this.string_length * sin(this.current_theta) + this.pivot.coordinate.x;
    this.hanging_thing.coordinate.y = this.string_length * cos(this.current_theta) + this.pivot.coordinate.y;
    
  }
  
  void collide(Substance obj){
    this.update_velocity();
    this.pivot.collide(obj);
    
    //if (this.hanging_thing.is_colliding(obj)){
    //  obj.change_position(new PVector(obj.coordinate.x, obj.coordinate.y));
    //}
    this.hanging_thing.collide(obj);
  }
}
