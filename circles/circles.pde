import megamu.mesh.*;

int w = 800;   // canvas width
float r = w / 3;   // circle radius


int nreg = 4;
float[] bands = new float[2*(nreg+1)];

float pad = 10;

int n = 200;
// nreg+1 so that we have a boundary layer at the outer edge
float[][][] points = new float[nreg+1][n][2];
float[][] allpoints = new float[n*(nreg+1)][2];

int bg = 255;
float fg = random(255);
float[] shades = new float[nreg];

void setup() {
  size(w,w);
  smooth();
  background(bg);

  for (int i = 0; i < shades.length; i++) {
    shades[i] = random(255);
  }

  for (int i = 0; i < bands.length / 2; i++) {
    if (i == 0) { // first band
      bands[0] = pad;
      bands[1] = random(bands[0],r);
    } else if (i == bands.length - 2) { // last, padded band
        bands[2*i] = r;
        bands[2*i+1] = r+pad;
    } else if (i == bands.length - 4) { // second-to-last band
      bands[2*i] = bands[2*i-1] + pad;
      bands[2*i+1] = r;
    } else { // middle bands
      bands[2*i] = bands[2*i-1] + pad;
      bands[2*i+1] = random(bands[2*i], r);
    }
    println(bands[2*i]);
    println(bands[2*i + 1]);
  }

  for (int j = 0; j < nreg+1; j++) {
    for (int i = 0; i < n; i++) {
      float radius = random(bands[j],bands[j+1]);
      float theta = random(PI*2);

      allpoints[j*n + i][0] = radius * cos(theta);
      allpoints[j*n + i][1] = radius * sin(theta);
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
      // fill(random(255)); // uncomment for some crazy seizure-inducing colors
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
