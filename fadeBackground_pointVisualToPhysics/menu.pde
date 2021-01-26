class Menu{
  boolean open;
  int[] parameters;
  color background;
  float textSize = 8;
  float margin = 0.2 * textSize;
  float rectangleSize;
  PVector pos;
  
  Menu(String[] tempParameters, color tempBackground, PVector tempPos){
    parameters = tempParameters;
    background = tempBackground;
    pos = tempPos;
    
    rectangleSize = sizeOfBlockText(textSize, margin, parameters.length);
    
  }
  
  void render(){
    rectMode(CORNER);
    rect(pos.x, pos.y, 
  }
  
  
}
