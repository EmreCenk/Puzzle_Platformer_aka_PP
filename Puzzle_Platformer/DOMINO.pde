float speed = 0.01;
float g = 0.1;
float angSpeed = 0;
int dotSize = 15;
int r, d;
float xC, yC, xDot, yDot;
float theta = radians(89);
float angAcc = g*cos(theta);

void setup() {
  size(900, 900);
  noLoop();  

  d = width/2;
  r = d/2;
  xC = width/2;
  yC = height/2;



class Domino{
  float angular_speed, length_, angular_acceleration, dot_size, theta;
  Circle ground, hanging_thing;
  
  Domino(PVector ground_coordinate, float length_){
    this.angular_speed = 0;
    this.theta = 89;
    this.length_ = length_;
    this.ground = new Circle(ground_coordinate, 10, color(0, 0, 0));
    this.hanging_thing = new Circle(new PVector(ground_coordinate.x, ground_coordinate.y - length_), 10, color(0,0,0));
  }
  
  void move(){
    //this.angular_acceleration = g * cos(this.theta);
    //this.hanging_thing.change_position(new PVector(this.ground.coordinate.x + this.length_*cos(this.theta), this.ground.coordinate.y + this.length_*sin(this.theta)));
  }
  
  void display(){
    this.hanging_thing.display();
    this.ground.display();
    line(this.hanging_thing.coordinate.x, this.hanging_thing.coordinate.y, this.ground.coordinate.x, this.ground.coordinate.y);
    
  }

}
//float speed = 0.01;
//float g = 0.1;
//float angSpeed = 0;
//int dotSize = 15;
//int r, d;
//float xC, yC, xDot, yDot;
//float theta = radians(89);
//float angAcc = g*cos(theta);

void draw() {
  angAcc = g*cos(theta);
  stroke(255);
  background(0);
  strokeWeight(4);
//void setup() {
//  size(900, 900);
//  noLoop();  

//  d = width/2;
//  r = d/2;
//  xC = width/2;
//  yC = height/2;

  xDot = xC + r*cos(theta);
  yDot = yC - r*sin(theta);
//}

  //domino 
  line(xC, yC, xDot, yDot);
//void draw() {
//  angAcc = g*cos(theta);
//  stroke(255);
//  background(0);
//  strokeWeight(4);

  // DOT
  fill(255);
  noStroke();
  circle(xDot, yDot, dotSize);

  //UPDATES THE ANGLE
  //angSpeed = angSpeed +g*cos(theta);
//  xDot = xC + r*cos(theta);
//  yDot = yC - r*sin(theta);

  if (theta>0) {
    theta = (theta - angSpeed);
    angSpeed = angSpeed + angAcc;
  }
}
//  //domino 
//  line(xC, yC, xDot, yDot);

//////USED SOME TRIG CIRCLE LOGIC 
//  // DOT
//  fill(255);
//  noStroke();
//  circle(xDot, yDot, dotSize);

void keyPressed() {
//  //UPDATES THE ANGLE
//  //angSpeed = angSpeed +g*cos(theta);

  if ( key == 'r' || key == 'R' )
    loop();
  if  (theta < PI)
    loop();
}
//  if (theta>0) {
//    theta = (theta - angSpeed);
//    angSpeed = angSpeed + angAcc;
//  }
//}

////////USED SOME TRIG CIRCLE LOGIC 

//void keyPressed() {

//  if ( key == 'r' || key == 'R' )
//    loop();
//  if  (theta < PI)
//    loop();
//}
