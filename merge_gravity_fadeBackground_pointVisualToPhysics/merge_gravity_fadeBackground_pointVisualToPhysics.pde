PVector visualOffset;
PVector physicsOffset;

float unitLength;
float arrowScale = 10;
boolean playback; 

//MOUSE CONTROLS
int move = RIGHT;
int createArrow = CENTER;
int applyArrow = CENTER;
int drag = LEFT;
//also scroll is zoom

float G = 6.67 * pow(10, -11);

//ENABLE OR DISABLE FEATURES
int enableArrow = 0;

int selectedBall = -1;
PVector mouseToBall;

int ppmouseX;
int ppmouseY;

Arrow[] arrows = new Arrow[enableArrow];
Ball[] balls = new Ball[6];
Ball[] trajectoryBalls;
PVector center;

void setup() {
  size(1000, 1000, P2D);

  surface.setResizable(true);
  //  surface.setLocation(100, 100);

  background(0);
  unitLength = 10;

  playback = false;

  visualOffset = new PVector(0, 0);
  physicsOffset = new PVector(0, 0);
  ellipseMode(CENTER);

  //frameRate(1);
  ppmouseX = 0;
  ppmouseY = 0;

  balls[0] = new Ball(pow(10, 13), color(255, 186, 8), 1, PVector(0, 0), PVector(5, 0), PVector(0, 1000));
  balls[5] = new Ball(pow(10, 13), color(255, 186, 8), 1, PVector(0, 0), PVector(0, 0), PVector(0, 0));
  balls[1] = new Ball(pow(10, 1), color(63, 136, 197), 1, PVector(0, 0), PVector(0, -5), PVector(10, 0));
  balls[2] = new Ball(pow(10, 1), color(63, 136, 197), 1, PVector(0, 0), PVector(0, -5), PVector(20, 0));
  balls[3] = new Ball(pow(10, 1), color(63, 136, 197), 1, PVector(0, 0), PVector(0, -5), PVector(30, 0));
  balls[4] = new Ball(pow(10, 1), color(63, 136, 197), 1, PVector(0, 0), PVector(0, -5), PVector(90, 0));
  //balls[2] = new Ball(pow(10, 13), color(208, 0, 0), 5, PVector(0, 0), PVector(0, 0), PVector(0, 20));

  //ball1 = new Ball(50, color(255, 204, 0), 10, PVector(0, 0), PVector(0, 1), PVector(0, 0));

  //ball1.visualVectorScale = 1;

  center = new PVector(10, 0);

  //DO NOT COMMENT THIS BLOCK OUT, IT IS NOT USEFUL TO REMOVE IT IN ORDER TO REMOVE ARROWS, THE PROPER WAY TO DO IT IS TO CHANGE "enableArrow" TO 0 UP, ABOVE SETUP
  if (enableArrow == 1) {
    arrows[0] = new Arrow();
  }


  // HERE WE ARE CALCULATING THE FUTURE TRAJECTORIES OF THE BALLS
  trajectoryBalls = new Ball[balls.length];
}

void draw() {
  background(0);
  renderPhysicsGrid(1, color(75));

  renderUnits();

  if (playback == true) {
    for (int i = 0; i < balls.length; i++) {
      applyNewForce(balls[i], PVector(0, 0));

      for (int j = 0; j < balls.length; j++) {
        if (j != i) {
          if (j == 0) {
          }
          balls[i].gravity(balls[j]);
        }
      }
    }

    for (int i = 0; i < balls.length; i++) {
      balls[i].update();
    }
  } else {
    for (int i = 0; i < balls.length; i++) {
      trajectoryBalls[i] = new Ball(balls[i]);
      trajectoryBalls[i].Color = color(255, 20, 20, 50);
    }

    boolean collideFree = true;
    int stepCounter = 0;
    while (collideFree && stepCounter < 1000) {

      for (int i = 0; i < trajectoryBalls.length; i++) {
        trajectoryBalls[i].update();
      }


      for (int i = 0; i < trajectoryBalls.length; i++) {
        applyNewForce(trajectoryBalls[i], PVector(0, 0));

        for (int j = 0; j < trajectoryBalls.length; j++) {
          if (j != i) {
            trajectoryBalls[i].gravity(trajectoryBalls[j]);

            if (PVector.dist(trajectoryBalls[i].Pos, trajectoryBalls[j].Pos) < trajectoryBalls[i].Radius + trajectoryBalls[j].Radius) {
              collideFree = false;
            }
            //println(i, j);
          }
        }
      }
      /* NOT SURE YOU WANNA DO THAT, YOU'LL MISS THE FIRST FRAME.
       
       if(stepCounter == 0){
       for(int i = 0; i < balls.length; i++){
       balls[i] = new Ball(trajectoryBalls[i]);
       }
       }
       */


      stepCounter ++;
    }


    //HERE WE RENDER THE TRAJECTORIES THE BALLS WILL TAKE
    for (int i = 0; i < trajectoryBalls.length; i++) {
      trajectoryBalls[i].renderTrajectory();
      if (collideFree == false) {
        trajectoryBalls[i].render();
      }
    }
  }


  PVector PhysicsMouse = pointVisualToPhysics(PVector(mouseX, mouseY));
  if (selectedBall != -1) {
    balls[selectedBall].Pos = PVector.sub(PhysicsMouse, mouseToBall);
    PVector velocityOfMouse = PVector(mouseX -(ppmouseX + pmouseX) * 0.5, mouseY -(ppmouseY + pmouseY) * 0.5);

    PVector physicsVelocityOfMouse = PVector.mult(vectorVisualToPhysics(velocityOfMouse), 0.1 * frameRate);
    //println(frameRate);
    balls[selectedBall].Vel = physicsVelocityOfMouse;
  }

  for (int i = 0; i < balls.length; i++) {
    balls[i].render();
    balls[i].renderAcc();
    balls[i].renderVel();
    balls[i].renderTrajectory();
  }
  //println(balls[0].Acc );


  //DO NOT COMMENT THIS BLOCK OUT, IT IS NOT USEFUL TO REMOVE IT IN ORDER TO REMOVE ARROWS, THE PROPER WAY TO DO IT IS TO CHANGE "enableArrow" TO 0 UP, ABOVE SETUP
  if (enableArrow == 1) {
    arrows[0].update();
    arrows[0].renderValue();
    arrows[0].render();
  }


  //renderCrosshair();
  ppmouseX = pmouseX;
  ppmouseY = pmouseY;
}  




void renderPhysicsGrid(float thickness, color Color) {
  colorMode(HSB, 255);

  int avgBetweenBrightnessColorAndMax = int(   (brightness(Color) + 255)  * 0.5);

  color alternateGridColor = color(hue(Color), saturation(Color), avgBetweenBrightnessColorAndMax);
  float alternateGridThickness = thickness * 2;

  PVector PhysicsBottomLeftCornerOfScreen = pointVisualToPhysics(PVector(0, height));
  PVector PhysicsTopRightCornerOfScreen = pointVisualToPhysics(PVector(width, 0));

  float range = max(width, height) / unitLength; 
  int start = floor(min(PhysicsBottomLeftCornerOfScreen.x, PhysicsBottomLeftCornerOfScreen.y));
  float end = range + ceil(max(PhysicsTopRightCornerOfScreen.x, PhysicsTopRightCornerOfScreen.y));

  PVector physicsLineLength = PVector(  max(abs(start - PhysicsTopRightCornerOfScreen.x ), abs(end - PhysicsBottomLeftCornerOfScreen.x) ), 
    max(abs(start - PhysicsTopRightCornerOfScreen.y ), abs(end - PhysicsBottomLeftCornerOfScreen.y)    )); 

  PVector lineLength = vectorMult(physicsLineLength, unitLength);



  for (int i = start; i < end; i++) {
    if (i % 5 == 0) {
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

void renderCrosshair() {
  //white ellipse behind pink crosshair
  fill(255, 255, 255);
  noStroke();

  PVector location = pointPhysicsToVisual(  vectorMult(physicsOffset, -1)   );
  ellipse(location.x, location.y, 20, 20);
  println(pointVisualToPhysics(PVector(width/2, height/2)));

  //pink crosshair
  fill(255, 0, 255);
  stroke(255, 0, 255);
  strokeWeight(2);
  line(width/2 - 20, height/2, width/2 + 20, height/2);
  line(width/2, height/2 - 20, width/2, height/2 + 20);
  ellipse(width/2, height/2, 10, 10);
}

void fadeBackground(float rate) {
  colorMode(HSB, 255);
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(hue(pixels[i]), saturation(pixels[i]), int(rate * brightness(pixels[i])));
  }
  updatePixels();
  colorMode(RGB, 255);
}

void mouseDragged() {
  if (mouseButton == move) {
    int dx = mouseX - pmouseX;
    int dy = mouseY - pmouseY;

    visualOffset.add(PVector(dx, dy));
    physicsOffset.add(vectorMult(PVector(dx, - dy), 1/unitLength));
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e = Math.signum(e) * exp(-1/e);
  unitLength = max( unitLength + e, 0); // TO FIX
  ; 
  println(unitLength);
}

void mousePressed() {

  if (mouseButton == createArrow) {
    if (arrows.length != 0) {
      arrows[0].status = "arrowEndNotDefined";
      arrows[0].origin = PVector(mouseX, mouseY);
    }
  }

  if (mouseButton == applyArrow) {
    if (arrows.length != 0) {
      if (arrows[0].status == "arrowSet") {
        addNewForce(balls[0], arrows[0].vector);
      }
    }
  }


  if (mouseButton == drag) {

    for (int i = balls.length -1; i > -1 && selectedBall == -1; i--) {

      PVector PhysicsMouse = pointVisualToPhysics(PVector(mouseX, mouseY));
      mouseToBall = PVector.sub(PhysicsMouse, balls[i].Pos);

      if (mouseToBall.mag() < balls[i].Radius) {
        selectedBall = i;
      }
    }
  }
}

void mouseReleased() {
  if (mouseButton == createArrow) {
    if (arrows.length != 0) {
      arrows[0].status = "arrowSet";
    }
  }
  if (mouseButton == drag) {
    if (selectedBall != -1) {

      selectedBall = -1;
    }
  }
}


void keyPressed() {
  if (key == ' ') {
    playback = true;
  }
}
void addNewForce(Ball item, PVector force) {
  item.Acc.add(PVector.div(force, item.Mass));
}

void applyNewForce(Ball item, PVector force) {
  item.Acc = PVector.div(force, item.Mass);
}



PVector pointPhysicsToVisual(PVector physicsPoint) {
  return(PVector(unitLength * (physicsPoint.x + physicsOffset.x) + width/2, - unitLength * ( physicsPoint.y + physicsOffset.y ) + height/2 ));
}

PVector pointVisualToPhysics(PVector visualPoint) {
  return(PVector((visualPoint.x - width/2) / unitLength - physicsOffset.x, (height/2 -  visualPoint.y  ) / unitLength - physicsOffset.y ));
}



PVector vectorPhysicsToVisual(PVector physicsVector) {
  //physicsVector.mult(unitLength);
  return(PVector(unitLength * physicsVector.x, -unitLength * physicsVector.y));
}
PVector vectorVisualToPhysics(PVector physicsVector) {
  //physicsVector.mult(unitLength);
  return(PVector(physicsVector.x / unitLength, -physicsVector.y / unitLength));
}


void renderUnits() {
  fill(255);
  stroke(255);
  strokeWeight(2);
  textAlign(LEFT);
  text("1 meter", 50, 40);
  text("time in s", 50, 65);
  text(millis()*0.001, 50, 80);
  line(50, 50, unitLength + 50, 50);
}

void renderVectorValue(PVector VisualPosition, float offset, PVector vector) {
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
  fill(0, 0, 0, 255);
  rect(x, y, rectWidth*borderPercent, rectHeight*borderPercent);
  fill(0, 0, 0, 255);
  rect(x, y, rectWidth * 0.5, rectHeight + 2);

  //String a = nfs((vector.y), 3);
  fill(255);
  text(textOfVectorX, offset, offset);
  text(textOfVectorY, offset, offset +20);
  popMatrix();
}
void renderVisualVector(PVector origin, PVector visualVector, float vectorScale) {
  renderVisualVector(origin, visualVector, vectorScale, 255);
}
void renderVisualVector(PVector origin, PVector visualVector, float vectorScale, color Color) {
  strokeWeight(5);
  stroke(Color);
  fill(Color);

  visualVector.mult(vectorScale);

  float vectorAngle = atancorrect(visualVector.y) -atan(visualVector.x/visualVector.y);
  float visualVectorMag = visualVector.mag();
  float triangleHeight = 30;

  if (visualVectorMag < 30) {
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

void renderPhysicsVector(PVector origin, PVector physicsVector, float vectorScale, color Color) {
  renderVisualVector(pointPhysicsToVisual(origin), vectorPhysicsToVisual(physicsVector), vectorScale, Color);
}
void renderPhysicsVector(PVector origin, PVector physicsVector, float vectorScale) {
  renderPhysicsVector(origin, physicsVector, vectorScale, color(255));
}














float atancorrect(float a1) {
  if (a1<0) return PI;
  if (a1>=0) return 0;
  // this would not be reached: 
  return 0;
}

PVector PVector(int x, int y) {
  PVector Vector;

  Vector = new PVector(x, y);
  return Vector;
}

PVector PVector(float x, float y) {
  PVector Vector;

  Vector = new PVector(x, y);
  return Vector;
}

PVector vectorBetweenTwoPoints(float x_origin, float y_origin, float x_end, float y_end) {
  return( PVector( x_end - x_origin, y_end - y_origin));
}

PVector vectorBetweenTwoPoints(int x_origin, int y_origin, int x_end, int y_end) {
  return( PVector( x_end - x_origin, y_end - y_origin));
}

PVector vectorBetweenTwoPoints(PVector origin, PVector end) {
  return(PVector.sub(end, origin));
}



PVector vectorMult(PVector vector, float scalar) {
  return(PVector(scalar * vector.x, scalar * vector.y));
}

PVector vectorMult(PVector vector, int scalar) {
  return(PVector(scalar * vector.x, scalar * vector.y));
}

PVector vectorDiv(PVector vector, float scalar) {
  return(PVector(vector.x / scalar, vector.y / scalar));
}
