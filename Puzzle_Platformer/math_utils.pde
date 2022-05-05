
// file for math calculations

PVector polar_to_cartesian(float r, float theta) {
  // converts polar coordinates to cartesian
  PVector cart = new PVector();  
  cart.x = r*cos(theta);
  cart.y = r*sin(theta);
  return cart;
}


PVector rotate_around_pivot(PVector pivot, PVector point, float theta) {
  // rotates a point around a pivot by theta

  float tempX = point.x - pivot.x;
  float tempY = point.y - pivot.y;
  float current_angle = atan2(tempY, tempX);

  PVector rotated_p = polar_to_cartesian(dist(0, 0, tempX, tempY), current_angle - theta);

  rotated_p.x += pivot.x;
  rotated_p.y += pivot.y;
  return rotated_p;
}

float[] get_coefficients(float x1, float y1, float x2, float y2) {
  // takes in 2 points of a line, converts points to y = mx + b format
  float m = (y1-y2)/(x1-x2);
  float b = y1 - m*x1 ;
  return new float [] {m, b};
}


PVector find_line_intersection(PVector p11, PVector p12, PVector p21, PVector p22) {
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

boolean point_is_on_line_segment(PVector line_point_1, PVector line_point_2, PVector point_to_check) {
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

boolean line_segments_intersect(PVector line1_p1, PVector line1_p2, PVector line2_p1, PVector line2_p2) {
  // checks if two lines segments intersect
  PVector intersection = find_line_intersection(line1_p1, line1_p2, line2_p1, line2_p2);
  if (intersection == null) return false;
  boolean point_on_line1 = point_is_on_line_segment(line1_p1, line1_p2, intersection);
  boolean point_on_line2 = point_is_on_line_segment(line2_p1, line2_p2, intersection);
  return (point_on_line1 && point_on_line2);
}

PVector get_line_segment_intersection(PVector line1_p1, PVector line1_p2, PVector line2_p1, PVector line2_p2) {
  // checks if two lines segments intersect
  // TODO: DOESN'T HANDLE COINCIDING LINES

  PVector intersection = find_line_intersection(line1_p1, line1_p2, line2_p1, line2_p2);
  if (intersection == null) return null;

  //todo: checking only one of the conditions should be enough?
  boolean point_on_line1 = point_is_on_line_segment(line1_p1, line1_p2, intersection);
  boolean point_on_line2 = point_is_on_line_segment(line2_p1, line2_p2, intersection);
  if (point_on_line1 && point_on_line2) return intersection;
  return null;
}

float[] solve_quadratic(float a, float b, float c) {
  // solves a*x^2 + bx + c = 0
  if (b*b - 4*a*c < 0) return new float[]{-b/(2*a), -b/(2*a)}; // oh no (due to rounding errors you sometimes get a value like -0.0001 in the discriminant. I'm just rounding it to 0)
  return new float [] {(-b + sqrt(b*b - 4*a*c))/(2*a), (-b - sqrt(b*b - 4*a*c))/(2*a)};
}

boolean circle_in_rect(PVector top_left, PVector bottom_right, PVector point, float radius, float radius_coefficient) {
  // if you want to check a point, just set radius to 0
  if (point.x + radius_coefficient * radius < top_left.x) return false;
  if (point.x - radius_coefficient * radius > bottom_right.x) return false;
  if (point.y + radius < top_left.y) return false;
  if (point.y - radius > bottom_right.y) return false;
  return true;
}

int sign(float a) {
  if (a > 0) return 1;
  return -1;
}

float dot_product(PVector a, PVector b) {
  return (a.x*b.x + a.y*b.y);
}

PVector subtract(PVector a, PVector b) {
  return new PVector(a.x - b.x, a.y - b.y);
}

PVector project(PVector a, PVector b) {
  // projecting vector a onto vector b
  // this is equivalent to finding where the point would fall if a perpendicular line was drawn from vector a to vector b
  // Here's a neat proof: https://www.youtube.com/watch?v=aTBtgW7U-Y8

  float k = dot_product(a, b) / dot_product(b, b);
  return new PVector(k * b.x, k * b.y);
}
boolean line_intersects_circle(PVector line_point_1, PVector line_point_2, PVector circle_center, float radius1, float radius2) {

  // if the circle isn't even inside the rectangle that would be drawn with the line points, then it definitely isn't on the line
  if (!circle_in_rect(line_point_1, line_point_2, circle_center, radius1 + radius2, 1)) return false;

  //PVector projected_point = new PVector(0, 0);
  PVector actual_vector = subtract(line_point_1, line_point_2);
  PVector projected_point = project(circle_center, actual_vector); 
  float distance = dist(circle_center.x, circle_center.y, projected_point.x, projected_point.y);
  return (distance < radius1 + radius2);
}



float[] closest_distance_from_point_to_line_segment(PVector point, PVector l1, PVector l2) {
  // after an excrutiatingly painful amount of time trying to get this to work, I realized there must have been other people who have had the same issue
  // Long story short: god bless whoever wrote the following forum entry 
  // https://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment

  float A, B, C, D, dot, len_sq, param, xx, yy, dx, dy;  

  float x = point.x;
  float y = point.y;
  float x1 = l1.x;
  float y1 = l1.y;
  float x2 = l2.x;
  float y2 = l2.y;

  A = x - x1;
  B = y - y1;
  C = x2 - x1;
  D = y2 - y1;

  dot = A * C + B * D;
  len_sq = C * C + D * D;
  param = -1;
  if (len_sq != 0) //in case of 0 length line
    param = dot / len_sq;


  if (param < 0) {
    xx = x1;
    yy = y1;
  } else if (param > 1) {
    xx = x2;
    yy = y2;
  } else {
    xx = x1 + param * C;
    yy = y1 + param * D;
  }

  dx = x - xx;
  dy = y - yy;
  return new float[] {sqrt(dx * dx + dy * dy), xx, yy};
}

boolean rectangles_overlap(PVector top_left1, PVector bottom_right1, PVector top_left2, PVector bottom_right2) {
  float x1 = top_left1.x;
  float y1 = top_left1.y;

  float x2 = bottom_right1.x;
  float y2 = bottom_right1.y;

  float xx1 = top_left2.x;
  float yy1 = top_left2.y;

  float xx2 = bottom_right2.x;
  float yy2 = bottom_right2.y;
  if (x1 == x2 || y1 == y2 ||
    xx1 == xx2 || yy1 == yy2) {
    return false;
  }

  return !(x2 <= xx1 ||   // left
    x1 >= xx2 ||   // right
    y2 <= yy1 ||   // bottom
    y1 >= yy2);    // top
}
