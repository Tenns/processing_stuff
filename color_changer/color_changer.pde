float PHI = 1.61803398875;

color c = color(0, 0, 0);
void setup(){
    colorMode(HSB, TAU, 100, TAU);
    size(1000, 1000);
    background(0);
    stroke(255);
    strokeWeight(1);
    
    
}

void draw(){
  //line(0, 0, width , height);
  
  background(c);
}

color colorIncrement(color c){
  colorMode(HSB, TAU, 100, TAU);
  float hueBackground = (hue(c) + 1.5) % TAU;
  float saturation = random(0, 100);
  color colorBackground = color(hueBackground, random(0, 100), random(0, 100));
  println(saturation);
  //println(hueBackground);
  //background(colorBackground);
  return colorBackground;
}

void mousePressed(){
  c = colorIncrement(c);
  
}
