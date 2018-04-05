class Background {
  PGraphics pg;
  int radius = width/2;


  void renderBackground() {
    //background(0, 255, 30);
    colorMode(HSB, 360, 100, 100);
    noStroke();
    ellipseMode(RADIUS);
    Gradient(width/2, height/2);
  }

  void Gradient(float x, float y) {
    //pg = createGraphics((int)x*2, (int)y*3);

    for (int r = radius; r > 0; --r) {
      float lightnes = map(r, 0, width, 100, 0);
      color c = color(0, 0, lightnes);
      //pg.beginDraw();
      fill(c);
      ellipse(x, y, r*2, r*3);
      //pg.endDraw();
    }

    //return pg;
  }
}