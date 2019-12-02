// genome walker – final project – antonio solano-roman
// artg2260 – programming basics – northeastern university
// a 2D walker that uses genetic sequences as input for generative graphics

// this sketch takes in a .txt or .fasta file corresponding to a viral nucleotide sequence
// composed mainly of As, Cs, Ts, and Gs that are transcribed into different coordinates in 2D space
// relatively large sequences (~ 1 million bp) or longer might require a lot of RAM or may not run at all
// with the current code. You may export as .tiff/png or .pdf, but note that pdf exports will take longer
// and are considerably larger, as they're composed of thousands/hundreds of thousands of individual SVG objects

import processing.core.PApplet;
import processing.pdf.*;

// data (these are just to try one virus)
String[] urls = {"iridescent_6.fasta"};
String[] names = {"Invertebrate iridescent virus 6"};


// most of the viruses
//String[] urls = {"norovirus.fasta", "sars_coronavirus.fasta", "zika.fasta", "dengue.fasta", "hep_e.fasta", "polio.fasta", "rotavirus_a.fasta", "mumps.fasta", "ebola_zaire.fasta", "marburg.fasta", "variola.fasta", "myxoma.fasta", "herpes_1.fasta", "african_swine_fever.fasta"};
//String[] names = {"Norwalk (Norovirus)", "SARS (Coronavirus)", "Zika virus", "Dengue virus", "Hepatitis E (Orthohepevirus A.)", "Polio (Human Poliovirus 1)", "Rotavirus A", "Mumps virus", "Ebola virus", "Marburg virus", "Smallpox (Variola virus)", "Myxoma virus", "Type 1 Herpes (Human alphaherpesvirus 1)", "African Swine Fever virus"};

// the very large sequences (300 000 to 1 M bp) Change variables: step = 0.1 and stepper (in Parser = 1);
//String[] urls = {"bacteria_phage.fasta", "iridescent_6.fasta", "cyprinid_herpes_3.fasta", "acanthamoeba.fasta"};
//String[] names = {"Enterobacteria phage RB43", "Invertebrate iridescent virus 6", "Koi Herpes virus 3 (Cyprinid herpesvirus 3)", "Acanthamoeba polyphaga mimivirus"};

String characters;
float step = 0.3;
float r, g, b;
Parser parser;
int textY = 15;

void setup() {
  //pixelDensity(displayDensity()); // only for raster exports (comment for pdf export)
  size(1200, 800);
  textMode(SHAPE); // only for pdf export
  background(color(#323232));
  parser = new Parser();

  for (int i = 0; i < urls.length; i++) {
    beginRecord(PDF, "art_" + names[i] + ".pdf");

    fill(color(#323232));
    noStroke();
    rect(0, 0, width, height);
    stroke(255, 255);

    parser.renderTitle(names[i]);
    characters = parser.parseFasta(urls[i]);
    shape(parser.createWalker(step, characters), 0, 0);

    endRecord(); //pdf

    //save(names[i] + "_art" + ".png");
  }
}

void draw() {
}