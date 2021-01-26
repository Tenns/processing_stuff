
float unitLength;

void setup(){
  size(1000, 1000);
  background(0);
  unitLength = 1;
  
  ellipseMode(CENTER);
}

void draw(){
  background(0);
  strokeWeight(20);
  stroke(255);
  fill(255);

  
}


PVector pointPhysicsToVisual(PVector physicsPoint){
  return(PVector(unitLength * physicsPoint.x + cursor.x, - unitLength * physicsPoint.y + height + cursor.y));
}

PVector pointVisualToPhysics(PVector visualPoint){
  return(PVector(visualPoint.x / unitLength , (height -  visualPoint.y) / unitLength  ));
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
