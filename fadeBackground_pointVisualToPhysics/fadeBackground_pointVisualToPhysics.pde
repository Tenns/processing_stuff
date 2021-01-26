PVector visualOffset;
PVector physicsOffset;

float unitLength;
float arrowScale = 10;



void setup(){
  size(1000, 1000, P2D);
  background(0);
  unitLength = 1;
  visualOffset = new PVector(0,0);
  physicsOffset = new PVector(0,0);
  ellipseMode(CENTER);


}

void draw(){
  background(0);
  
  renderPhysicsGrid(1, color(100));
  renderFrameRate();
  
}


void renderFrameRate(){
  fill(255);
  stroke(255);
  strokeWeight(2);
  textAlign(LEFT);
  text("framerate", 50, 65);
  text(frameRate, 50, 80);
}

void renderPhysicsGrid(float thickness, color Color){
  colorMode(HSB, 255);
  
  int avgBetweenBrightnessColorAndMax = int(   (brightness(Color) + 255)  * 0.5);
  
  color alternateGridColor = color(hue(Color), saturation(Color), avgBetweenBrightnessColorAndMax);
  float alternateGridThickness = thickness * 2;
  
  PVector PhysicsBottomLeftCornerOfScreen = pointVisualToPhysics(PVector(0, height));
  PVector PhysicsTopRightCornerOfScreen = pointVisualToPhysics(PVector(width, 0));

  float range = max(width, height) / unitLength; 
  int start = floor(min(PhysicsBottomLeftCornerOfScreen.x, PhysicsBottomLeftCornerOfScreen.y));
  float end = range + ceil(max(PhysicsTopRightCornerOfScreen.x, PhysicsTopRightCornerOfScreen.y));

  PVector physicsLineLength = PVector(  max(abs(start - PhysicsTopRightCornerOfScreen.x )  , abs(end - PhysicsBottomLeftCornerOfScreen.x) ),
                                 max(abs(start - PhysicsTopRightCornerOfScreen.y ), abs(end - PhysicsBottomLeftCornerOfScreen.y)    )); 

  PVector lineLength = vectorMult(physicsLineLength, unitLength);
        

  
  for(int i = start; i < end; i++){
      if(i % 5 == 0){
        stroke(alternateGridColor); 
        strokeWeight(alternateGridThickness);
      } else {
        stroke(Color);
        strokeWeight(thickness);
      }
      
      PVector PhysicsGridIntersection = new PVector(i, i);
      PVector visualGridIntersection = pointPhysicsToVisual(PhysicsGridIntersection);
      
      pushMatrix();
        translate(visualGridIntersection.x, visualGridIntersection.y);
        line(-lineLength.x, 0, lineLength.x, 0);
        line(0, lineLength.y, 0, -lineLength.y);
      popMatrix();
  }
  
  stroke(255); 
  strokeWeight(thickness * 3.0);
  PVector visualGridIntersection = pointPhysicsToVisual(PVector(0, 0));
  pushMatrix();
    translate(visualGridIntersection.x, visualGridIntersection.y);
    line(-lineLength.x, 0, lineLength.x, 0);
    line(0, lineLength.y, 0, -lineLength.y);
  popMatrix();
  
  
  
  colorMode(RGB, 255);
}

void renderCrosshair(){
  //white ellipse behind pink crosshair
    fill(255,255,255);
    noStroke();
     
    PVector location = pointPhysicsToVisual(  vectorMult(physicsOffset, -1)   );
    ellipse(location.x, location.y, 20, 20);
    println(pointVisualToPhysics(PVector(width/2, height/2)));
  
  //pink crosshair
    fill(255,0,255);
    stroke(255,0,255);
    strokeWeight(2);
    line(width/2 - 20, height/2, width/2 + 20, height/2);
    line(width/2, height/2 - 20, width/2, height/2 + 20);
    ellipse(width/2, height/2, 10, 10);
}

void fadeBackground(float rate){
  colorMode(HSB, 255);
  loadPixels();
  for(int i = 0; i < pixels.length; i++){
      pixels[i] = color(hue(pixels[i]), saturation(pixels[i]), int(rate * brightness(pixels[i])));
  }
  updatePixels();
  colorMode(RGB, 255);
}

void mouseDragged(){
  if(mouseButton == LEFT){
    int dx = mouseX - pmouseX;
    int dy = mouseY - pmouseY;
       
    visualOffset.add(PVector(dx, dy));
    physicsOffset.add(vectorMult(PVector(dx, - dy), 1/unitLength));
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  unitLength = unitLength + e * exp(-1/unitLength);
}

PVector pointPhysicsToVisual(PVector physicsPoint){
  return(PVector(unitLength * (physicsPoint.x + physicsOffset.x) + width/2, - unitLength * ( physicsPoint.y + physicsOffset.y ) + height/2 ));  
}

PVector pointVisualToPhysics(PVector visualPoint){
  return(PVector((visualPoint.x - width/2) / unitLength - physicsOffset.x, (height/2 -  visualPoint.y  ) / unitLength - physicsOffset.y ));
}


float atancorrect(float a1) {
  if (a1<0) return PI;
  if (a1>=0) return 0;
  // this would not be reached: 
  return 0;
}

PVector PVector(int x, int y){
  PVector Vector;
  
  Vector = new PVector(x, y);
  return Vector;
}

PVector PVector(float x, float y){
  PVector Vector;
  
  Vector = new PVector(x, y);
  return Vector;
}

PVector vectorMult(PVector vector, float scalar){
 return(PVector(scalar * vector.x, scalar * vector.y));
}

PVector vectorMult(PVector vector, int scalar){
 return(PVector(scalar * vector.x, scalar * vector.y));
}

PVector vectorDiv(PVector vector, float scalar){
 return(PVector(vector.x / scalar, vector.y / scalar));
}





//TYPE SETTING FUNCTIONS
  float sizeOfBlockText(float textSize, float margin, int numberOfLines){
    return( (textSize + margin) * (numberOfLines + 1));
  }
