
class Parser {
  String fastaUrl;
  String[] fasta;
  String parsedFasta;
  char[] test = {'A', 'C', 'G', 'T'};
  char[] characters;
  char[] foo;
  PShape w; //w as in walker
  PShape lineParent, lineA;
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

    PShape[] lines = new PShape[nucleotides.length];
    
    float minX, maxX, minY, maxY, halfX, halfY;

    // Create the shape group
    lineParent = createShape(GROUP);

    // Create the walker shape
    w = createShape();

    minX = width;
    minY = height;
    maxX = 0;
    maxY = 0;
    halfX = 0;
    halfY = 0;
    x = 0;
    y = 0;

    //float mapStrokeCol = map();

    w.beginShape();
    pushStyle();
    w.noFill();
    for (int i = 0; i < nucleotides.length; i++) {
      switch(nucleotides[i]) {
      case 'A':
        x += step; // right
        lineA = createShape(LINE, x, y, x-20, y-20);
        lineA.setStroke(color(#FFCC00, 10+i));

        lines[i] = createShape(LINE, x, y, x-20, y-20);
        lines[i].setStroke(color(#FFCC00, 10+i));
        //lineA.setStrokeWeight(0.5);
        break;
      case 'C':
        y -= step; // up
        break;
      case 'G':
        y += step; // down
        break;
      case 'T':
        x -= step; // left
        break;
      }
      if (x < minX) {
        minX = x;
      } else if (y < minY) {
        minY = y;
      } else if (x > maxX) {
        maxX = x;
      } else if (y > maxY) {
        maxY = y;
      }

      // Calculate half of the bounding box
      halfX = (abs(maxX) - abs(minX)) / 2;
      halfY = (abs(maxY) - abs(minY)) / 2;


      lineParent.addChild(lines[i]);

      // Draw the walker
      w.vertex(x, y);
    }

    // Position shape in center of the screen
    w.translate(width/2 - halfX, height/2 - halfY);
    w.endShape();
    lineParent.translate(width/2 - halfX, height/2 - halfY);
    popStyle();

    return lineParent;
  }



  void renderSymbols(float step, char[] nucleotides) {
    rectMode(CENTER);
    x = 200;
    y = height/2;
    noFill();
    pushStyle();
    for (int i = 0; i < nucleotides.length; i++) {
      switch(nucleotides[i]) {
      case 'A':
        x = x + step;
        stroke(102, 194, 165, 5);
        line(0, 0, x-3, y-3);
        break;
      case 'C':
        y = y - step;
        stroke(252, 141, 98, 5);
        line(width, 0, x+3, y-3);
        break;
      case 'G':
        y = y + step;
        stroke(141, 160, 203, 5);
        line(width, height, x+3, y+3);
        break;
      case 'T':
        x = x - step;
        stroke(231, 138, 195, 5);
        line(0, height, x-3, y+3);
        break;
      }
    }
    popStyle();
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