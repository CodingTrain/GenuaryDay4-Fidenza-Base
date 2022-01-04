// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in
//
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

FlowField flowfield;
ArrayList<Particle> particles;

boolean debug = false;
OpenSimplexNoise noise = new OpenSimplexNoise();


void setup() {
  size(1280, 720);
  int res = 8;
  flowfield = new FlowField(res);
  flowfield.update();

  particles = new ArrayList<Particle>();
  //for (int i = 0; i < width; i+=res) {
  //  for (int j = 0; j < width; j+=res) {
  for (int i = 0; i < 1000; i++) {
    PVector start = new PVector(random(width), random(height));
    particles.add(new Particle(start, 5));
  }
  //  }
  //}
}

void mousePressed() {
  debug = !debug;
}

void draw() {
  background(255);
  flowfield.update();

  if (debug) flowfield.display();

  for (Particle p : particles) {
    p.edges();
    p.check(particles);
    if (!p.finished) {
      p.follow(flowfield);
      p.update();
    }
    p.show();
  }
}
