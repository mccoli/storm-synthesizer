import processing.sound.*;

LowPass lowPass;

SinOsc low_sine;
SinOsc med_sine;
SinOsc high_sine;
SawOsc saw;

// sounds used
BrownNoise noise;
SoundFile thunder;
SoundFile rumble;
SoundFile taiko_sticks, taiko_short, taiko_med, taiko_deep;

// initialising visual cues
Shape centralShape;
Shape taikoSticksShape;
Shape taikoShortShape;
Shape taikoMedShape;
Shape taikoDeepShape;

// logic for showing visual cues
boolean isThunderPlaying = false;
boolean isTaikoSticksDrawn = false;
boolean isTaikoShortDrawn = false;
boolean isTaikoMedDrawn = false;
boolean isTaikoDeepDrawn = false;

boolean isSawPlaying = false;
boolean isMedSinePlaying = false;
boolean isHighSinePlaying = false;

float r, g, b;
float x, y;
float z = 0;

int time = 200;

void setup() {
  fullScreen(P3D);
  //size(400, 400, P3D);
  frameRate(200);
  //smooth();

  // create noise and play it
  noise = new BrownNoise(this);
  noise.play();
  lowPass = new LowPass(this);
  lowPass.process(noise, 10000);

  // loading sounds from data
  thunder = new SoundFile(this, "thunder.wav");
  thunder.amp(1);

  rumble = new SoundFile(this, "rumble.wav");
  rumble.play();

  taiko_sticks = new SoundFile(this, "taiko_sticks.wav");
  taiko_sticks.amp(1.0);
  taiko_short = new SoundFile(this, "taiko_short.wav");
  taiko_short.amp(1.0);
  taiko_med = new SoundFile(this, "taiko_med.wav");
  taiko_med.amp(1.0);
  taiko_deep = new SoundFile(this, "taiko_deep.wav");
  taiko_deep.amp(1.0);

  // create shape objects
  centralShape = new Shape(50, 10, 100);
  taikoSticksShape = new Shape(5, 20, 10);
  taikoShortShape = new Shape(10, 70, 30);
  taikoMedShape = new Shape(12, 7, 40);
  taikoDeepShape = new Shape(15, 3, 10);

  low_sine = new SinOsc(this);
  low_sine.freq(164.81);
  low_sine.play(); // constant low note because 3 keys at a time isnt possible
  med_sine = new SinOsc(this);
  med_sine.freq(246.94);
  high_sine = new SinOsc(this);
  high_sine.freq(277.18);
  saw = new SawOsc(this);
  saw.freq(87.31);
}

void draw() {
  background(0);
  
  // NOISE CONTROL
  // map mouseX from -1 to 1 for left to right
  noise.pan(map(mouseX, 0, width, -1.0, 1.0)); 
  // map mouseY from 0 to 0.3 for amplitude from bottom to top
  noise.amp(map(mouseY, 0, height, 0.3, 0.0));

  // map mouseY to amplitude
  rumble.amp(map(mouseY, 0, height, 1.0, 0.0));
  
  if (isSawPlaying == true) {
    saw.amp(map(mouseY, 0, height, 0.3, 0.0));
  }
  
  // VISUALS
  pushMatrix();
  translate(width/2, height/2);
  centralShape.draw(); 

  if (isThunderPlaying) {
    background(200);
  }

  if (isTaikoSticksDrawn) {
    taikoSticksShape.draw();
  }

  if (isTaikoShortDrawn) {
    taikoShortShape.draw();
  }

  if (isTaikoMedDrawn) {
    taikoMedShape.draw();
  }

  if (isTaikoDeepDrawn) {
    taikoDeepShape.draw();
  }  
  popMatrix();
}

// only make thunder if a key is pressed
void keyPressed() {  
  if (key == '1') {
    taiko_sticks.play();
    isTaikoSticksDrawn = !isTaikoSticksDrawn;
  }
  if (key == '2') {
    taiko_short.play();
    isTaikoShortDrawn = !isTaikoShortDrawn;
  }
  if (key == '3') {
    taiko_med.play();
    isTaikoMedDrawn = !isTaikoMedDrawn;
  }
  if (key == '4') {
    taiko_deep.play();
    isTaikoDeepDrawn = !isTaikoDeepDrawn;
  }
  if (key == '5') {
    thunder.play();
    isThunderPlaying = !isThunderPlaying;
  }
  if (key == '6') {
    isMedSinePlaying = !isMedSinePlaying;
    if (isMedSinePlaying == true) {
      med_sine.play();
      med_sine.amp(0.8);
    }
  }
  if (key == '7') {
    isHighSinePlaying = !isHighSinePlaying;
    if (isHighSinePlaying == true) {
      high_sine.play();
      high_sine.amp(0.8);
    }
  }
  if (key == '8') {
    isSawPlaying = !isSawPlaying;
    if (isSawPlaying == true) {
      saw.play();
      saw.amp(0.01);
    }
  }
}

void keyReleased() { 
  if (key == '1') {
    isTaikoSticksDrawn = !isTaikoSticksDrawn;
  }
  if (key == '2') {
    isTaikoShortDrawn = !isTaikoShortDrawn;
  }
  if (key == '3') {
    isTaikoMedDrawn = !isTaikoMedDrawn;
  }
  if (key == '4') {
    isTaikoDeepDrawn = !isTaikoDeepDrawn;
  }
  if (key == '5') {
    isThunderPlaying = !isThunderPlaying;
  } 
  if (key == '6') {
    isMedSinePlaying = !isMedSinePlaying;
    if (isMedSinePlaying == false) {
      med_sine.amp(0.0);
    }
  }
  if (key == '7') {
    isHighSinePlaying = !isHighSinePlaying;
    if (isHighSinePlaying == false) {
      high_sine.amp(0.0);
    }
  }
  if (key == '8') {
    isSawPlaying = !isSawPlaying;
    if (isSawPlaying == false) {
      saw.amp(0.0);
    }
  }
}
