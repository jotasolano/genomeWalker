
class Parser {
  String fastaUrl;
  String[] fasta;
  String parsedFasta;
  char[] test = {'A', 'C', 'G', 'T'};
  char[] characters;
  char[] foo;
  PShape w; //w as in walker
  float x;
  float y;

  // load the fasta file
  // parse to only get nucleotides
  // return array of characters
  char[] parseFasta(String fastaUrl) {
    this.fastaUrl = fastaUrl;
    this.fasta = loadStrings(fastaUrl);
    this.parsedFasta = join(subset(fasta, 1), "");
    return this.characters = parsedFasta.toCharArray();
  }

  // take array of characters and create vertices
  // positioned according to the letters
  PShape createWalker(float step, char[] nucleotides) {
    w = createShape();
    w.beginShape();
    pushStyle();
    w.noFill();
    for (int i = 0; i < nucleotides.length; i++) {
      switch(nucleotides[i]) {
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
      w.vertex(x, y);
    }
    w.endShape();
    popStyle();
    
    return w;
  }
}