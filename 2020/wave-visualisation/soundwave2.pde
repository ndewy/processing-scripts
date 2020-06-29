import java.util.ArrayList;
import java.util.List;
import processing.sound.*;
AudioIn in;
Amplitude amp;
Sound s;

float X_SCALE = 3;
List wave = new ArrayList();
float y;
float time;
float xscroll;
boolean doscroll;


void drawWave(){
  y = -amp.analyze()*5*height;
  wave.add(y);
  beginShape();
  noFill();
  for (int i=0; i < wave.size(); i++) {
    y = (float) wave.get(i);

    stroke(255, 255, 255);
    vertex(i*X_SCALE+xscroll+4*width/5, y+height/2);
  }
  endShape();
  xscroll += -X_SCALE;
  
  
}


  void setup() {
  background(0, 0, 0);
  size(1000, 1000);
  s = new Sound(this);
  amp = new Amplitude(this);
  in = new AudioIn(this, 1);
  in.start();
  amp.input(in);
  println(s.sampleRate());
}



void draw() {
    clear();
    drawWave();
    //GUI 
    
}
