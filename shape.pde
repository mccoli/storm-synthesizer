// class for different geometric shapes
class Shape {
  // properties
  int size; 
  int interAngle; // angle at the intersection of two lines 
  int radius;
  
  // initializer
  Shape(int _size, int _interAngle, int _radius) {
    this.size = _size;
    this.interAngle = _interAngle;
    this.radius = _radius;
  }
  
  // methods
  // basis of pulsing effect - https://forum.processing.org/two/discussion/7147/some-simple-pulse-equations-using-trig#latest
  void draw() {
    // pulse speed
    float time = millis() * 0.08;
    
    for(int i = 0; i < this.size; i++) {
      beginShape(LINES);
      
      r = map(cos(frameCount * 0.5), -1, 1, 50, 20);
      g = map(i, 0, this.size, 0, 80);
      b = map(cos(frameCount * 4), -1, 1, 0, 175);
      
      stroke(r, g, b);
      
      for(int j = 0; j < 500; j += this.interAngle) {
        this.radius = i * 8;
        
        x = this.radius * cos(j);
        y = this.radius * sin(j);
        z = pulse(time, 150);        
        vertex(x, y, z);
      }
    }
    endShape();
  }
  
  // factor represents the magnitude of the pulse
  float pulse(float value, float factor) {
    float t = radians(value);
    return sin(t)*factor;
  }
}
