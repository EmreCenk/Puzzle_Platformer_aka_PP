

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
    
    if (!this.is_colliding(obj)) return;
    float delta_d = obj.radius+this.radius - dist(this.coordinate.x, this.coordinate.y, obj.coordinate.x, obj.coordinate.y);
    float theta = atan2(obj.coordinate.y - this.coordinate.y, obj.coordinate.x - this.coordinate.x);    
    obj.coordinate.add(polar_to_cartesian(delta_d, theta));
    elastic_collision_2d(obj, this);
    
  }
}
