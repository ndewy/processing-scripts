import java.util.ArrayList;
import java.util.List;
import processing.sound.*;
import g4p_controls.*;

//Parameters
float X_SCALE = 1;
float Y_RANGE = 80;
String MODE = "WAVE";
int BANDS = 8;


AudioIn in;
Amplitude amp;
FFT fft;
Sound s;
BandPass bandPass;
SoundFile file;
GButton btnPlay,btnStop,btnPause,btnOpen;
List wave = new ArrayList();
float y,time,xscroll;
float freq1,freq2,freq3;
boolean doscroll;
float[] spectrum = new float[BANDS];
color[] randomR = new color[BANDS];
color[] randomG = new color[BANDS];
color[] randomB = new color[BANDS];
boolean fileSelected = false;

void setup() {
  background(0, 0, 0);
  size(1000, 1000);
  
   //GUI 
   btnPlay = new GButton(this, 80, 0, 80, 40, "Play");
   btnPlay.addEventHandler(this,"handleBtnPlay");
   btnStop = new GButton(this,240,0,80,40,"Stop");
   btnStop.addEventHandler(this,"handleBtnStop");
   btnPause = new GButton(this,160,0,80,40,"Pause");
   btnPause.addEventHandler(this,"handleBtnPause");
   btnOpen = new GButton(this,0,0,80,40,"Open");
   btnOpen.addEventHandler(this,"handleBtnOpen");
   
   //There is no file selected on load, so trying to play it causes a null pointer.
   btnPlay.setEnabled(false);
   btnStop.setEnabled(false);
   btnPause.setEnabled(false);
   
   //Sound Analysis
    s = new Sound(this);
    amp = new Amplitude(this);
    fft = new FFT(this,BANDS);
    bandPass = new BandPass(this);
    //in = new AudioIn(this, 1);
    //in.start();
    //amp.input(in);
    
    //Setup for drawings
    switch (MODE){
      case "WAVEFFTCOLOURFUL":
        for (int i=0;i<BANDS;i++){
          randomR[i] = int(255-random(150));
          randomG[i] = int(255-random(150));
          randomB[i] = int(255-random(150));
          
    }
}
}

void draw() {
  if (fileSelected){
    switch(MODE){
      case "WAVE":
        clear();
        drawWave(amp.analyze(),height/2,255,255,255);
        break;
      case "WAVEFFTCLUSTERRAINBOW":
        clear();
        fft.analyze(spectrum);
        for (int i=0;i<BANDS;i++){
          drawWave(spectrum[i],height/2,int(255-random(150)),int(255-random(150)),int(255-random(150)));
      }
      break;
      case "WAVEFFTRAINBOW":
        clear();
        fft.analyze(spectrum);
        for (int i=0;i<BANDS;i++){
          drawWave(spectrum[i],(i+1)*height/BANDS,int(255-random(150)),int(255-random(150)),int(255-random(150)));
    }
    break;
    case "WAVEFFTCOLOURFUL":
      clear();
      fft.analyze(spectrum);
      for (int i=0;i<BANDS;i++){
          drawWave(spectrum[i],(i+1)*height/BANDS,randomR[i],randomG[i],randomB[i]);
    }
    break;
    case "DEBUGFFT":
    clear();
    fft.analyze(spectrum);
    println(spectrum);
    break;  
    }

  } 
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
    fileSelected = true;
    amp.input(file);
    fft.input(file);
     btnPlay.setEnabled(true);
     btnStop.setEnabled(true);
     btnPause.setEnabled(true);
  }
}

void drawWave(float amp,float offset,int r,int g,int b){
  //y= -amp;
  y = -map(amp,0,1,0,Y_RANGE);
  wave.add(y);
  beginShape();
  noFill();
  for (int i=0; i < wave.size(); i++) {
    y = (float) wave.get(i);

    stroke(r,g,b);
    vertex(i*X_SCALE+xscroll+4*width/5, y+offset);
  }
  endShape();
  xscroll += -X_SCALE;
  
}
