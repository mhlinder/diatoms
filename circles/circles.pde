import megamu.mesh.*;

int w = 800;   // canvas width
float r = w / 3;   // circle radius


int nreg = 2;
float[] bands = new float[nreg+2];

int n = 200;
// nreg+1 so that we have a boundary layer at the outer edge
float[][][] points = new float[nreg+1][n][2];
float[][] allpoints = new float[n*(nreg+1)][2];

int bg = 255;
int fg = 0;
int[] shades = {100, 200};

void setup() {
  size(w,w);
  background(bg);
  smooth();

  for (int i = 0; i < bands.length; i++) {
    if (i == 0) { bands[i] = 0; }
    else if (i == bands.length - 2) { bands[i] = r; }
    // add a pad layer just outside the boundary
    else if (i == bands.length - 1) { bands[i] = r + 10; }
    else { bands[i] = random(bands[i-1], r); }
    println(bands[i]);
  }

  for (int j = 0; j < nreg+1; j++) {
    for (int i = 0; i < n; i++) {
      float radius = random(bands[j],bands[j+1]);
      float theta = random(PI*2);
      
      points[j][i][0] = radius * cos(theta);
      points[j][i][1] = radius * sin(theta);

      allpoints[j*n + i][0] = points[j][i][0];
      allpoints[j*n + i][1] = points[j][i][1];
    }
  }
}

void draw() { 
  translate(width/2, height/2);

  // Voronoi
  Voronoi v = new Voronoi( allpoints );
  MPolygon[] regions = v.getRegions();

  for (int j = 0; j < nreg; j++) {
    for (int i = 0; i < n; i++) {
      // Voronoi
      stroke(fg);
      fill(shades[j]);
      regions[i+j*n].draw(this);

      // // Individual points
      // noStroke();
      // fill(fg);
      // ellipseMode(CENTER);
      // ellipse(allpoints[i+j*n][0], allpoints[i+j*n][1], 2, 2);
    }
  }
  // save("file.png");
} 
