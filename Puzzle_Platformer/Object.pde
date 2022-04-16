

class Substance{
  color colour;
  PVector velocity, coordinate;
  float radius;
  float bounciness; // how much it bounces when it hits a surface
  boolean jumping;
  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_){
    this.velocity = velocity_;
    this.coordinate = coordinates_;
    this.radius = radius_;
    this.colour = colour_;
    this.bounciness = 0;
    this.jumping = false;  
  }
  Substance(PVector velocity_, PVector coordinates_, float radius_, color colour_, float bounciness_){
   this(velocity_, coordinates_, radius_, colour_);
   this.bounciness = bounciness_;
  }


  void move(){
    this.coordinate.add(this.velocity);
  }
}
