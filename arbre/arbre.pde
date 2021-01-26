float PHI = 1.61803398875;

float angle = 0;
float deviation = 0;
int iterator = 0;
float numbers = 1;
void setup(){
    colorMode(HSB, TAU);
    size(1000, 1000);
    background(0);
    stroke(255);
    strokeWeight(1);
    
    
}

void draw(){
  //line(0, 0, width , height);
  color c = color(0, 0, 0);
  background(0);
  
  angle += TAU * 0.0005;
  
  if(mousePressed){
    if(mouseButton == RIGHT){
      numbers += 0.1;
    } else {
      deviation -= TAU * 0.001;
    }
  }
  for(float i = 0; i <= TWO_PI; i += TAU * (1.0 / numbers)){
    draw_line(width / 2, height / 2 , angle + i, deviation, 200, iterator, c);
  }
}

void draw_line(float x, float y, float angle, float deviation, float length, int iterations, color c){
  
  if(iterations != 0){
    iterations --;

    c = colorIncrement(c);
    stroke(c);
    float end_x = x + sin(angle)*length;
    float end_y = y + cos(angle)*length;
    line(x, y, end_x, end_y);
  
    
    
    length *= 0.5;
    //for(float i = 0; i <= TWO_PI; i += TAU * 0.1){}
    
    draw_line(end_x, end_y, angle + deviation, deviation,length, iterations, c);
    draw_line(end_x, end_y, angle - deviation, deviation, length, iterations, c );
  }
}

color colorIncrement(color c){
  colorMode(HSB, TAU);
  float hueBackground = (hue(c) + PHI * TAU) % TAU;
  color colorBackground = color(hueBackground, TAU, TAU);
  //println(hueBackground);
  //background(colorBackground);
  return colorBackground;
}

void mouseWheel(MouseEvent event){
  iterator -= event.getCount();
  if(iterator < 0){
    iterator = 0;
  }
}
