import java.util.ArrayList;
import java.util.List;

void setup() {
  background(0,0,0);
  size(500,500);
  
}

List wave = new ArrayList();
float y;
float time;
float xscroll;

void draw() {
  clear();
  y = 100 * cos(time);
  wave.add(y);
  beginShape();
  noFill();
  for (int i=0; i < wave.size(); i++) {
     y = (float) wave.get(i);
     stroke(255,255,255);
     vertex(i+xscroll,y+250);
  }
  endShape();
  time += 0.1;
  xscroll +=-0.1;
}
