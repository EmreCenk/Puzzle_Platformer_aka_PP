
// constants

float DEFAULT_MASS = 1.1;
float SUBSTANCE_DEFAULT_BOUNCE = 0.4;
float DEFAULT_PLAYBLOCK_BOUNCE = 0;
float g = 20.81;
float epsilon = 0.05; // close to 0 but not quite
float PENDULUM_VELOCITY_USEFULLNESS_COEFFICIENT = 600; // what coefficient you multiply the pendulum velocity by when calculating physics
float DEFAULT_MU = 0.005; // default coefficient of friction value
float DEFAULT_TERMINAL_VELOCITY = 2; // default player horizontal terminal velocity
float DEFAULT_PLAYER_BOUNCINESS = 0;


// file for math calculations

PVector polar_to_cartesian(float r, float theta){
  // converts polar coordinates to cartesian
  PVector cart = new PVector();  
  cart.x = r*cos(theta);
  cart.y = r*sin(theta);
  return cart;
}


PVector rotate_around_pivot(PVector pivot, PVector point, float theta){
  // rotates a point around a pivot by theta
  
  float tempX = point.x - pivot.x;
  float tempY = point.y - pivot.y;
  float current_angle = atan2(tempY, tempX);
  
  PVector rotated_p = polar_to_cartesian(dist(0, 0, tempX, tempY), current_angle - theta);
  
  rotated_p.x += pivot.x;
  rotated_p.y += pivot.y;
  return rotated_p;

}

float[] get_coefficients(float x1, float y1, float x2, float y2){
  // takes in 2 points of a line, converts points to y = mx + b format
  float m = (y1-y2)/(x1-x2);
  float b = y1 - m*x1 ;
  return new float [] {m, b};
}


PVector find_line_intersection(PVector p11, PVector p12, PVector p21, PVector p22){
  // takes in coordinates for 2 lines, finds intersection (this function assumes the inputs are infinitely long lines and not lines segments)
  // p11 -> line 1, point 1
  // p12 -> line 1, point 2 ... etc.  
  
  
  //converting to y=mx+b format:
  float m1, b1, m2, b2;
  float[] coefs1 = get_coefficients(p11.x, p11.y, p12.x, p12.y);
  float[] coefs2 = get_coefficients(p21.x, p21.y, p22.x, p22.y);
  
  m1 = coefs1[0];
  b1 = coefs1[1];

  m2 = coefs2[0];
  b2 = coefs2[1];
  
  if (m1 == m2) return null; // they're parralel and don't intersect
  
  float x = (b2-b1)/(m1-m2); // blindly trusting my algebra (very risky decision, but appears to be working... for now)
  float y = m1*x+b1;
  return new PVector(x, y);
}

boolean point_is_on_line_segment(PVector line_point_1, PVector line_point_2, PVector point_to_check){
  // checks if a point is on a line segment
  
  float m, b;
  float[] coefs1 = get_coefficients(line_point_1.x, line_point_1.y, line_point_2.x, line_point_2.y);
  m = coefs1[0];
  b = coefs1[1]; 
  
  // not only should the point be on the line, but the x and y should be in the domain as well:
  return (point_to_check.y == m * point_to_check.x + b 
          && point_to_check.x < max(line_point_1.x, line_point_2.x)
          && point_to_check.x > min(line_point_1.x, line_point_2.x)
          && point_to_check.y < max(line_point_1.y, line_point_2.y)
          && point_to_check.y > min(line_point_1.y, line_point_2.y)
          );
}

boolean line_segments_intersect(PVector line1_p1, PVector line1_p2, PVector line2_p1, PVector line2_p2){
    // checks if two lines segments intersect
    PVector intersection = find_line_intersection(line1_p1, line1_p2, line2_p1, line2_p2);
    if (intersection == null) return false;
    boolean point_on_line1 = point_is_on_line_segment(line1_p1, line1_p2, intersection);
    boolean point_on_line2 = point_is_on_line_segment(line2_p1, line2_p2, intersection);
    return (point_on_line1 && point_on_line2);
}

float[] solve_quadratic(float a, float b, float c){
  // solves a*x^2 + bx + c = 0
  if (b*b - 4*a*c < 0) return new float[]{-b/(2*a), -b/(2*a)}; // oh no (due to rounding errors you sometimes get a value like -0.0001 in the discriminant. I'm just rounding it to 0)
  return new float [] {(-b + sqrt(b*b - 4*a*c))/(2*a), (-b - sqrt(b*b - 4*a*c))/(2*a)};
}

boolean circle_in_rect(PVector top_left, PVector bottom_right, PVector point, float radius, float radius_coefficient){
  // if you want to check a point, just set radius to 0
  if (point.x + radius_coefficient * radius < top_left.x) return false;
  if (point.x - radius_coefficient * radius > bottom_right.x) return false;
  if (point.y + radius < top_left.y) return false;
  if (point.y - radius > bottom_right.y) return false;
  return true;
}

int sign(float a){
  if (a > 0) return 1;
  return -1;

}

float dot_product(PVector a, PVector b){
  return (a.x*b.x + a.y*b.y);
}

PVector subtract(PVector a, PVector b){
  return new PVector(a.x - b.x, a.y - b.y);
}

PVector project(PVector a, PVector b){
  // projecting vector a onto vector b
  // this is equivalent to finding where the point would fall if a perpendicular line was drawn vector a to vector b
  // Here's a neat proof: https://www.youtube.com/watch?v=aTBtgW7U-Y8
  
  float k = dot_product(a, b) / dot_product(b, b);
  return new PVector(k * b.x, k * b.y);
  
}
boolean line_intersects_circle(PVector line_point_1, PVector line_point_2, PVector circle_center, float radius1, float radius2){
  
  // if the circle isn't even inside the rectangle that would be drawn with the line points, then it definitely isn't on the line
  if (!circle_in_rect(line_point_1, line_point_2, circle_center, radius1 + radius2, 1)) return false;
  
  //PVector projected_point = new PVector(0, 0);
  PVector actual_vector = subtract(line_point_1, line_point_2);
  PVector projected_point = project(circle_center, actual_vector); 
  float distance = dist(circle_center.x, circle_center.y, projected_point.x, projected_point.y);
  return (distance < radius1 + radius2);

}


// file for physics calculations


float[] elastic_collision_1d(float m1, float v1, float m2, float v2){
  // using physics to simulate collisions  
  // conservation of momentum: m1*v1 + m2*v2 = m1*v1' + m2*v2'
  // conservation of kinetic energy (assuming no energy is lost): m1*(v1^2) + m2*(v2^2) = m1*(v1'^2) + m2*(v2'^2)

  return new float[] {
    v1*(m1-m2)/(m1+m2) + (2*m2*v2)/(m1+m2),
    (2*m1*v1)/(m1+m2) + (m2-m1)*v2/(m1+m2)
  };
}


void elastic_collision_2d(Substance obj1, Substance obj2){
  // calculates what would happen if 2 objectt collided
  // if this function has been called, we are sure that 2 objects are intersecting at some point
  
  // note: since this is 2d we have to do each component individually :(
  float [] x_components = elastic_collision_1d(obj1.mass, obj1.velocity.x, obj2.mass, obj2.velocity.x);  
  float [] y_components = elastic_collision_1d(obj1.mass, obj1.velocity.y, obj2.mass, obj2.velocity.y);
  //println(obj1.mass, obj2.mass);
  //println("collision before");
  //println(obj1, obj1.velocity);
  //println(obj2, obj2.velocity); 

  obj1.velocity  = new PVector(x_components[0], y_components[0]).mult(1);
  obj2.velocity = new PVector(x_components[1] , y_components[1]).mult(1);
  
  //println("collision");
  //println(obj1, obj1.velocity);
  //println(obj2, obj2.velocity); 
  //println();
}

PVector get_pendulum_velocity(Pendulum pendulum){
  // Note: this function is made up of a lot of math and physics work that has not been double checked by a second person 
  // (I've concluded that it appears to be working properly via visual inspection)
  // proceed with caution
  
  
  // we already know the magnitude:
  float magnitude = pendulum.angular_speed;
  
  //now lets find the direction:
  /*
  since the pendulum is in circular motion, we know the velocity's direction will be tangent to the circle 
  To find the slope of the tangent to the circle, let's take the derivative of the equation of a circle:
  x^2 + y^2 = r^2
  d(x^2)/dx + d(y^2)/dx = 0
  2x + 2y * dy/dx = 0
  dy/dx = -2x/2y
  dy/dx = -x/y
  
  since this is the slope, it is equal to tan(theta) where theta is the angle between the line and the x axis
  
  therefore:
  tan(theta) = dy/dx = -x/y
  tan(theta) = -x/y
  theta = tan^(-1)(-x/y)
 
  */
  
  // finding what x and y are:
  float x = abs(pendulum.hanging_thing.coordinate.x - pendulum.pivot.coordinate.x);
  float y = abs(pendulum.hanging_thing.coordinate.y - pendulum.pivot.coordinate.y);
  
  // fixing sign if needed:
  if (pendulum.hanging_thing.coordinate.x > pendulum.pivot.coordinate.x) x *= - 1;

  float angle = atan2(x, y);
  
  // Now that we have the magnitude and the angle, all we have to do is convert these polar coordinates to cartesian:
  PVector u = polar_to_cartesian(magnitude, angle);
  
  //if (pendulum.hanging_thing.coordinate.x > pendulum.pivot.coordinate.x) u.mult(-1);

  return u;
}
