
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
  int fontSize = 18;
  int a = 5;
  float stepper = 3;

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
    float mapStroke, minX, maxX, minY, maxY, halfX, halfY;
    ArrayList<PShape> lines = new ArrayList<PShape>(nucleotides.length());
    PShape startMarker = createShape();
    float colors[] = {170, 280, 338, 205};

    // initialize vars
    minX = width;
    minY = height;
    maxX = 0;
    maxY = 0;
    halfX = 0;
    halfY = 0;
    x = 0;
    y = 0;

    colorMode(HSB, 360, 100, 100, 100);

    // Create the shape parent group
    lineParent = createShape(GROUP);

    // Create a cross to mark the start of the walker
    startMarker.beginShape(LINES);
    startMarker.strokeWeight(1);
    startMarker.vertex(x, y - 10);
    startMarker.vertex(x, y + 10);
    startMarker.vertex(x - 10, y);
    startMarker.vertex(x + 10, y);
    startMarker.endShape();
    startMarker.setStroke(color(255, 255));
    lineParent.addChild(startMarker);

    // Create the walker shape
    w = createShape();
    w.beginShape();
    w.strokeWeight(0.5);
    w.noFill();

    // Draw the "cloud" walker shape
    for (int i = 0; i < nucleotides.length(); i++) {

      if (i < nucleotides.length()/2) {
        mapStroke = map(i, 0, nucleotides.length()/2, 3, 30);
      } else {
        mapStroke = map(i, nucleotides.length()/2, nucleotides.length(), 30, 3);
      }

      strokeWeight(mapStroke);

      switch(nucleotidesChar[i]) {
      case 'A':
        x += step; // right
        lines.add( createShape(LINE, x, y, x-stepper, y-stepper) );
        lines.get(i).setStroke(color(colors[0], 100, 100, a));
        break;

      case 'C':
        y -= step; // up
        lines.add( createShape(LINE, x, y, x+stepper, y-stepper) );
        lines.get(i).setStroke(color(colors[1], 100, 100, a));
        break;

      case 'G':
        y += step; // down
        lines.add( createShape(LINE, x, y, x+stepper, y+stepper) );
        lines.get(i).setStroke(color(colors[2], 100, 100, a));
        break;

      case 'T':
        x -= step; // left
        lines.add( createShape(LINE, x, y, x-3, y+3) );
        lines.get(i).setStroke(color(colors[3], 100, 100, a));
        break;

        // needed because of corner cases when the program reads "ambiguous characters"
        // like Y, M, etc. "Y" for instance represents either A or C, hence the term ambiguous
      default: 
        lines.add( createShape(LINE, x, y, x, y) );
        lines.get(i).setStroke(color(0, 0));
      }

      // Calculate bounding box values
      if (x < minX) {
        minX = x;
      } else if (y < minY) {
        minY = y;
      } else if (x > maxX) {
        maxX = x;
      } else if (y > maxY) {
        maxY = y;
      }

      // Create vertices for the walker and line walker 
      w.vertex(x, y);
      lineParent.addChild(lines.get(i));
    } // loop nucleotides

    halfX = (abs(maxX) - abs(minX)) / 2;
    halfY = (abs(maxY) - abs(minY)) / 2;

    w.endShape();
    w.setStroke(color(0, 10));
    //lineParent.addChild(w); //if you want to see the actual walker

    // Position shape in center of the screen
    lineParent.translate(width/2 - halfX, height/2 - halfY);

    return lineParent;
  }


  void renderTitle(String seqName) {
    //font = createFont("PT_Serif-Web-Regular.ttf", fontSize);
    font = createFont("Lato-Bold.ttf", fontSize);
    pushStyle();
    fill(255, 255);
    textFont(font);
    textAlign(LEFT);
    text(seqName, 60, height - 60);
    popStyle();
  }
}