class Ball  {    
  float Mass;
  color Color;
  float Radius;
  PVector Acc;
  PVector Vel;
  PVector Pos;
  float visualVectorScale = 1;
  ArrayList<PVector> trajectory = new ArrayList<PVector>();
  //PVector visualPos;
  
  Ball(float tempMass, color tempColor, int tempRadius, PVector tempAcc, PVector tempVel, PVector tempPos){
    Mass = tempMass;
    Color = tempColor;
    Radius = tempRadius;
    Acc = tempAcc;
    Vel = tempVel;
    Pos = tempPos;
    //visualPos = vectorPhysicsToVisual(tempPos);
  }
  Ball(float tempMass, color tempColor, float tempRadius, PVector tempAcc, PVector tempVel, PVector tempPos){
    Mass = tempMass;
    Color = tempColor;
    Radius = tempRadius;
    Acc = tempAcc;
    Vel = tempVel;
    Pos = tempPos;
     //visualPos = vectorPhysicsToVisual(tempPos);
  }
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
  Ball(Ball ballToBeCopied){
    Mass = ballToBeCopied.Mass;
    Color = ballToBeCopied.Color;
    Radius = ballToBeCopied.Radius;
    Acc = PVector(ballToBeCopied.Acc.x, ballToBeCopied.Acc.y);
    Vel = PVector(ballToBeCopied.Vel.x, ballToBeCopied.Vel.y);
    Pos = PVector(ballToBeCopied.Pos.x, ballToBeCopied.Pos.y);
    //visualPos = vectorPhysicsToVisual(tempPos);
  }
  
  void update(){
    trajectory.add(PVector(Pos.x, Pos.y));
    
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

  void gravity(Ball attractor){
    
    //this is just projection ma dud
    PVector thisObjectToAttractor = PVector.sub(attractor.Pos, Pos);
    float dist = thisObjectToAttractor.mag();
    float forceMagnitude =  G * (attractor.Mass * Mass) / (dist * dist);
    PVector force = thisObjectToAttractor.mult(forceMagnitude / dist );
    
    applyNewForce(this, force);
  }
  
  void renderTrajectory(){
    
    fill(255);
    stroke(255);
    strokeWeight(5);
    
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
    ellipseMode(RADIUS);
    noStroke();
    fill(Color);
    
    ellipse(pointPhysicsToVisual(Pos).x , pointPhysicsToVisual(Pos).y, Radius * unitLength, Radius * unitLength);
    //println(pointPhysicsToVisual(Pos).x , pointPhysicsToVisual(Pos).y, "vis");
  }
  void activate(){
    renderTrajectory();
    render();
    renderAcc();
    renderVel();
    //renderPos();
    update();
  }
} 
