
class Substance{
  ArrayList<Line> lines;
  color colour;
  PVector velocity, coordinate;
  float width_;
  float bounciness; // how much it bounces when it hits a surface
  boolean jumping;
  PVector previous_coordinate; // stores position in previous frame
  float mass;
  boolean effected_by_gravity;

  Substance(PVector velocity_, PVector coordinates_, float w, color colour_){
    this.velocity = velocity_;
    this.coordinate = coordinates_;
    this.width_ = w;
    this.colour = colour_;
    this.lines = new ArrayList<Line>();
    
    //default values:
    this.bounciness = SUBSTANCE_DEFAULT_BOUNCE;
    this.mass = DEFAULT_MASS;
    this.jumping = false;  
    this.previous_coordinate = new PVector(coordinates_.x, coordinates_.y);
    this.effected_by_gravity = true;
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
    
    //todo: test the following code (it may be buggy, it hasn't been tested)
    PVector shift = new PVector(this.coordinate.x - this.previous_coordinate.x, this.coordinate.y - this.previous_coordinate.y);
    for (int i = 0; i<this.lines.size(); i++){
      this.lines.get(i).p1.add(shift);
      this.lines.get(i).p2.add(shift);
    }
    // untested section finished //
    
  }

  void move(){
    for (int i = 0; i<this.lines.size(); i++){
      this.lines.get(i).p1.add(this.velocity);
      this.lines.get(i).p2.add(this.velocity);
    }
    
    this.previous_coordinate = new PVector(this.coordinate.x, this.coordinate.y);
    this.coordinate.add(this.velocity);
  }
  
  boolean intersects(Substance obj){
    PVector a, b, c, d;
    for (int i = 0; i < this.lines.size(); i++){
      a = this.lines.get(i).p1;
      b = this.lines.get(i).p2;
      for (int j = 0; j < obj.lines.size(); j++){
        c = this.lines.get(j).p1;
        d = this.lines.get(j).p2;
        if (line_segments_intersect(a, b, c, d)) return true;
      }
    }
    return false;
  
  }
  
  void draw_velocity(){
    line(this.coordinate.x, this.coordinate.y, this.coordinate.x + this.velocity.x, this.coordinate.y + this.velocity.y);
  }
    
  void display(){}// is overwritten when a new substance is created
  void collide(Substance sub){};

}
