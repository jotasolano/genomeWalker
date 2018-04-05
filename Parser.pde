
class Parser {
  String fastaUrl;
  String[] fasta;
  String parsedFasta;
  char[] test = {'A', 'C', 'G', 'T'};
  char[] characters;
  char[] foo;
  PShape w; //w as in walker
  PGraphics pg = createGraphics(width, height);
  float x;
  float y;
  PFont font;
  int fontSize = 26;

  float[] positions;

  // load the fasta file
  // parse to only get nucleotides
  // return array of characters
  char[] parseFasta(String fastaUrl) {
    this.fastaUrl = fastaUrl;
    this.fasta = loadStrings(fastaUrl);
    this.parsedFasta = join(subset(fasta, 1), "");
    println(fastaUrl, parsedFasta.toCharArray().length);
    return this.characters = parsedFasta.toCharArray();
  }

  // take array of characters and create vertices
  // positioned according to the letters
  PShape createWalker(float step, char[] nucleotides) {
    x = 0;
    y = 0;
    w = createShape();
    w.beginShape();
    pushStyle();
    w.noFill();
    for (int i = 0; i < nucleotides.length; i++) {
      //x = 0;
      //y = 0;
      switch(nucleotides[i]) {
      case 'C':
        y -= step;
        break;
      case 'A':
        x += step;
        break;
      case 'G':
        y += step;
        break;
      case 'T':
        x -= step;
        break;
      }
      float t = radians(i);
      float x2 = x + t * cos(t); //play with t
      float y2 = y + t * sin(t);
      w.vertex(x, y);
    }
    w.endShape();
    popStyle();

    return w;
  }

  void renderSymbols(float step, char[] nucleotides) {
    colorMode(RGB);
    rectMode(CENTER);
    x = 2*width/3;
    y = height - 20;
    fill(0, 1);
    for (int i = 0; i < nucleotides.length; i++) {
      switch(nucleotides[i]) {
      case 'C':
        y = y - step;
        break;
      case 'A':
        x = x + step;
        noStroke();
        //fill(255, 0, 0, 100);
        //ellipse(x, y, 1, 1);
        break;
      case 'G':
        y = y + step;
        stroke(255, 0, 0, 5);
        line(x-3, y, x+3, y);
        //rect(x2, y2, 5, 5);
        break;
      case 'T':
        x = x - step;
        stroke(0, 0, 255, 5);
        line(x, y-5, x, y+5);
        break;
      }
    }
  }

  void renderTitle(String seqName) {
    font = createFont("PlayfairDisplay-Regular.ttf", fontSize);
    pushStyle();
    fill(50);
    textFont(font);
    textAlign(CENTER);
    text(seqName, width/2, 45);
    popStyle();
  }
}