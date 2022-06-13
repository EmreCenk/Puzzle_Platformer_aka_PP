
// file for physics calculations


float[] elastic_collision_1d(float m1, float v1, float m2, float v2) {
  // using physics to simulate collisions  
  // conservation of momentum: m1*v1 + m2*v2 = m1*v1' + m2*v2'
  // conservation of kinetic energy (assuming no energy is lost): m1*(v1^2) + m2*(v2^2) = m1*(v1'^2) + m2*(v2'^2)

  return new float[] {
    v1*(m1-m2)/(m1+m2) + (2*m2*v2)/(m1+m2), 
    (2*m1*v1)/(m1+m2) + (m2-m1)*v2/(m1+m2)
  };
}


void elastic_collision_2d(Substance obj1, Substance obj2) {
  // calculates what would happen if 2 objectt collided
  // if this function has been called, we are sure that 2 objects are intersecting at some point

  // note: since this is 2d we have to do each component individually :(
  float [] x_components = elastic_collision_1d(obj1.mass, obj1.velocity.x, obj2.mass, obj2.velocity.x);  
  float [] y_components = elastic_collision_1d(obj1.mass, obj1.velocity.y, obj2.mass, obj2.velocity.y);

  obj1.velocity  = new PVector(x_components[0], y_components[0]).mult(1);
  obj2.velocity = new PVector(x_components[1], y_components[1]).mult(1);

  //println("collision");
  //println(obj1, obj1.velocity);
  //println(obj2, obj2.velocity); 
  //println();
}

PVector get_pendulum_velocity(Pendulum pendulum) {
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
