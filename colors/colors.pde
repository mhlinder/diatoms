import java.util.Map;

int h = 640;
int w = 480;

PImage img;
IntDict colors;

void setup() {
  size(1000,1000);
  noStroke();

  img = loadImage("catfur.JPG");
  img.resize(h, w);

  String c;
  colors = new IntDict();

  // loop over pixels
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {

      c = hex( img.get(i, j) );

      if ( colors.hasKey(c) ) {
        colors.set(c, colors.get(c) + 1);
      } else {
        colors.set(c, 1);
      }
    }
  }
  
  colors.sortValuesReverse();
  String[] hexes = colors.keyArray();

  color[] palette = new color[hexes.length];

  for (int i = 0; i < hexes.length; i++) {
    palette[i] = unhex(hexes[i]);
  }

  background(palette[0]);
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      fill(palette[i*100 + j]);
      rect(i*10 + 5, j*10 + 5, 10, 10);
    }
  }
  save("../misc/file12.png");
}
