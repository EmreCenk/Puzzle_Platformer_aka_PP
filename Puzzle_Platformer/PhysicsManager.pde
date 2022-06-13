


class PhysicsManager {
  // A physics engine class


  //defining the types of objects that will be in this Physics Enginer
  ArrayList<Substance> objs;
  ArrayList<Circle> circles;
  ArrayList<PlayBlock> blocks;
  ArrayList<Platform> platforms;
  ArrayList<Prison> prisons;
  ArrayList<Pendulum> pendulums;
  ArrayList<Player> players;
  ArrayList<Domino> dominos;

  boolean universe_paused;

  PhysicsManager() {
    this.universe_paused = false;
    this.prisons = new ArrayList<Prison>();
    this.blocks = new ArrayList<PlayBlock>();
    this.players = new ArrayList<Player>();
    this.pendulums = new ArrayList<Pendulum>();
    this.objs = new ArrayList<Substance>();
    this.circles = new ArrayList<Circle>();
    this.platforms = new ArrayList<Platform>();
    this.dominos = new ArrayList<Domino>();
  }
  void pause() {
    this.universe_paused = true;
  }

  void unpause() {
    this.universe_paused = false;
  }
  void update_universe() {
    if (this.universe_paused) return;

    // moves universe forward by one timestamp
    this.set_jump_attributes();
    this.apply_friction_to_universe();
    this.apply_gravity_to_universe();
    this.update_positions_in_universe();
    this.apply_collision_in_universe();
    this.display_universe();
  }
  void set_jump_attributes() {
    // Everything is classified as in the jumping state initially. Only if they are directly or indirectly neighbours with some jumpable surface they can jump
    for (int i = 0; i<this.players.size(); i++) {
      this.players.get(i).jumping = true;
    }

    for (int i = 0; i<this.blocks.size(); i++) {
      this.blocks.get(i).jumping = true;
    }
  }
  void apply_collision_in_universe() {
    // circle collision
    for (int i = 0; i < this.objs.size(); i++) {
      for (int j = i+1; j < this.objs.size(); j++) {
        this.objs.get(i).collide(this.objs.get(j));
      }
    }

    //keeping things above and below platforms:
    for (int i = 0; i < this.platforms.size(); i++) {
      for (int j = 0; j < this.objs.size(); j++) {
        this.platforms.get(i).keep_object_outside(this.objs.get(j));
      }

      for (int j = 0; j<this.blocks.size(); j++) {
        this.platforms.get(i).keep_object_outside(this.blocks.get(j));
      }

      for (int j = 0; j<this.players.size(); j++) {
        this.platforms.get(i).keep_object_outside(this.players.get(j));
      }
    }

    //prison imprisonment
    for (int i = 0; i < this.prisons.size(); i++) {
      for (int j = 0; j < this.objs.size(); j++) {
        this.prisons.get(i).imprison(this.objs.get(j));
      }
      for (int j = 0; j<this.blocks.size(); j++) {
        this.prisons.get(i).imprison(this.blocks.get(j));
      }
    }

    //pendulum collision
    for (int i = 0; i < this.pendulums.size(); i++) {
      for (int j = 0; j < this.objs.size(); j++) {
        this.pendulums.get(i).collide(this.objs.get(j));
      }
      for (int j = 0; j<this.blocks.size(); j++) {
        this.pendulums.get(i).collide(this.blocks.get(j));
      }
    }

    //block collision
    for (int i = 0; i < this.blocks.size(); i++) {
      for (int j = 0; j < this.players.size(); j++) {
        this.blocks.get(i).keep_object_outside(this.players.get(j));
      }

      for (int j = i + 1; j < this.blocks.size(); j++) {
        this.blocks.get(i).keep_object_outside(this.blocks.get(j));
      }
    }
  }



  void display_universe() {
    // displays every object added to the engine
    for (int i = 0; i < this.objs.size(); i++) {
      this.objs.get(i).display();
    }
    for (int i = 0; i < this.platforms.size(); i++) {
      this.platforms.get(i).display();
    }
    for (int i = 0; i<this.dominos.size(); i++) {
      this.dominos.get(i).display();
    }

    for (int i = 0; i < this.pendulums.size(); i++) {
      this.pendulums.get(i).display();
    }
    for (int i = 0; i < this.blocks.size(); i++) {
      this.blocks.get(i).display();
    }
  }

  void apply_gravity_to_universe() {
    /* 
     we use a = g as our acceleration and derive a formula to find the new velocity
     a = g m/s^2 (since down is positive on the screen)
     v1 = vy
     t = 1/FPS
     v2 = ?
     
     a = (v2-v1)/t
     v2 = a*t + v1
     v2 = 9.81/FPS + vy
     */

    // loops through every object, checks if they're effected by gravity
    // if they are, it accelerates them

    float f = 60; // framerate
    for (int i = 0; i < this.objs.size(); i++) {
      if (!this.objs.get(i).effected_by_gravity) continue;
      //println(this.objs.get(i), this.objs.get(i).effected_by_gravity);
      this.objs.get(i).velocity.y += g/f; // gravity
    }

    for (int i = 0; i < this.blocks.size(); i++) {
      if (!this.blocks.get(i).effected_by_gravity) continue;
      this.blocks.get(i).velocity.y += g/f; // gravity
    }
    for (int i = 0; i < this.platforms.size(); i++) {
      if (!this.platforms.get(i).effected_by_gravity) continue;
      this.platforms.get(i).velocity.y += g/f; // gravity
    }
    for (int i = 0; i < this.pendulums.size(); i++) {
      pendulums.get(i).swing();
    }
    for (int i = 0; i < this.dominos.size(); i++) {
      this.dominos.get(i).move();
    }
  }
  void apply_friction_to_universe() {
    // loops through all objects and applies friction
    for (int i = 0; i < this.objs.size(); i++) {
      this.slow_down_object(this.objs.get(i));
      if (abs(this.objs.get(i).velocity.x) < epsilon) this.objs.get(i).velocity.x = 0;
    }
    for (int i = 0; i < this.blocks.size(); i++) {
      this.slow_down_object(this.blocks.get(i));
      if (abs(this.blocks.get(i).velocity.x) < epsilon) this.blocks.get(i).velocity.x = 0;
    }
    for (int i = 0; i < this.platforms.size(); i++) {
      this.slow_down_object(this.platforms.get(i));
      if (abs(this.platforms.get(i).velocity.x) < epsilon) this.platforms.get(i).velocity.x = 0;
    }
  }


  void slow_down_object(Substance obj) {
    // slows down a single object
    float friction_acceleration = DEFAULT_MU * g;
    if (obj.velocity.x < 0) obj.velocity.x = min(0, obj.velocity.x + friction_acceleration);
    else obj.velocity.x = max(0, obj.velocity.x - friction_acceleration);
    obj.velocity.x *= 0.99; // friction
  }

  void update_positions_in_universe() {
    // moves all objects

    // note: the logic of this engine is that basically every external function only changes the velocity of the objects
    // here, those velocities change the position

    for (int i = 0; i < this.objs.size(); i++) {
      this.objs.get(i).move();
    }

    for (int i = 0; i < this.blocks.size(); i++) {
      this.blocks.get(i).move();
    }
    for (int i = 0; i < this.platforms.size(); i++) {
      this.platforms.get(i).move();
    }
  }


  // A BUNCH OF CODE TO ADD OBJECTS TO THE ENGINE:
  void add_obj(Substance some_object) {
    this.objs.add(some_object);
  }
  void add_circle(Circle circ) {
    this.circles.add(circ);
    this.add_obj(circ);
  }
  void add_block(PlayBlock block) {
    this.blocks.add(block);
  }
  void add_platform(Platform plt) {
    this.platforms.add(plt);
  }
  void add_prison(Prison prison) {
    this.prisons.add(prison);
  }
  void add_pendulum(Pendulum pendulum) {
    this.pendulums.add(pendulum);
  }

  void add_domino(Domino d) {
    this.dominos.add(d);
  }
  void add_player(Player pl) {
    this.players.add(pl);
    this.objs.add(pl);
  }



  //FOLLOWING FUNCTION IS LEGACY CODE, IT IS NOT USED ANYMORE
  // (it's implements continous collision detection for player-block collision)
  // however, I just added terminal velocities to prevent things teleporting through each other
  // since nothing can go too fast, then there is no need for continous collision
  void block_collision() {
    //block collision
    PVector intersection, top_left, bottom_right, prev_top, prev_bot, temp_bottom_right, temp_top_left;
    float[] d1, d2, d3, d4;
    float dd1, dd2, min_d;
    PVector closest_player, closest_block; // coordinates for when the player and block are closest to each other
    Substance collision_to_process = new Substance();
    float min_dist_collision = INFINITY;

    for (int i = 0; i < this.blocks.size(); i++) {
      top_left = new PVector(this.blocks.get(i).coordinate.x - this.blocks.get(i).width_/2, this.blocks.get(i).coordinate.y - this.blocks.get(i).height_/2);
      bottom_right = new PVector(this.blocks.get(i).coordinate.x + this.blocks.get(i).width_/2, this.blocks.get(i).coordinate.y + this.blocks.get(i).height_/2);
      min_dist_collision = INFINITY;
      collision_to_process = null;

      for (int j = 0; j < this.players.size(); j++) {

        prev_top = new PVector(this.blocks.get(i).previous_coordinate.x - this.blocks.get(i).width_/2, this.blocks.get(i).previous_coordinate.y - this.blocks.get(i).height_/2);
        prev_bot = new PVector(this.blocks.get(i).previous_coordinate.x + this.blocks.get(i).width_/2, this.blocks.get(i).previous_coordinate.y + this.blocks.get(i).height_/2);

        //continous detection
        intersection = get_line_segment_intersection(this.blocks.get(i).coordinate, this.blocks.get(i).previous_coordinate, 
          this.players.get(j).coordinate, this.players.get(j).previous_coordinate);
        if (intersection != null) {
          //println("INTERSECTING1", frameCount);
          continue;
        }

        // 
        dd1 = dist(this.blocks.get(i).coordinate.x, this.blocks.get(i).coordinate.y, this.players.get(j).coordinate.x, this.players.get(j).coordinate.y);
        dd2 = dist(this.blocks.get(i).previous_coordinate.x, this.blocks.get(i).previous_coordinate.y, this.players.get(j).previous_coordinate.x, this.players.get(j).previous_coordinate.y); 

        d1 = closest_distance_from_point_to_line_segment(this.blocks.get(i).coordinate, this.players.get(j).coordinate, this.players.get(j).previous_coordinate);
        d2 = closest_distance_from_point_to_line_segment(this.blocks.get(i).previous_coordinate, this.players.get(j).coordinate, this.players.get(j).previous_coordinate);

        d3 = closest_distance_from_point_to_line_segment(this.players.get(j).coordinate, this.blocks.get(i).coordinate, this.blocks.get(i).previous_coordinate);
        d4 = closest_distance_from_point_to_line_segment(this.players.get(j).previous_coordinate, this.blocks.get(i).coordinate, this.blocks.get(i).previous_coordinate);

        min_d = min(min(min(min(min(dd1, dd2), d1[0]), d2[0]), d3[0]), d4[0]); // apparently you can't have more than 2 arguments into the min() function

        if (abs(min_d - dd1) < epsilon) {
          closest_player = new PVector(this.players.get(j).coordinate.x, this.players.get(j).coordinate.y);
          closest_block = new PVector(this.blocks.get(i).coordinate.x, this.blocks.get(i).coordinate.y);
        } else if (min_d == dd2) {
          closest_player = new PVector(this.players.get(j).previous_coordinate.x, this.players.get(j).previous_coordinate.y);
          closest_block = new PVector(this.blocks.get(i).previous_coordinate.x, this.blocks.get(i).previous_coordinate.y);
        } else if (min_d == d1[0]) {
          closest_player = new PVector(d1[1], d1[2]);
          closest_block = new PVector(this.blocks.get(i).coordinate.x, this.blocks.get(i).coordinate.y);
        } else if (min_d == d2[0]) {
          closest_player = new PVector(d2[1], d2[2]);
          closest_block = new PVector(this.blocks.get(i).previous_coordinate.x, this.blocks.get(i).previous_coordinate.y);
        } else if (min_d == d3[0]) {
          closest_player = new PVector(this.players.get(j).coordinate.x, this.players.get(j).coordinate.y);
          closest_block = new PVector(d3[1], d3[2]);
        } else if (min_d == d4[0]) {
          closest_player = new PVector(this.players.get(j).previous_coordinate.x, this.players.get(j).previous_coordinate.y);
          closest_block = new PVector(d4[1], d4[2]);
        } else {
          closest_block = new PVector();
          closest_player = new PVector();
          //println("oh fuck");
          stop();
        }
        //println("ya");
        temp_top_left = new PVector(closest_block.x - this.blocks.get(i).width_/2, closest_block.y - this.blocks.get(i).height_/2);
        temp_bottom_right = new PVector(closest_block.x + this.blocks.get(i).width_/2, closest_block.y + this.blocks.get(i).height_/2);
        // todo: check time of collision and make sure they actually collide 
        if (circle_in_rect(temp_top_left, temp_bottom_right, closest_player, this.players.get(j).radius, 1)) {
          //println("INTERSECTING2", frameCount);
          if (dist(closest_player.x, closest_player.y, closest_block.x, closest_block.y) < min_dist_collision) {
            min_dist_collision = dist(closest_player.x, closest_player.y, closest_block.x, closest_block.y); // dist technically computed twice but I can't be bothered to put it in a variable
            collision_to_process = this.players.get(j);
          }
        }
      }

      for (int j = 0; j < this.platforms.size(); j++) {
        //this is collision is easier since platforms don't move
        temp_top_left = new PVector(this.platforms.get(j).coordinate.x - this.platforms.get(j).width_/2, this.platforms.get(j).coordinate.y - this.platforms.get(j).height_/2);
        temp_bottom_right = new PVector(this.platforms.get(j).coordinate.x + this.platforms.get(j).width_/2, this.platforms.get(j).coordinate.y + this.platforms.get(j).height_/2);
        if (rectangles_overlap(top_left, bottom_right, temp_top_left, temp_bottom_right)) {
          float ds = min(min(min(
            abs(temp_top_left.x - this.blocks.get(i).coordinate.x), 
            abs(temp_bottom_right.x - this.blocks.get(i).coordinate.x)), 
            abs(temp_top_left.y - this.blocks.get(i).coordinate.y)), 
            abs(temp_bottom_right.y - this.blocks.get(i).coordinate.y));

          if (ds < min_dist_collision) {
            min_dist_collision = ds;
            collision_to_process = this.platforms.get(j);
          }
        }
      }
      if (collision_to_process == null) continue;

      if (collision_to_process instanceof Platform) {
        elastic_collision_2d(collision_to_process, this.blocks.get(i));
        collision_to_process.velocity = new PVector(0, 0);
      } else if (collision_to_process instanceof Player) {
        this.blocks.get(i).keep_object_outside(collision_to_process);
        //        float magnitude = this.blocks.get(i).width_/2 + collision_to_process.radius - dist(collision_to_process.coordinate.x,
        //                                                                                                       collision_to_process.coordinate.y,
        //                                                                                                       this.blocks.get(i).coordinate.x,
        //                                                                                                       this.blocks.get(i).coordinate.y);
        //        PVector w = polar_to_cartesian(magnitude, atan2(collision_to_process.velocity.y, collision_to_process.velocity.x));
        //        collision_to_process.change_position(new PVector(collision_to_process.coordinate.x - w.x, collision_to_process.coordinate.y - w.y));
        //        collision_to_process.jumping = this.blocks.get(i).jumping;
        //        this.blocks.get(i).player_activated(collision_to_process);

        //        float [] y_components = elastic_collision_1d(this.blocks.get(i).mass, this.blocks.get(i).velocity.y, collision_to_process.mass, collision_to_process.velocity.y);      
        //        this.blocks.get(i).velocity.y = y_components[0];
        //        collision_to_process.velocity.y = y_components[1];


        //elastic_collision_2d(collision_to_process, this.blocks.get(i));
      } else elastic_collision_2d(collision_to_process, this.blocks.get(i));
    }
  }
}
