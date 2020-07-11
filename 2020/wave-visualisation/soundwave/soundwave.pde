import java.util.ArrayList;
import java.util.List;
import processing.sound.*;
AudioIn in;
Amplitude amp;
Sound s;
void setup() {
  background(0,0,0);
  size(500,1000);
    s = new Sound(this);
    amp = new Amplitude(this);
    in = new AudioIn(this, 1);
    in.start();
    amp.input(in);
}

List wave = new ArrayList();
float y;
float time;
float xscroll;
boolean doscroll;
void draw() {
  clear();
  y = -amp.analyze()*10*height;
  wave.add(y);
  beginShape();
  noFill();
  for (int i=0; i < wave.size(); i++) {
     y = (float) wave.get(i);
     stroke(255,255,255);
     vertex(i*2+xscroll,y+height-10);
  }
  endShape();
  time += s.sampleRate();
  if ( wave.size() > 2*width/3){
    doscroll = true;
}
  if (doscroll){
  xscroll += -s.sampleRate();
}
}
