



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

}

void draw(){
  background(255);
  physics.gravity();
  emre.check_player_movement();
  emre.move();
  p.do_job(emre, physics);
  my_prison.imprison(emre);
  
  
  emre.display();
  p.display();
}

void keyPressed(){
  emre.key_press_movement();
}

void keyReleased(){
  emre.key_up_movement();
}
