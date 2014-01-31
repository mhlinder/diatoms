import megamu.mesh.*;

int w = 800;

int nsq = 4; // number of squares across and down
int n = nsq*nsq;

float wsq = w / nsq;

void setup() {
  size(w,w);
  smooth();
  background(255);
  noStroke();
  fill(0);
}

void draw() {
  for (int i=0; i < nsq; i++) {
    for (int j=0; j < nsq; j++) {
      ellipse(wsq*i+.5*wsq, wsq*j+.5*wsq, .75*wsq, .75*wsq);
    }
  }
}
