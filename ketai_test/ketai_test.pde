import ketai.sensors.*;

KetaiSensor sensor;
float gravityX, gravityY, gravityZ;
float rotationX, rotationY, rotationZ;

void onGravityEvent(float x, float y, float z)
{
  gravityX= x;
  gravityY= y;
  gravityZ = z;
}
void onGyroscopeEvent(float x, float y, float z)
{
  rotationX += x;
  rotationY += y;
  rotationZ += z;
}

void setup(){
  fullScreen(P3D);  
  sensor = new KetaiSensor(this);
  sensor.start();
  rectMode(CENTER);
  
  
}

void draw(){
  background(0);
  lights();
  /*
  if(frameCount % 30 == 1){
    do{
    rando = new PVector(random(-100, 220), random(-100, 220), random(-100, 220));
    } while ((rando.mag() < 50) ||(rando.mag() > 100) ) ;
  }
  */
  //println(rotation);
  PVector rando = new PVector(gravityX, gravityY, gravityZ);
  rando.mult(10);
  float dr = frameCount * 0.01;
  
  float fov = PI / 3.0; 
  float cameraZ = (height/2.0) / tan(fov/2.0); 
  perspective(fov, float(width)/float(height), cameraZ/16.0, cameraZ*16.0); 

  translate(width/2, height/2, 0);
  //translate(0, 126);
  rotateY(HALF_PI);
  rotateX(HALF_PI);
  scale(-1, 1, 1);
  
  scale(10);
  
  rotateY((mouseY - height/2)* 0.01);
  rotateZ((mouseX - width/2)* 0.01);
  
  /*
  fill(255, 0, 255);
  vector3D(0, 0, 0, 100, 0, 0);

  fill(255, 255, 0);
  vector3D(0, 0, 0, 0, 100, 0);
  
  fill(0, 255, 255);  
  vector3D(0, 0, 0, 0, 0, 100);
  */
  
  stroke(200);
  drawGrid(0,0, 470, 10);
  
  
  stroke(255, 0, 255);
  line(0, 0, 0, 100, 0, 0);

  stroke(255, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  
  stroke(0, 255, 255);  
  line(0, 0, 0, 0, 0, 100);
  
  rotateZ(rotationZ);

  
  stroke(0);
  
  float trythis = acos(rando.z / rando.mag());
  rotateY(PI -trythis);
  /*
  fill(255, 0, 255);
  vector3D(0, 0, 0, 100, 0, 0);

  fill(255, 255, 0);
  vector3D(0, 0, 0, 0, 100, 0);
  
  fill(0, 255, 255);  
  vector3D(0, 0, 0, 0, 0, 100);
  */
  fill(20); 
  stroke(255);
  stroke(0);
  
  //float corr = 2 + mouseX / 100.0;
  
  //rotateY(HALF_PI);
  //rotateY( theta(rando));
  //rotateZ(-phi(rando));
  float test  = mouseX * 0.01;
  float angle = acos(rando.x / sqrt(rando.x * rando.x + rando.y * rando.y));
  if(rando.y > 0 ){
    rotateZ(-angle);
  } else {
    rotateZ(angle);
  }
  //  println(angle, test);
  

  fill(255); 
  stroke(255);

  vector3D(rando);
  
  //  println(angle, test);
  rotateX(rotationX);
  rotateY(rotationY);
  rotateZ(rotationZ);
  
  fill(255);
  stroke(100);
  //drawGrid(0,0, 470, 10);

  stroke(0);
  
  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);

  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  
  stroke(0, 0, 255);  
  line(0, 0, 0, 0, 0, 100);
  
  stroke(0);
  fill(140);
  
  box(30, 51, 5);
  
  /*
  fill(255, 0, 0);
  vector3D(0, 0, 0, 100, 0, 0);

  fill(0, 255, 0);
  vector3D(0, 0, 0, 0, 100, 0);
  
  fill(0, 0, 255);  
  vector3D(0, 0, 0, 0, 0, 100);
  */
  
  
  stroke(0);
  
  noStroke();
  sphere(5);
  
  stroke(0);
    
  fill(255, 0, 0);  
  pushMatrix();
    translate(150, 0, 0);
    box(10);
  popMatrix();
  fill(0, 255, 0);
  pushMatrix();
    translate(0, 150, 0);
    box(10);
  popMatrix();
  fill(0, 0, 255);
  pushMatrix();
    translate(0, 0, 150);
    box(10);  
  popMatrix();
}

void drawGrid(float posX, float posY, float size, int number){
  int rectModeOld = g.rectMode; 
  float halfSize = size * 0.5;
  
  pushMatrix();
    translate(posX, posY);
    
    switch(rectModeOld){ 
      case CORNER:
        break;
      case RADIUS:
        size = halfSize;
      case CENTER:
        translate(-halfSize, -halfSize);
        break;
    }
    
    rectMode(CORNER);
    noFill();
    
    float pixelsPerSquare = size / number;
    
      for(int i = 0; i < number; i++){
        pushMatrix();
        
          for(int j = 0; j < number; j++){
            rect(0, 0, pixelsPerSquare, pixelsPerSquare); 
            translate(0, pixelsPerSquare);
          }
        popMatrix();
        translate(pixelsPerSquare, 0);
      }
  popMatrix();
  rectMode(rectModeOld);
}

/**
cylinder taken from http://wiki.processing.org/index.php/Cylinder
@author matt ditton
@modified by Abbas Noureddine, to draw a cone with specified width, dimeter of both
top and bottom. (if top == bottom, then you have a cylinder)
plus added a translation to draw the cone at the center of the bottom side
*/
 
void cylinder(float bottom, float top, float h, int sides)
{
  pushMatrix();
  
  translate(0,h/2,0);
  
  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];
  
  float[] x2 = new float[sides+1];
  float[] z2 = new float[sides+1];
 
  //get the x and z position on a circle for all the sides
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * bottom;
    z[i] = cos(angle) * bottom;
  }
  
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x2[i] = sin(angle) * top;
    z2[i] = cos(angle) * top;
  }
 
  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);
 
  vertex(0,   -h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
  }
 
  endShape();
 
  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
 
  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN); 
 
  vertex(0,   h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x2[i], h/2, z2[i]);
  }
 
  endShape();
  
  popMatrix();
}

void arrow3D(float shaftRadius, float arrowLength, int sides){
  pushMatrix();
    rotateZ(HALF_PI);
    scale(-1);
    
    //50 is the height of the cone
    
    float coneRadius = 2 * shaftRadius;
    float shaftLength = max(arrowLength - 50, 0);
    float coneLength = 50;
    
    if(shaftLength == 0){
      coneRadius = coneRadius * arrowLength / 50;
      coneLength = arrowLength; 
    }
    
    cylinder(shaftRadius, shaftRadius, shaftLength, sides);
  
    pushMatrix();
      translate(0, shaftLength);
        
        cylinder(coneRadius, 0, coneLength, sides);
 
    popMatrix();
  popMatrix();
    
}

void vector3D(PVector origin, PVector end){
  PVector vec = PVector.sub(end , origin);
  float len = vec.mag();
  
  float phi = 0;
  if (vec.y != 0){
    phi = atan(vec.y / vec.x) -atancorrect(vec.x); //this is to get the sign of the angle too;
  }
  float theta = - asin(vec.z / len);
  
  //println(phi, theta);
  pushMatrix();
    translate(origin.x, origin.y);
    rotateZ(phi);
    rotateY(theta);
    arrow3D(5, len, 8);
  popMatrix();
  
}
void vector3D(float x1, float y1, float z1, float x2, float y2, float z2){
  vector3D(new PVector(x1, y1, z1), new PVector(x2, y2, z2));
  
}
void vector3D(PVector vectorAtOrigin){
  vector3D(new PVector(0, 0, 0), vectorAtOrigin);
  
}

float theta(PVector vector){
  float theta = - asin(vector.z / vector.mag());
  return theta;
}
float phi(PVector vector){
  float phi = atan(vector.y / vector.x) -atancorrect(vector.x);
  return phi;
}

float atancorrect(float a1) {
  if (a1<0) return PI;
  if (a1>=0) return 0;
  // this would not be reached: 
  return 0;
}
