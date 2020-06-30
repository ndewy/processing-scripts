import processing.sound.*;
import g4p_controls.*;
SoundFile file;
GButton btnPlay,btnStop,btnPause,btnOpen;

void setup(){
size(500,500);
background(0);
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
}

void draw(){ 
  
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
  selectInput("Open a file:", "fileSelected");
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
     btnPlay.setEnabled(true);
     btnStop.setEnabled(true);
     btnPause.setEnabled(true);
  }
}
