import megamu.mesh.*;

int w = 800;   // canvas width
float r = w / 3;   // circle radius

int n = 1000;
float[][] points = new float[n][2];

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(w,w);
  background(255);
  smooth();
  
  for (int i = 0; i < n; i++) {
    float radius = random(3*r/4,r);
    float theta = random(PI*2);
    
    points[i][0] = radius * cos(theta);
    points[i][1] = radius * sin(theta);
  }
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 
  translate(width/2, height/2);

  // // Convex hull
  // stroke(0);
  // fill(255);
  // Hull perimeter = new Hull( points );
  // MPolygon region = perimeter.getRegion();
  // region.draw(this);

  // Voronoi
  Voronoi v = new Voronoi( points );
  MPolygon[] regions = v.getRegions();

  for (int i = 0; i < n; i++) {
    // Voronoi
    stroke(0);
    fill(255);
    regions[i].draw(this);

    // Individual points
    noStroke();
    fill(0);
    ellipseMode(CENTER);
    ellipse(points[i][0], points[i][1], 2, 2);
  }
  save("file.png");
} 
