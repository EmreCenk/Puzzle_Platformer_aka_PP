

class Level{
  PhysicsManager physics;
  Player player;
  Level(PhysicsManager p, Player pl){
    this.player = pl;
    this.physics = p;
  }
}

Level create_level1(){
  
  PhysicsManager phys = new PhysicsManager();
  //initializing golden ball
  goal_ball = new Circle(new PVector(width*0.1, height*0.4), 10, color(100, 100, 0));
  goal_ball.mass = 4;
  phys.add_circle(goal_ball);


  // initializing player
  emre = new Player(new PVector(width/2, height*0.01), 25, color(0, 0, 0), 0.6, inventorySize, money, 3);
  emre.mass = 10;
  emre.jump_power = 10;
  phys.add_player(emre);

  // creating platforms:
  phys.add_platform(new Platform(new PVector(30, 230), 500, 20, color(255, 0, 0))); // red
  phys.add_platform(new Platform(new PVector(960, 475), 300, 20, color(0, 255, 0))); // green

  //creating a domino:
  phys.add_domino(new Domino(new PVector(100, 100), 100));
  
  //creating blocks:
  b = new BouncyPlayBlock(new PVector(width/2, height*0.5), 50);
  b.velocity = new PVector(0, 0);
  phys.add_block(b);

  
  //creating pendulums:
  phys.add_pendulum(new Pendulum(new PVector(450, 130), 10, 200, -PI/20, 8));
  phys.add_pendulum(new Pendulum(new PVector(130, 0), 10, 175, -PI/4, 8));


  phys.add_prison(new Prison());

  return new Level(phys, emre);

}
