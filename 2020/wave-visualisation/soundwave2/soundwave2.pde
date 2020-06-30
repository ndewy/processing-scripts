import java.util.ArrayList;
import java.util.List;
import processing.sound.*;
import g4p_controls.*;
AudioIn in;
Amplitude amp;
Sound s;
SoundFile file;
GButton btnPlay,btnStop,btnPause,btnOpen;
float X_SCALE = 4;
float Y_RANGE = 200;
List wave = new ArrayList();
float y;
float time;
float xscroll;
boolean doscroll;


void drawWave(){
  y = -map(amp.analyze(),0,1,0,Y_RANGE);
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
  
 btnPlay = new GButton(this, 80, 0, 80, 40, "Play");
 btnPlay.addEventHandler(this,"handleBtnPlay");
 btnStop = new GButton(this,240,0,80,40,"Stop");
 btnStop.addEventHandler(this,"handleBtnStop");
 btnPause = new GButton(this,160,0,80,40,"Pause");
 btnPause.addEventHandler(this,"handleBtnPause");
 btnOpen = new GButton(this,0,0,80,40,"Open");
 btnOpen.addEventHandler(this,"handleBtnOpen");
 
 //There is no file loaded
 btnPlay.setEnabled(false);
 btnStop.setEnabled(false);
 btnPause.setEnabled(false);
 
 
  s = new Sound(this);
  amp = new Amplitude(this);
  //in = new AudioIn(this, 1);
  //in.start();
  //amp.input(in);
  println(s.sampleRate());
}



void draw() {
    clear();
    drawWave();
    print(amp.analyze());
    //GUI 
    
}


void handleBtnPlay(GButton button, GEvent event) {
  file.play();
}
void handleBtnStop(GButton button, GEvent event) {
 file.stop() ;
}
void handleBtnPause(GButton button, GEvent event) {
 file.pause(); 
}
void handleBtnOpen(GButton button, GEvent event) {
  selectInput("Open a WAV or MP3 file:", "fileSelected");
}
SoundFile loadSoundFile(String filedir){
  SoundFile file = new SoundFile(this,filedir);
  return file;
}

void fileSelected(File selection) {
  if (selection == null) {
  } 
  else {
    file = loadSoundFile(selection.getAbsolutePath());
    amp.input(file);
     btnPlay.setEnabled(true);
     btnStop.setEnabled(true);
     btnPause.setEnabled(true);
  }}
