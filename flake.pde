
public class Flake {

  private final static float size = 0.5;

  private PVector pos;
  private PVector vel;
  private PShape shape;
  public final static float noiseScale = 0.0001;
  

  public Flake() {
    reset();

    noStroke();
    fill(255);
    shape = createShape(SPHERE, size);
  }

  private void push(PVector forceVec) {
    vel.add(forceVec);
    vel.limit(5);
  }

  private void reset() {
    pos = new PVector(random(-snow.halfScreen, snow.halfScreen), random(-snow.halfScreen, snow.halfScreen) - snow.screenSize, random(-snow.halfScreen, snow.halfScreen));
    vel = new PVector(0, random(0, 1),0);
    vel.mult(random(0.1, 1));
  }


  public void tick() {
    PVector gravity = new PVector(0, 0.01,0);
    PVector dir = map1dto3dVec(noise((pos.x + snow.time) * noiseScale, pos.y * noiseScale, pos.z * noiseScale));
    
    dir.mult(0.02);
    dir.add(gravity);
    
    this.push(dir);
    
    pos.add(vel);
    if (pos.y > snow.halfScreen) {
      reset();
    }

    if (pos.x > snow.halfScreen) {
      reset();
      //pos.x = -snow.halfScreen;
    } else if (pos.x < -snow.halfScreen) {
            reset();
      //pos.x = snow.halfScreen;
    }

    if (pos.z > snow.halfScreen) {
            reset();
      //pos.z = -snow.halfScreen;
    } else if (pos.z < -snow.halfScreen) {
            reset();
      //pos.z = snow.halfScreen;
    }
  }

  public void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    shape(shape);
    popMatrix();
  }
}
  
  public static PVector map1dto3dVec(float num){
    int z = floor(num * 146250);
    int w = floor((sqrt((num * 8) + 1) - 1) / 2);
    int t = floor(0.5 * w * (w + 1));
    float phi_deg = z - t;
    float theta_deg = w - phi_deg;
    
    float phi = radians(phi_deg);
    float theta = radians(theta_deg);
    
    float x = sin(phi) * cos(theta);
    float y = sin(phi) * sin(theta);
    float _z = cos(phi);
    
    return new PVector(x, y, _z);
  }