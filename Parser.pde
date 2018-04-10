
class Parser {
  String fastaUrl;
  String[] fasta;
  String parsedFasta;
  char[] characters;
  PShape w; //w as in walker
  PShape lineParent;
  PGraphics pg = createGraphics(width, height);
  float x;
  float y;
  PFont font;
  int fontSize = 26;
  int a = 5;

  float[] positions;

  // load the fasta file, parse to only get nucleotides, return a String
  String parseFasta(String fastaUrl) {
    this.fastaUrl = fastaUrl;
    fasta = loadStrings(fastaUrl);
    parsedFasta = join(subset(fasta, 1), "");
    return parsedFasta;
  }

  // draw a "walker" by moving the x and y points based on the characters of the sequence
  PShape createWalker(float step, String nucleotides) {
    char[] nucleotidesChar = nucleotides.toCharArray();
    float mapA, mapC, mapG, mapT, mapStroke, minX, maxX, minY, maxY, halfX, halfY;
    ArrayList<PShape> lines = new ArrayList<PShape>(nucleotides.length());

    // initialize vars
    minX = width;
    minY = height;
    maxX = 0;
    maxY = 0;
    halfX = 0;
    halfY = 0;
    x = 0;
    y = 0;
    
    float colors[] = {170, 280, 338, 205};

    colorMode(HSB, 360, 100, 100, 100);
    //blendMode(ADD);

    // Create the shape group
    lineParent = createShape(GROUP);

    // Create the walker shape
    w = createShape();
    w.beginShape();
    w.strokeWeight(0.5);
    w.noFill();
    strokeWeight(30);
    for (int i = 0; i < nucleotides.length(); i++) {
      mapA = map(i, 0, nucleotides.length(), 170, 283);
      mapC = map(i, 0, nucleotides.length(), 0, 2*(360/4));
      mapG = map(i, 0, nucleotides.length(), 0, 3*(360/4));
      mapT = map(i, 0, nucleotides.length(), 0, 360);
      
      if (i < nucleotides.length()/2) {
        mapStroke = map(i, 0, nucleotides.length()/2, 3, 30);
      } else {
        mapStroke = map(i, nucleotides.length()/2, nucleotides.length(), 30, 3);
      }

      strokeWeight(mapStroke);

      switch(nucleotidesChar[i]) {
      case 'A':
        x += step; // right
        lines.add( createShape(LINE, x, y, x-3, y-3) );
        lines.get(i).setStroke(color(colors[0], 100, 100, a));
        break;

      case 'C':
        y -= step; // up
        lines.add( createShape(LINE, x, y, x+3, y-3) );
        lines.get(i).setStroke(color(colors[1], 100, 100, a));
        break;

      case 'G':
        y += step; // down
        lines.add( createShape(LINE, x, y, x+3, y+3) );
        lines.get(i).setStroke(color(colors[2], 100, 100, a));
        break;

      case 'T':
        x -= step; // left
        lines.add( createShape(LINE, x, y, x-3, y+3) );
        lines.get(i).setStroke(color(colors[3], 100, 100, a));
        break;

        // needed because I'm getting a weird outOfBounds error
        // probably a more elegant way to do this
        // i imagine there are some weird characters that make the index skip
      default: 
        lines.add( createShape(LINE, x, y, x, y) );
        lines.get(i).setStroke(color(#FFCC00, 0));
      }

      // Calculate bounding box
      if (x < minX) {
        minX = x;
      } else if (y < minY) {
        minY = y;
      } else if (x > maxX) {
        maxX = x;
      } else if (y > maxY) {
        maxY = y;
      }

      halfX = (abs(maxX) - abs(minX)) / 2;
      halfY = (abs(maxY) - abs(minY)) / 2;

      // Create vertices for the line walker 
      w.vertex(x, y);

      lineParent.addChild(lines.get(i));
    } // loop nucleotides

    w.endShape();
    w.setStroke(color(0, 10));
    //lineParent.addChild(w);

    // Position shape in center of the screen
    lineParent.translate(width/2 - halfX, height/2 - halfY);

    return lineParent;
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