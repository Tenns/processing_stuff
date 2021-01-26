float PHI = 1.61803398875;

color c = color(PHI * TAU - TAU, 60, 60);
//color c = color(0, 0, 0);

int notch = 0;
void setup(){
    //c = colorIncrement(c);
    ellipseMode(RADIUS);
    //colorMode(HSB, TAU, 100, 100);
    size(1000, 1000);
    
    background(c);
    strokeWeight(5);
    stroke(255);
    noFill();
    
}

void draw(){
  //line(0, 0, width , height);
  
  background(c);
  ellipse(width/2, height/2, 300, 300);
  notches(notch);
}

color colorIncrement(color c){
  colorMode(HSB, TAU, 100, 100);
  float hueBackground = (hue(c) + PHI * TAU) % TAU;
  float saturation = 60; //random(15, 100)
  float brightness = 60; //random(15, 100)
  color colorBackground = color(hueBackground, saturation, brightness);
  
  //println(hueBackground);
  //background(colorBackground);
  return colorBackground;
}
void notches(int n){
  pushMatrix();
  translate(width/2, height/2);
  notchMaker(n);
  
  popMatrix();
}
  
void notchMaker(int n){
  if(n != 0){
    n--;
    rotate(-PHI * TAU);
      pushMatrix();
      translate(300, 0);
      line(-30, 0, 30, 0);
    popMatrix();
    
    notchMaker(n);
  }
  
}

void mousePressed(){
  c = colorIncrement(c);
  notch++;
}
