float a = 0;
float r = 0;
PVector old = new PVector(0, 0);
PVector current = new PVector(0, 0);


void setup() {
 frameRate(60);
 size(500,500); 
 background(0);
 
 ellipseMode(RADIUS);
}

void draw() {
  translate(width/2, height/2);
  
  background(0);
  noStroke();
  
  float thiccness = 10;
  float spiralSize = dist(0, 0, current.x, current.y);
  
  fill(255, 0, 0);
  ellipse(0, 0, spiralSize + thiccness/2, spiralSize + thiccness/2);

  a = 0;
  r = 0;
  
  int i = 1; 
  while(frameCount > i){
    current.set(r*cos(a),r*sin(a));

    line(old.x, old.y, current.x, current.y);
    
  //  we set the stroke and weight after drawing the first line,
  //  because the first line links the last point of this frame's spiral to (0,0)
  
    stroke(255);
    strokeWeight(thiccness);
    
    
  //  stroke(0);
  //  strokeWeight(exp(r*0.001));
  //  point(current.x, current.y);
    
  //  println(old.x, old.y, current.x, current.y);
    println(current.x, current.y);
  
    old.set(r*cos(a),r*sin(a));

    a = a + 0.1;
    r = r + 0.003*i;
    
    i++;
  }
  //saveFrame("Frame "+frameCount+".png");
}
