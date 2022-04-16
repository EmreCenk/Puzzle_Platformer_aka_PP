



Player emre;
PhysicsManager physics;
Prison my_prison;

void setup(){
  size(400, 400);
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
  my_prison.imprison(emre);
  emre.display();
}

void keyPressed(){
  emre.key_press_movement();
}

void keyReleased(){
  emre.key_up_movement();
}
