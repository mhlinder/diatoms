import java.util.Map;

int h = 640;
int w = 480;

PImage img;
IntDict colors;

void setup() {
  size(900,900);
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
  for (int i = 0; i < 30; i++) {
    for (int j = 0; j < 30; j++) {
      fill(palette[i*30 + j]);
      rect(i*30 + 5, j*30 + 5, 10, 10);
    }
  }
}
