import processing.core.PApplet;
import processing.pdf.*;

String characters;
char[] char2;
String[] urls = {"ebola_zaire.fasta"};
//String[] urls = {"Mumps virus strain MuV-IA.fasta", "ebola_zaire.fasta", "dengue virus 1 isolate 00099-S.fasta", "variola_virus.fasta"};
String[] names = {"Mumps", "Ebola", "Dengue", "Variola Major"};
float step = 0.4;
float r, g, b;
Parser parser;
Background bg;
int textY = 15;

void setup() {
  size(1200, 800);
  background(color(#323232));
  parser = new Parser();
  bg = new Background();

  //beginRecord(PDF, "filename.pdf");
  //bg.renderBackground();


  for (int i = 0; i < urls.length; i++) {
    color id = color(60*i, 300, 80);
    stroke(id);

    characters = parser.parseFasta(urls[i]);
    shape(parser.createWalker(step, characters), 0, 0);
    
    //parser.renderSymbols(step, characters);

    fill(id);
    text(urls[i], 10, textY);
    textY += 20;
    
    //parser.renderTitle(names[0]);
  }
  //endRecord();
}

void draw() {
  noFill();
  // ERROR, running the shape here keeps drawing it nonstop!
  //shape(parser.createWalker(step, characters), 2*width/3, height - 20);
  //translate(width/2, height/2);
  //for (int i = 0; i < 10000; i++) {
  //  beginShape();
  //  float t = radians(i);
  //  float x = t*10 * cos(t);
  //  float y = t*10 * sin(t);
  //  vertex(x, y);
  //  endShape();
  //}
}