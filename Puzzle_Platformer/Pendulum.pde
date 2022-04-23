


class Pendulum{
  
  Circle hanging_thing, pivot;
  float theta, string_length, time_period;
  float frame, angular_speed;
  float adder;
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
}
  Pendulum(PVector coordinate_, float circle_radius, float length_of_string, float theta){
    this(coordinate_, circle_radius, length_of_string, theta, color(0,0,0));
  }
  
  void display(){
    this.pivot.display();
    this.hanging_thing.display();
    line(this.pivot.coordinate.x, this.pivot.coordinate.y, this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y);
  }
  
  void swing(){
    this.hanging_thing.coordinate.x = this.string_length * sin(this.angular_speed * this.frame) + this.pivot.coordinate.x;
    this.hanging_thing.coordinate.y = this.string_length * cos(this.angular_speed * this.frame) + this.pivot.coordinate.y;
    
    this.frame += this.adder;
    if (this.frame < -this.theta || this.frame > this.theta) this.adder *= -1;
  }
}
