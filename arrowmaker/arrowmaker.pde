// ARROWMAKER CODE INSIDE GRAVITY CHANGED TO BETTER REFLECT THE FACT THAT PHYSICSVECTOR WILL BE USED, THEREFORE IN GRAVITY "VECTOR" IS IN FACT "PHYSICSVECTOR" IN THE ARROWMAKER SKETCH AND "VISUAL VECTOR" IS HERE SIMPLY CALLED "VECTOR"

Arrow arrow;

void setup(){
  size(400, 400);
  frameRate(60);
  background(0);
  stroke(255);
  ellipseMode(RADIUS);
  arrow = new Arrow();
}

void draw(){
  background(0);
  //ellipse(mouseX, mouseY, 10, 10);
  //line(0,0, mouseX, mouseY);
  //PVector mababa = arrow.vector;
  arrow.update();
  arrow.render();
  arrow.renderValue();
  //if(arrow.status != "arrowNotDefined"){ println(arrow.vector.x, arrow.vector.y); }
}

class Arrow{
  PVector origin;
  PVector end;
  String status;
  PVector vector;
  PVector physicsVector;
  
  Arrow(PVector tempOrigin, PVector tempEnd, String tempStatus /*, PVector tempVector*/){
    origin = tempOrigin;
    end = tempEnd;
    status = tempStatus;
    //vector = PVector.sub(end, origin);
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
        vector = PVector.sub(end, origin);
        physicsVector = new PVector(vector.x, -vector.y);
        break;
    }
  }
  void renderValue(){
    if(status != "arrowNotDefined"){
      pushMatrix();
        rectMode(CENTER);
        textAlign(CENTER);
        
        float offset = 30;  
        float borderPercent = 0.90;
        float x = offset-1;
        float y = offset + 6;
        float rectWidth = 30;
        float rectHeight = 40;
        translate(end.x, end.y);
        
        fill(255);
        rect(x, y, rectWidth, rectHeight);
        fill(0, 0, 0 , 255);
        rect(x, y, rectWidth*borderPercent, rectHeight*borderPercent);
        fill(0, 0, 0 , 255);
        rect(x, y, rectWidth * 0.5, rectHeight);
        
        fill(255);
        text(int(physicsVector.x), offset, offset);
        text(int(physicsVector.y), offset, offset +20);
      popMatrix();
    }
  }
  void render(){
    strokeWeight(5);
    stroke(255);
    if(status != "arrowNotDefined"){
      float vectorAngle = atancorrect(vector.y) -atan(vector.x/vector.y);
      pushMatrix();
        translate(origin.x, origin.y);
        rotate(vectorAngle);
        //println(vectorAngle);
        
        line(0, 0, 0, vector.mag() - 25);
      popMatrix();
      
      pushMatrix();
        noStroke();
        fill(255);
        
        translate(end.x, end.y);
        rotate(vectorAngle);
        
        triangle(0, 0, 7.5, -30, -7.5, -30);
      popMatrix();
    }
  }
  
}

void mousePressed(){
  arrow.status = "arrowEndNotDefined";
  arrow.origin = PVector(mouseX, mouseY);
}

void mouseReleased(){
  arrow.status = "arrowSet";
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
