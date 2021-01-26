Ball ball1;
Arrow arrow;

PVector cursor;

float unitLength;
float arrowScale = 10;


void setup(){
  size(1000, 1000);
  background(0);
  unitLength = 1;
  
  cursor = new PVector(0,0);
  
  ball1 = new Ball(1, color(255, 204, 0), 5, PVector(0, -1), PVector(3, 10), PVector(1, 1));
  //ball1 = new Ball(50, color(255, 204, 0), 10, PVector(0, 0), PVector(0, 1), PVector(0, 0));
  
  arrow = new Arrow();
  ball1.visualVectorScale = 10;
}

void draw(){
  background(0);
  
  renderUnits();
  
  ball1.renderTrajectory();
  
  ball1.render();
  ball1.renderAcc();
  ball1.renderVel();
  ball1.renderPos();

  //ball1.renderDynamicsVector(ball1.Acc);
  //ball1.renderDynamicsVector(ball1.Vel);

  renderVectorValue(pointPhysicsToVisual(ball1.Pos), 30, ball1.Acc);
  ball1.update();
  
  //println(ball1.Acc.x, ball1.Acc.y, "phys");
  
  arrow.update();
  arrow.render();
  arrow.renderValue();
  //delay(1000);
  //println(frameCount);
  
  

  
  //ball1.renderRadiusOfPathCurvature();
}

void mouseDragged(){
  if(mouseButton == CENTER){
    int dx = mouseX - pmouseX;
    int dy = mouseY - pmouseY;
       
    cursor.add(PVector(dx, dy));
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  unitLength = unitLength + e * exp(-1/unitLength);
}

void mousePressed(){
  switch(mouseButton){
  case LEFT:
    arrow.status = "arrowEndNotDefined";
    arrow.origin = PVector(mouseX, mouseY);
  break;
  case RIGHT:
    if(arrow.status == "arrowSet") {
      applyNewForce(ball1, arrow.vector);     
    }
  break;
  }
}

void mouseReleased(){
  switch(mouseButton){
  case LEFT:
    arrow.status = "arrowSet";
  break;
  case RIGHT:
  break;
  }
}

void applyNewForce(Ball item, PVector force){
  item.Acc.add(vectorDiv(force, item.Mass));
}

PVector vectorPhysicsToVisual(PVector physicsVector){
  //physicsVector.mult(unitLength);
  return(PVector(unitLength * physicsVector.x, -unitLength * physicsVector.y));
}

PVector pointPhysicsToVisual(PVector physicsPoint){
  return(PVector(unitLength * physicsPoint.x + cursor.x, - unitLength * physicsPoint.y + height + cursor.y));
}

PVector pointVisualToPhysics(PVector visualPoint){
  return(PVector(visualPoint.x / unitLength , (height -  visualPoint.y) / unitLength  ));
}

void renderUnits(){
  fill(255);
  stroke(255);
  strokeWeight(2);
  textAlign(LEFT);
  text("1 meter", 50, 40);
  text("time in s", 50, 65);
  text(millis()*0.001, 50, 80);
  line(50, 50, unitLength + 50, 50);
}

void renderVectorValue(PVector VisualPosition, float offset, PVector vector){
  pushMatrix();
    rectMode(CENTER);
    textAlign(CENTER); 

    String textOfVectorX = nfp(vector.x, 0, 1);
    String textOfVectorY = nfp(vector.y, 0, 1);
    
    int lengthOfText = max(textOfVectorX.length(), textOfVectorY.length());
    
    float borderPercent = 0.90;
    float x = offset -3;
    float y = offset + 6;
    float rectWidth = 10 * lengthOfText;
    float rectHeight = 40;
    
    
    translate(VisualPosition.x, VisualPosition.y);
    
    fill(255);
    rect(x, y, rectWidth, rectHeight);
    fill(0, 0, 0 , 255);
    rect(x, y, rectWidth*borderPercent, rectHeight*borderPercent);
    fill(0, 0, 0 , 255);
    rect(x, y, rectWidth * 0.5, rectHeight + 2);
    
    //String a = nfs((vector.y), 3);
    fill(255);
    text(textOfVectorX, offset, offset);
    text(textOfVectorY, offset, offset +20);
  popMatrix();
}
void renderVisualVector(PVector origin, PVector visualVector, float vectorScale){
  renderVisualVector(origin, visualVector, vectorScale, 255);
}
void renderVisualVector(PVector origin, PVector visualVector, float vectorScale, color Color){
  strokeWeight(5);
  stroke(Color);
  fill(Color);
  
  visualVector.mult(vectorScale);
  
  float vectorAngle = atancorrect(visualVector.y) -atan(visualVector.x/visualVector.y);
  float visualVectorMag = visualVector.mag();
  float triangleHeight = 30;
  
  if (visualVectorMag < 30){
    triangleHeight = visualVectorMag;
  }
  
  pushMatrix();
    translate(origin.x, origin.y);
    rotate(vectorAngle);
    //println(vectorAngle);
    
    line(0, 0, 0, visualVectorMag - 0.5 * triangleHeight);
  popMatrix();
  
  pushMatrix();
    noStroke();
    
    translate(origin.x + visualVector.x, origin.y + visualVector.y);
    rotate(vectorAngle);
    
    triangle(0, 0, 7.5, -triangleHeight, -7.5, -triangleHeight);
  popMatrix();
}

void renderPhysicsVector(PVector origin, PVector physicsVector, float vectorScale, color Color){
  renderVisualVector(pointPhysicsToVisual(origin), vectorPhysicsToVisual(physicsVector), vectorScale, Color);
}
void renderPhysicsVector(PVector origin, PVector physicsVector, float vectorScale){
  renderVisualVector(pointPhysicsToVisual(origin), vectorPhysicsToVisual(physicsVector), vectorScale, 255);
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

class Ball  {    
  int Mass;
  color Color;
  float Radius;
  PVector Acc;
  PVector Vel;
  PVector Pos;
  float visualVectorScale = 1;
  ArrayList<PVector> trajectory = new ArrayList<PVector>();
  //PVector visualPos;
  
  Ball(int tempMass, color tempColor, int tempRadius, PVector tempAcc, PVector tempVel, PVector tempPos){
     Mass = tempMass;
     Color = tempColor;
     Radius = tempRadius;
     Acc = tempAcc;
     Vel = tempVel;
     Pos = tempPos;
     //visualPos = vectorPhysicsToVisual(tempPos);
  }
  
  Ball(int tempMass, color tempColor, float tempRadius, PVector tempAcc, PVector tempVel, PVector tempPos){
     Mass = tempMass;
     Color = tempColor;
     Radius = tempRadius;
     Acc = tempAcc;
     Vel = tempVel;
     Pos = tempPos;
     //visualPos = vectorPhysicsToVisual(tempPos);
  }
  void update(){
    Vel.add(vectorDiv(Acc, frameRate));
    Pos.add(vectorDiv(Vel, frameRate));
    //visualPos = vectorPhysicsToVisual(Pos);
  }
  
  //TO REFACTOR ? 
/*
  void renderDynamicsVector(PVector dynamicsVector, float scale){
    renderVisualVector(pointPhysicsToVisual(Pos), vectorPhysicsToVisual(PVector(dynamicsVector.x, dynamicsVector.y)), scale);
  }
  void renderDynamicsVector(PVector dynamicsVector){
    renderDynamicsVector(dynamicsVector, arrowScale);
    //println(vectorPhysicsToVisual(PVector(Acc.x, Acc.y)));
  }
  void renderDynamicsVector(PVector dynamicsVector, PVector originPointOfVector, float scale){
    renderVisualVector(pointPhysicsToVisual(originPointOfVector), vectorPhysicsToVisual(PVector(dynamicsVector.x, dynamicsVector.y)), scale);
    //println(vectorPhysicsToVisual(PVector(Acc.x, Acc.y)));
  }
  void renderDynamicsVector(PVector dynamicsVector, PVector originPointOfVector){
    renderDynamicsVector(dynamicsVector, originPointOfVector, arrowScale);
  }
*/  


  void renderTrajectory(){
    trajectory.add(PVector(ball1.Pos.x, ball1.Pos.y));
    fill(255);
    stroke(255);
    strokeWeight(1);
    for(PVector point : trajectory){
      PVector visualPoint = pointPhysicsToVisual(point);
      point(visualPoint.x, visualPoint.y);
    }
    
  }
  void renderRadiusOfPathCurvature(){
    float angle = PVector.angleBetween(Vel, Acc) + HALF_PI;
    float AccNormalToVel = abs(cos(angle) * Acc.mag());
    float physicsRadius = Vel.magSq() / AccNormalToVel;
    float visualRadius = physicsRadius * unitLength;
    
    println(angle);
    
    fill(255);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(pointPhysicsToVisual(Pos).x , pointPhysicsToVisual(Pos).y, visualRadius, visualRadius);
  }
  
  void renderAcc(){
    renderVisualVector(pointPhysicsToVisual(Pos), vectorPhysicsToVisual(Acc), visualVectorScale, color(245, 0 , 0));
  }
  void renderVel(){
    renderVisualVector(pointPhysicsToVisual(Pos), vectorPhysicsToVisual(Vel), visualVectorScale, color(40, 245 , 40));
  }
  void renderPos(){
    renderVisualVector(pointPhysicsToVisual(PVector(0,0)), vectorPhysicsToVisual(Pos), 1, color(40, 40 , 245));
  }
  void render(){
    ellipseMode(CENTER);
    noStroke();
    fill(Color);
    
    ellipse(pointPhysicsToVisual(Pos).x , pointPhysicsToVisual(Pos).y, Radius * unitLength, Radius * unitLength);
    //println(pointPhysicsToVisual(Pos).x , pointPhysicsToVisual(Pos).y, "vis");
  }
  
} 


class Arrow{
  PVector origin;
  PVector end;
  String status;
  PVector visualVector;
  PVector vector;
  
  Arrow(PVector tempOrigin, PVector tempEnd, String tempStatus /*, PVector tempVector*/){
    origin = tempOrigin;
    end = tempEnd;
    status = tempStatus;
    //visualVector = PVector.sub(end, origin);
  }
  
  Arrow(){
    status = "arrowNotDefined";
  }
  
  void update(){
    switch(status){
      case "arrowNotDefined":
        break;
      case "arrowEndNotDefined":
        end = PVector(mouseX, mouseY);
      case "arrowSet":
        visualVector = PVector.sub(end, origin); // nullpointer
        vector = PVector(visualVector.x, -visualVector.y);
        vector.div(unitLength);
        break;
    }
  }
  
  void renderValue(){
    if(status != "arrowNotDefined"){
      renderVectorValue(end, 30, vector);
    }
  }
  
  void render(){
    
    if(status != "arrowNotDefined"){
      renderVisualVector(origin, visualVector, 1);
    }
  }
  
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
/* IDEA: MAKE ARROW CLASS A FUNCTION
PVector arrowMaker(PVector origin){
  PVector arrow;
  
  while(mousePressed){
    stroke(255);
    strokeWeight(10);
    line(origin.x, origin.y, mouseX, mouseY);
    pushMatrix();
    translate(mouseX, mouseY);
    triangle(0, 10, 5, 0, 0, 5);
    popMatrix();
  }
  
  arrow = new PVector(mouseX - origin.x, mouseY - origin.y);
  return arrow;
}

void mousePressed(){
  PVector arrowOrigin = new PVector(mouseX, mouseY);
  arrowMaker(arrowOrigin);
}
*/

/* IDEA: GET BALL CLASS INSIDE ITEM CLASS, AND GENERATE A BALL EACH TIME AN ITEM IS GENERATED
class Item {
  //String type;
  int Mass;
  color Color;
  int Radius;
  PVector Pos;
  
  Item(String tempType, int tempMass, color tempColor, int tempRadius, PVector tempPos){
     
     Mass = tempMass;
     Color = tempColor;
     Radius = tempRadius;
     Pos = tempPos;
  switch(tempType)  {
    case "ball":
    case "Ball":
      
    break;  
  }
}
*/
