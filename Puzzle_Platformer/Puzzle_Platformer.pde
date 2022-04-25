



Player emre;
Physics physics;
Prison my_prison;
ArrayList<Pendulum> pendulums;
Platform p, p2, p3;
Pendulum mp1, mp2;
Circle circle;

void setup() {
    //frameRate(5);

  size(700, 500);
  //PVector center_, float height_, float length_, color colour_
  pendulums = new ArrayList<Pendulum>();
  int n = 0;
  for (int i = 0; i < n; i++){
    pendulums.add(new Pendulum(new PVector(i * width/n, 100), 5, (i + 1) * n, (i+1)*n/2, color(0,0,0)));
  }
  mp1 = new Pendulum(new PVector(width*0.4, 100), 10, 150, PI/20, 10);
  mp2 = new Pendulum(new PVector(width*0.7, 100), 10, 225, PI/20, 10);
  mp2.current_theta = -PI/14;
  
  //circle = new Circle(new PVector(0,_, PVector coordinates_, float radius_, color colour_);
  p = new Platform(new PVector(width*0.1, 300), 100, 20, color(0, 0, 0));
  p2 = new Platform(new PVector(width*0.2, 350), 900, 20, color(0, 0, 0));
  p3 = new Platform(new PVector(width*0.3, 200), 100, 20, color(0, 0, 0));

  my_prison = new Prison();
  emre = new Player(new PVector(width*0.3, 90 + mp2.string_length), 25, color(0, 0, 0), 0.6);
  //emre.velocity = new PVector(70, 0);
  
  physics = new Physics();
  physics.add_obj(emre);
  physics.add_obj(p);
  
}

void draw() {
  background(255);
  physics.gravity();

  emre.move();
  p.move();

  p.keep_object_above_platform(emre, physics);
  p2.keep_object_above_platform(emre, physics);
  p3.keep_object_above_platform(emre, physics);

  my_prison.imprison(emre);
  my_prison.imprison(p);

  emre.display();
  p.display();
  p2.display();
  p3.display();

  mp1.swing();
  mp1.collide(emre);
  mp1.display();
  
  mp2.swing();
  mp2.collide(emre);
  mp2.display();
  for (int i = 0; i < pendulums.size(); i++){
    pendulums.get(i).swing();
    pendulums.get(i).collide(emre);
    pendulums.get(i).display();
  }
}

void keyPressed() {
  emre.key_press_movement();
}

void keyReleased() {
  emre.key_up_movement();
}
