


class PhysicsManager{
  ArrayList<Substance> objs;
  float gravity_intensity, mu;
  
  PhysicsManager(){
    this.objs = new ArrayList<Substance>();
    this.gravity_intensity = g;
    this.mu = DEFAULT_MU; // coefficient of friction
  }
  
  void apply_gravity_to_universe(){
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
     
    }
  }
  void apply_friction_to_universe(){
    for (int i = 0; i < this.objs.size(); i++){
      this.slow_down_object(this.objs.get(i));
      if (abs(this.objs.get(i).velocity.x) < epsilon) this.objs.get(i).velocity.x = 0;
      }
  }
 
  
  void slow_down_object(Substance obj){
    float friction_acceleration = this.mu * this.gravity_intensity;
    if (obj.velocity.x < 0) obj.velocity.x = min(0, obj.velocity.x + friction_acceleration);
    else obj.velocity.x = max(0, obj.velocity.x - friction_acceleration);
    obj.velocity.x *= 0.99; // friction
  }
  
  void add_obj(Substance some_object){
    this.objs.add(some_object);
  }
  
}
