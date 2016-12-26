import peasy.*;

private Flake[] flakes;
private PeasyCam cam;
public static final float screenSize = 250;
public static final float halfScreen = screenSize/2;
public static float time = 0;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 100);
  flakes = new Flake[1000];
  for (int i = 0; i < flakes.length; i++) {
    flakes[i] = new Flake();
  }
  frameRate(60);
}


void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  /*
  for (float x = -halfScreen; x < halfScreen; x+= 50) {
    for (float y = -halfScreen; y < halfScreen; y+= 50) {
      for (float z = -halfScreen; z < halfScreen; z+= 50) {
        //println(x + ":" + y + ":" + z);
        pushMatrix();
        translate(x, y, z);
        //PVector vec = PVector.random3D();
        //PVector vec = new PVector(0, 1, 0);
        
        PVector vec = map1dto3dVec(noise((x + snow.time) * Flake.noiseScale, y * Flake.noiseScale, z * Flake.noiseScale));
        vec.mult(5);
        line(0, 0, 0, vec.x, vec.y, vec.z);
        popMatrix();
      }
    }
  }
  */
  for (Flake flake: flakes){
   flake.tick();
   flake.draw();
   flake.push(new PVector(0,0.01,0));
  }
  pushMatrix();
  translate(0, screenSize, 0);
  box(screenSize);
  popMatrix();
  time += 0.1;
  println(frameRate + ":" + time);
}