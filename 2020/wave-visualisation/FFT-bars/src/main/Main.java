package main;

import processing.core.PApplet;
import g4p_controls.*;
import processing.sound.*;
import java.io.*;

public class Main extends PApplet {

    //Settings constants
    String MODE = "FFT";
    int BANDS = 256; // Must be a power of two
    int VOLUME = 100;
    int RADIUS = 100;
    float xCenter,yCenter;

    //GUI objects
    GButton btnPlay,btnStop,btnPause,btnOpen;

    //Sound processing objects
    SoundFile file;
    FFT fft;

    boolean fileSelected = false;
    float barWidth;
    float[] spectrum;

    @Override
    public void settings(){
        fullScreen();
    }

    @Override
    public void setup(){
        background(0,0,0);
        frameRate(30);
        //GUI Init
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

        fft = new FFT(this,BANDS);
        xCenter = width*0.75f;
        yCenter = height*0.25f;
        barWidth = width/BANDS;


    }
    @Override
    public void draw(){
        if (fileSelected){
            clear();
            spectrum  = fft.analyze();
            drawSpectrum();
            drawSpectrumCircle();
        }


    }

    public void handleBtnPlay(GButton button, GEvent event) {
        file.play();
    }
    public void handleBtnStop(GButton button, GEvent event) {
        file.stop() ;
    }
    public void handleBtnPause(GButton button, GEvent event) {
        file.pause();
    }
    public void handleBtnOpen(GButton button, GEvent event) {
        selectInput("Open a WAV or MP3 file:", "fileSelected");
    }

    public SoundFile loadSoundFile(String filedir){
        SoundFile file = new SoundFile(this,filedir);
        return file;
    }

    public void fileSelected(File selection) {
        if (selection == null) {
        }
        else {
            file = loadSoundFile(selection.getAbsolutePath());
            fileSelected = true;
            file.amp(VOLUME/100f);
            fft.input(file);

            btnPlay.setEnabled(true);
            btnStop.setEnabled(true);
            btnPause.setEnabled(true);
        }
    }

    public void drawSpectrum(){
        float[] data = spectrum.clone();
        for (int i=0;i<BANDS;i++)
        {
            float x1 = i*barWidth;
            float ystart = height*0.75f;
            float h = -data[i]*7000f;
            float r = map(i,0,BANDS,0,255);
            float g = map(i,0,BANDS,0,255);
            fill(r,g,255);
            noStroke();
            rect(x1,ystart,barWidth,h);
        }
    }

    public void drawSpectrumCircle(){
        float[] data = spectrum.clone();
        stroke(255,255,255);
        fill(255,255,255);
        beginShape();
        for (int i = 0;i<BANDS;i++){
            float angle = i*(360/BANDS);
            float amplitude = data[i]*800f;
            //float y1 = yCenter;
            float y2 = yCenter + (amplitude+RADIUS)*sin(angle);
            //float x1 = xCenter;
            float x2 = xCenter + (amplitude+RADIUS)*cos(angle);
            vertex(x2,y2);

        }
        endShape();

    }

}
