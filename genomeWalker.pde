import processing.core.PApplet;


String[] fasta;
String parsedFasta;
char[] test = {'A', 'C', 'G', 'T'};
char[] characters;
char[] foo;
int step = 2; 
PShape w; //w as in walker
int x;
int y;


void setup() {
  size(800, 800);
  pixelDensity(displayDensity());
  x = 0;
  y = 0;
  fasta = loadStrings("ebola_zaire.fasta");
  parsedFasta = join(subset(fasta, 1), "");
  
  
  println(parsedFasta);
  characters = parsedFasta.toCharArray();
  println(test);

  w = createShape();
  w.beginShape();
  w.noFill();
  for (int i = 0; i < characters.length; i++) {
    switch(characters[i]) {
    case 'A':
      y = y - step;
      break;
    case 'C':
      x = x + step;
      break;
    case 'G':
      y = y + step;
      break;
    case 'T':
      x = x - step;
      break;
    }
    //println(x, y);
    w.vertex(x, y);
  }
  w.endShape();
}

void draw() {
  noFill();
  stroke(255, 0, 0);
  shape(w, width - 20, height - 20);
}