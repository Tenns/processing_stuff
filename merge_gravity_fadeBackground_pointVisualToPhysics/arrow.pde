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
