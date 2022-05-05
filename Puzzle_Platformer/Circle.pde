

class Circle extends Substance{
  // a class that represents circles in this physics universe
  
  Circle(PVector velocity_, PVector coordinates_, float radius_, color colour_){
    super(velocity_, coordinates_, radius_, colour_); 
  }
  
  Circle(PVector coordinates_, float radius_, color colour_){
    super(new PVector(0, 0), coordinates_, radius_, colour_); 
  }
  
  boolean is_colliding(Substance some_object){
    //checks if the circle is colliding with another circle (though this collision system approximately works for most shapes so we used it as a general solution)
    return dist(this.coordinate.x, this.coordinate.y, some_object.coordinate.x, some_object.coordinate.y) < this.radius + some_object.radius;
  }
  
  void display(){
    stroke(this.colour);
    fill(this.colour);
    circle(this.coordinate.x, this.coordinate.y, 2*this.radius);
  }
  
  void collide(Substance obj){
    
    if (!this.is_colliding(obj)) return; // if they're not touching then no need to process the collision
    
    // before anything we need to make sure that the objects aren't inside each other:
 
    // how much we need to move the external object so that it is tangent to "this" circle
    float delta_d = obj.radius+this.radius - dist(this.coordinate.x, this.coordinate.y, obj.coordinate.x, obj.coordinate.y);
    
    // what angle we need to move the object at:
    float theta = atan2(obj.coordinate.y - this.coordinate.y, obj.coordinate.x - this.coordinate.x);    
    
    // convert the distance, angle to cartesian and add the two vectors:
    obj.coordinate.add(polar_to_cartesian(delta_d, theta));
    
    // now they can collide safely without being inside each other
    elastic_collision_2d(obj, this);
    
    
    obj.jumping = this.jumping;
 
    
  }
}
