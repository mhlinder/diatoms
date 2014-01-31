import megamu.mesh.*;

int w = 800;

int nsq = 4; // number of squares across and down
int n = nsq*nsq; // total number of squares

float wsq = w / nsq; // width of each square
float r = .75*wsq/2; // radius of circle

float bg = random(255);

void setup() {
  size(w,w);

  smooth();
  background(bg);

  // create each individual circle
  for (int i=0; i < nsq; i++) {
    for (int j=0; j < nsq; j++) {
      translate(wsq*i + wsq/2, wsq*j + wsq/2);

      float fg = random(255);
      int npt = int(random(200,400));
      int nreg = int(random(2,5));
      println(npt);
      println(nreg);

      float[] shades = new float[nreg];
      for (int k=0; k < shades.length; k++) {
        shades[k] = random(255);
      }

      float[][] allpoints = new float[npt*(nreg+1)][2];
      float[] bands = new float[2*(nreg+1)];
      float pad = 5;

      for (int k = 0; k < bands.length / 2; k++) {
        if (k == 0) { // first band
          bands[0] = pad;
          bands[1] = random(bands[0],r);
        } else if (2*k == bands.length - 1) { // last, padded band
            bands[2*k] = r;
            bands[2*k+1] = r+pad;
        } else if (2*k == bands.length - 2) { // second-to-last band
          bands[2*k] = bands[2*k-1] + pad;
          bands[2*k+1] = r;
        } else { // middle bands
          bands[2*k] = bands[2*k-1] + pad;
          bands[2*k+1] = random(bands[2*k], r);
        }
      }

      for (int k = 0; k < nreg+1; k++) {
        for (int l = 0; l < npt; l++) {
          float radius = random(bands[k],bands[k+1]);
          float theta = random(PI*2);

          allpoints[k*npt + l][0] = radius * cos(theta); // + int(wsq*i + wsq/2);
          allpoints[k*npt + l][1] = radius * sin(theta); // + int(wsq*j + wsq/2);

          // ellipseMode(CENTER);
          // ellipse(allpoints[k*npt + l][0],allpoints[k*npt + l][1],2,2);
        }
      }

      Voronoi v = new Voronoi( allpoints );
      MPolygon[] regions = v.getRegions();

      for (int k = 0; k < nreg; k++) {
        for (int l = 0; l < npt; l++) {
          stroke(fg);
          fill(shades[k]);
          regions[l + k*npt].draw(this);
        }
      }

      translate(-(wsq*i + wsq/2), -(wsq*j + wsq/2));
    }
  }
  save("file.png");
}
