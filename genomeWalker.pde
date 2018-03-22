import processing.core.PApplet;

char[] characters;
float step = 0.3;
Parser parser;

void setup() {
  size(800, 800);
  pixelDensity(displayDensity());
  parser = new Parser();

  characters = parser.parseFasta("ebola_zaire.fasta");
  shape(parser.createWalker(step, characters), 2*width/3, height - 20);
}

void draw() {
  noFill();
  // ERROR, running the shape here keeps drawing it nonstop!
  //shape(parser.createWalker(step, characters), 2*width/3, height - 20);
}