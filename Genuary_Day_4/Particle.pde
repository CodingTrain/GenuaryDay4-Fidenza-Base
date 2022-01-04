// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  boolean finished = false;

  ArrayList<PVector> history = new ArrayList<PVector>();

  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
  }

  void update() {
    history.add(pos.copy());
    pos.add(vel);
    //vel.limit(maxSpeed);
    //vel.add(acc);
    //acc.mult(0);
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void show() {
    stroke(0);
    noFill();
    strokeWeight(4);
    beginShape();
    for (PVector v : history) {
      vertex(v.x, v.y);
    }
    endShape();
  }

  void check(ArrayList<Particle> others) {
    if (!finished) {
      for (Particle other : others) {
        if (other != this) {
          for (PVector v : other.history) {
            float d = PVector.dist(pos, v);
            if (d < 8) {
              this.finished = true;
              return;
            }
          }
        }
      }
    }
  }


  void edges() {
    if (pos.x < 0 || pos.x > width-1 || pos.y < 0 || pos.y > height-1) {
      this.finished = true;
    }
  }
  //void updatePreviousPos() {
  //  this.previousPos.x = pos.x;
  //  this.previousPos.y = pos.y;
  //}

  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;
    this.vel = flowfield.vectors[index];
  }


  //void follow(FlowField flowfield) {
  //  int x = floor(pos.x / flowfield.scl);
  //  int y = floor(pos.y / flowfield.scl);
  //  int index = x + y * flowfield.cols;

  //  PVector force = flowfield.vectors[index];
  //  applyForce(force);
  //}
}
