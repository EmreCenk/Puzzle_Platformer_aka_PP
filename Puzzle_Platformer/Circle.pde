

class Circle extends Substance{
  
  Circle(PVector velocity_, PVector coordinates_, float radius_, color colour_){
    super(velocity_, coordinates_, radius_, colour_); 
  }
  
  boolean is_colliding(Substance some_object){
    //return line_intersects_circle(some_object.previous_coordinate, some_object.coordinate, this.coordinate, this.radius, some_object.radius);

    return dist(this.coordinate.x, this.coordinate.y, some_object.coordinate.x, some_object.coordinate.y) < this.radius + some_object.radius;
  }
  
  void display(){
    stroke(this.colour);
    fill(this.colour);
    circle(this.coordinate.x, this.coordinate.y, 2*this.radius);
  }
  
  void collide(Substance obj){
    if (this.is_colliding(obj)){
      elastic_collision_2d(obj, this);
    }
  }
}
