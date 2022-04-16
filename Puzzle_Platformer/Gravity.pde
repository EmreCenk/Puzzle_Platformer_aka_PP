

class PhysicsManager{
  ArrayList<Substance> objs;
  PhysicsManager(){
    this.objs = new ArrayList<Substance>();
  }
  void gravity(){
    // we use a = -9.81 as our acceleration and derive a formula to find the new velocity
    /* 
    a = 9.81 m/s^2 (since down is positive on the screen)
    v1 = vy
    t = 1/FPS
    v2 = ?
    
    a = (v2-v1)/t
    v2 = a*t + v1
    v2 = 9.81/FPS + vy
    */
    for (int i = 0; i < this.objs.size(); i++){
      this.objs.get(i).velocity.y += 9.8/frameRate; 
      println(this.objs.get(i).velocity);
    }
  }
  
  void add_obj(Substance some_object){
    this.objs.add(some_object);
  }
  
}
