



Player emre;
PhysicsManager physics;
Prison my_prison;
Platform p;

void setup(){
  size(400, 400);
  //PVector center_, float height_, float length_, color colour_

  p = new Platform(new PVector(100, 300), 100, 20, color(0, 0, 0));
  my_prison = new Prison();
  emre = new Player(new PVector(width/2, height/2), 25, color(0, 0, 0), 1);
  physics = new PhysicsManager();
  physics.add_obj(emre);
  physics.add_obj(p);

}

void draw(){
  background(255);
  physics.gravity();
  emre.check_player_movement();
  emre.move();
  p.move();
  p.keep_object_above_platform(emre, physics);
  my_prison.imprison(emre);
  my_prison.imprison(p);
  
  emre.display();
  p.display();
  
}

void keyPressed(){
  emre.key_press_movement();
}

void keyReleased(){
  emre.key_up_movement();
}
