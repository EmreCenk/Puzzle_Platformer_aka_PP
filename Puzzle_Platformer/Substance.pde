
float DEFAULT_MASS = 1.1;
float DEFAULT_BOUNCINESS = 1.3;

class Substance{
  color colour;
  PVector velocity, coordinate;
  float radius;
  float bounciness; // how much it bounces when it hits a surface
  boolean jumping;
  PVector previous_coordinate; // stores position in previous frame
  float mass;


  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_){
    this.velocity = velocity_;
    this.coordinate = coordinates_;
    this.radius = radius_;
    this.colour = colour_;
    
    //default values:
    this.bounciness = DEFAULT_BOUNCINESS;
    this.mass = DEFAULT_MASS;
    this.jumping = false;  
    this.previous_coordinate = new PVector(coordinates_.x, coordinates_.y);
  }
  
  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_, float bounciness_, float mass_){
    this(velocity_, coordinates_, radius_, colour_, bounciness_);
    this.mass = mass_;
  }
  
  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_, float bounciness_){
   this(velocity_, coordinates_, radius_, colour_);
   this.bounciness = bounciness_;
  }

  void change_position(PVector new_coordinate){
    this.previous_coordinate = new PVector(this.coordinate.x, this.coordinate.y);
    this.coordinate = new_coordinate;
  }

  void move(){
    this.previous_coordinate = new PVector(this.coordinate.x, this.coordinate.y);
    this.coordinate.add(this.velocity);
  }
  void draw_velocity(){
    //frameRate(10);
    this.velocity.mult(10);
    line(this.coordinate.x, this.coordinate.y, this.coordinate.x + this.velocity.x, this.coordinate.y + this.velocity.y);
    this.velocity.mult(1/10);
  }
  

}
