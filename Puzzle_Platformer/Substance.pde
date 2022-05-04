
class Substance{
  color colour;
  PVector velocity, coordinate;
  float radius;
  float bounciness; // how much it bounces when it hits a surface
  boolean jumping;
  PVector previous_coordinate; // stores position in previous frame
  float mass;
  boolean effected_by_gravity, indestructible;
  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_){
    this.velocity = velocity_;
    this.coordinate = coordinates_;
    this.radius = radius_;
    this.colour = colour_;
    
    //default values:
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
    this.mass = DEFAULT_MASS;
    this.jumping = false;  
    this.previous_coordinate = new PVector(coordinates_.x, coordinates_.y);
    this.effected_by_gravity = true;
    this.indestructible = false;
  }
  
  Substance(){
    this(new PVector(0, 0), new PVector(0, 0), 0, color(0, 0, 0));
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
    line(this.coordinate.x, this.coordinate.y, this.coordinate.x + this.velocity.x, this.coordinate.y + this.velocity.y);
  }
    
  void display(){}// is overwritten when a new substance is created
  void collide(Substance sub){
    
  };

}
