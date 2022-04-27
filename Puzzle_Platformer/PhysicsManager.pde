


class PhysicsManager{
  ArrayList<Substance> objs;
  ArrayList<Circle> circles;
  ArrayList<PlayBlock> blocks;
  ArrayList<Platform> platforms;
  ArrayList<Prison> prisons;
  ArrayList<Pendulum> pendulums;
  float gravity_intensity, mu;
  
  PhysicsManager(){
    this.blocks = new ArrayList<PlayBlock>();
    this.pendulums = new ArrayList<Pendulum>();
    this.prisons = new ArrayList<Prison>();
    this.objs = new ArrayList<Substance>();
    this.circles = new ArrayList<Circle>();
    this.platforms = new ArrayList<Platform>();
    this.gravity_intensity = g;
    this.mu = DEFAULT_MU; // coefficient of friction
  }
  
  void apply_collision_in_universe(){
    // circle collision
    for (int i = 0; i < this.circles.size(); i++){
      for (int j = 0; j < this.objs.size(); j++){
        this.circles.get(i).collide(this.objs.get(j));
      }
    }
    
    //keeping things above and below platforms:
    for (int i = 0; i < this.platforms.size(); i++){
      for (int j = 0; j < this.objs.size(); j++){
        //if ((this.objs.get(j) instanceof Platform)) continue;
        //println(this.objs.get(j));
        this.platforms.get(i).keep_object_above_platform(this.objs.get(j));
      }
    }
    
    //prison imprisonment
    for (int i = 0; i < this.prisons.size(); i++){
      for (int j = 0; j < this.objs.size(); j++){
        this.prisons.get(i).imprison(this.objs.get(j));
      }
    }
    
    //pendulum collision
    for (int i = 0; i < this.pendulums.size(); i++){
      for (int j = 0; j < this.objs.size(); j++){
        this.pendulums.get(i).collide(this.objs.get(j));
      }
    }
    
    //block collision
    for (int i = 0; i < this.blocks.size(); i++){
      for (int j = 0; j < this.objs.size(); j++){
        this.blocks.get(i).collide(this.objs.get(j));
      }
    }
  }
  
  void display_universe(){
    for (int i = 0; i < this.objs.size(); i++){
      this.objs.get(i).display();
    }
    for (int i = 0; i < this.platforms.size(); i++){
      this.platforms.get(i).display();
    }
    for (int i = 0; i < this.pendulums.size(); i++){
      this.pendulums.get(i).display();
    }
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
      if (!this.objs.get(i).effected_by_gravity) continue;
      //println(this.objs.get(i), this.objs.get(i).effected_by_gravity);
      this.objs.get(i).velocity.y += this.gravity_intensity/frameRate; // gravity
    }
    for (int i = 0; i < this.pendulums.size(); i++){
      pendulums.get(i).swing();
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
  
  void update_positions_in_universe(){
    // NOTE: WE CAN'T JUST LOOP OVER ALL OBJECTS SINCE CERTAIN OBJECTS AREN'T SUPPOSED TO USE THE .move() METHOD
    // FOR INSTANCE WE HAVE TO SKIP PENDULUM CIRCLES
    
    
    for (int i = 0; i < this.objs.size(); i++){
      this.objs.get(i).move();
    }
    
  }
  void add_obj(Substance some_object){
    this.objs.add(some_object);
  }
  void add_circle(Circle circ){
    this.circles.add(circ);
    this.add_obj(circ);
  }
  void add_block(PlayBlock block){
    this.blocks.add(block);
    this.add_obj(block);
  }
  void add_platform(Platform plt){
    this.platforms.add(plt);
    //this.add_obj(plt);

  }
  void add_prison(Prison prison){
    this.prisons.add(prison);
  }
  void add_pendulum(Pendulum pendulum){
    this.pendulums.add(pendulum);
    //this.add_circle(pendulum.hanging_thing);
    //this.add_circle(pendulum.pivot);
  }
}
