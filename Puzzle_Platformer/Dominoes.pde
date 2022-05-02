class Domino {
  float width_, height_; 
  
  float current_theta;
  float angular_speed;
  float angular_acceleration;
  Domino(float theta){ 

    
  this.current_theta = theta;
  this.angular_acceleration = 0;
  this.angular_speed = 0;
  
  this.angular_acceleration = -0.5*cos(current_theta)/this.height_ // calculating acceleration
  this.angular_speed += this.angular_acceleration; // acceleration updates velocity
  this.current_theta += this.angular_speed; 
  }
}
