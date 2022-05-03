class Domino{
  float angular_speed, length_, angular_acceleration, dot_size, theta;
  Circle ground, hanging_thing;
  
  Domino(PVector ground_coordinate, float length_){
    this.angular_speed = 0.0;
    this.theta = radians(89);
    this.length_ = length_;
    this.ground = new Circle(ground_coordinate, 10, color(0, 0, 0));
    this.hanging_thing = new Circle(new PVector(ground_coordinate.x, ground_coordinate.y - length_), 10, color(0,0,0));
  }
  
  void move(){
    if (this.theta <= 0){
      this.theta = 0;
    }
    else{
      this.angular_acceleration = 0.8 * cos(this.theta)/this.length_;
      this.theta = (this.theta - this.angular_speed);
      this.angular_speed  += this.angular_acceleration;    
    }
    //rotate_around_pivot(this.ground.coordinate, this.hanging_thing.coordinate, this.theta);
    this.hanging_thing.change_position(new PVector(this.ground.coordinate.x + this.length_*cos(this.theta),
                                                   this.ground.coordinate.y - this.length_*sin(this.theta)));
  }
  
  void collide(){
    
  }
  
  void display(){
    this.hanging_thing.display();
    this.ground.display();
    line(this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y, this.ground.coordinate.x, this.ground.coordinate.y);
    
  }

}
