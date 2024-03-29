// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

public class FlowField {
  PVector[] vectors;
  int cols, rows;
  float inc = 0.02;
  float zoff = 0;
  int scl;

  FlowField(int res) {
    scl = res;
    cols = floor(width / res) + 1;
    rows = floor(height / res) + 1;
    vectors = new PVector[cols * rows];
  }
  void update() {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        // float angle = noise(xoff, yoff, zoff) * TWO_PI;
        //float  n = (float) noise.eval(xoff, yoff, zoff);
        float  n = (float) noise.eval(xoff, yoff);
        float angle = map(n, -1, 1, 0, TWO_PI);
        PVector v = PVector.fromAngle(angle);
        // v.setMag(scl);
        int index = x + y * cols;
        vectors[index] = v;

        xoff += inc;
      }
      yoff += inc;
    }
    // zoff += 0.004;
  }
  void display() {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        int index = x + y * cols;
        PVector v = vectors[index];

        stroke(0);
        strokeWeight(2);
        pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        line(0, 0, scl, 0);
        popMatrix();
      }
    }
  }
}
