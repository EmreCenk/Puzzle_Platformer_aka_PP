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

}

void draw() {
  angAcc = g*cos(theta);
  stroke(255);
  background(0);
  strokeWeight(4);


  xDot = xC + r*cos(theta);
  yDot = yC - r*sin(theta);

  //domino 
  line(xC, yC, xDot, yDot);

  // DOT
  fill(255);
  noStroke();
  circle(xDot, yDot, dotSize);

  //UPDATES THE ANGLE
  //angSpeed = angSpeed +g*cos(theta);

  if (theta>0) {
    theta = (theta - angSpeed);
    angSpeed = angSpeed + angAcc;
  }
}

//////USED SOME TRIG CIRCLE LOGIC 

void keyPressed() {

  if ( key == 'r' || key == 'R' )
    loop();
  if  (theta < PI)
    loop();
}
