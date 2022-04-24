


class Pendulum{
  
  Circle hanging_thing, pivot;
  float theta, string_length, time_period;
  float frame, angular_speed;
  float adder, minimum_h, maximum_h;
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta, color colour){
    //note: theta in radians
    this.pivot = new Circle(new PVector(0, 0), coordinate_, circle_radius/2, colour);
    this.hanging_thing = new Circle(new PVector(0, 0), new PVector(0, 0), 10, colour);
    this.string_length = length_of_string;
    this.theta = theta;
    this.time_period = 2*PI*sqrt(this.string_length/9.81); // todo: replace with gravity intensity
    this.angular_speed = (2*this.theta*this.string_length)/this.time_period;
    this.frame = this.theta;  
    this.adder = 1/frameRate;
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
    float y1 = this.string_length * cos(this.angular_speed * this.theta) + this.pivot.coordinate.y;
    this.minimum_h = y1;
    this.maximum_h = y;
  }
  void display(){
    this.pivot.display();
    this.hanging_thing.display();
    line(this.pivot.coordinate.x, this.pivot.coordinate.y, this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y);

  }
  
  void update_velocity(){
    this.hanging_thing.velocity = get_pendulum_velocity(this);

  }
  
  void swing(){
    float x = hanging_thing.coordinate.x;
    float y = hanging_thing.coordinate.y;
    this.hanging_thing.previous_coordinate = new PVector(x, y);
    this.hanging_thing.coordinate.x = this.string_length * sin(this.angular_speed * this.frame) + this.pivot.coordinate.x;
    this.hanging_thing.coordinate.y = this.string_length * cos(this.angular_speed * this.frame) + this.pivot.coordinate.y;
    
    this.frame += this.adder;
    if (this.frame < -this.theta || this.frame > this.theta) this.adder *= -1;
  }
  
  void collide(Substance obj){
    this.update_velocity();
    this.pivot.collide(obj);
    this.hanging_thing.collide(obj);
  }
}
