import megamu.mesh.*;

int w = 800;   // canvas width
float r = w / 3;   // circle radius


int nreg = 8;
float[] bands = new float[nreg+1];

int n = 200;
float[][][] points = new float[nreg][n][2];

void setup() {
  size(w,w);
  background(255);
  smooth();

  for (int i = 0; i < bands.length; i++) {
    if (i == 0) { bands[i] = 0; }
    else if (i == bands.length - 1) { bands[i] = r; }
    else { bands[i] = random(bands[i-1], r); }
    println(bands[i]);
  }

  for (int j = 0; j < nreg; j++) {
    for (int i = 0; i < n; i++) {
      float radius = random(bands[j],bands[j+1]);
      float theta = random(PI*2);
      
      points[j][i][0] = radius * cos(theta);
      points[j][i][1] = radius * sin(theta);
    }
  }
}

void draw() { 
  translate(width/2, height/2);

  // // Convex hull
  // stroke(0);
  // fill(255);
  // Hull perimeter = new Hull( points );
  // MPolygon region = perimeter.getRegion();
  // region.draw(this);

  // // Voronoi
  // Voronoi v = new Voronoi( points );
  // MPolygon[] regions = v.getRegions();

  for (int j = 0; j < nreg; j++) {
    for (int i = 0; i < n; i++) {
      // // Voronoi
      // stroke(0);
      // fill(255);
      // regions[i].draw(this);

      // Individual points
      noStroke();
      fill(0);
      ellipseMode(CENTER);
      ellipse(points[j][i][0], points[j][i][1], 2, 2);
    }
  }
  // save("file.png");
} 
