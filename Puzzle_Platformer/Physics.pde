
float g = 9.81;
float epsilon = 0.5; // close to 0 but not quite
class Physics{
  ArrayList<Substance> objs;
  float gravity_intensity;
  
  Physics(){
    this.objs = new ArrayList<Substance>();
    this.gravity_intensity = g;
  }
  void gravity(){
    /* 
    we use a = g as our acceleration and derive a formula to find the new velocity
    a = g m/s^2 (since down is positive on the screen)
    v1 = vy
    t = 1/FPS
    v2 = ?
    
    a = (v2-v1)/t
    v2 = a*t + v1
    v2 = 9.81/FPS + vy
    */
    for (int i = 0; i < this.objs.size(); i++){
      this.objs.get(i).velocity.y += this.gravity_intensity/frameRate; // gravity
      this.objs.get(i).velocity.x *= 0.99; // friction
      if (abs(this.objs.get(i).velocity.x) < epsilon) this.objs.get(i).velocity.x = 0;
      
    }
  }
  
  void velocity_loss(){

  }
  void add_obj(Substance some_object){
    this.objs.add(some_object);
  }
  
}
