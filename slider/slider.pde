Slider slider;
void setup(){
  size(500, 500);
  
  slider = new Slider(color(50), color(255), 5, 100, PVector(40, 40));
}

void draw(){
  background(0);
  slider.Pos.x = frameCount;
  slider.Pos.y = frameCount;
  
  slider.selection = PVector(mouseX, mouseY);
  slider.render();
  text(slider.parameter, slider.Pos.x, slider.Pos.x + 20);
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

class Slider{
  PVector selection;
  float startX;
  float endX;
  float locationY;
  
  float parameter;
  
  
  color primary;
  color secondary;
  float margin;
  float length;
  PVector Pos;
  
  Slider(color tempPrimary, color tempSecondary, float tempMargin, float tempLength, PVector tempPos){
    primary = tempPrimary;
    secondary = tempSecondary;
    margin = tempMargin;
    length = tempLength;
    Pos = tempPos;
    
    selection = new PVector(Pos.x + margin, 0);
    
    
  }
    
    
    
  void render(){
    startX = margin + Pos.x;
    endX = margin + Pos.x + length;
    locationY = margin + Pos.y;
    
    strokeCap(SQUARE);
    strokeWeight(3);
    rectMode(CENTER);
    
    stroke(primary);
    line(startX, locationY,
         endX, locationY); 
    noStroke();
    fill(secondary);
    
    
      parameter = (selection.x - (startX)) / length;
      
      rect(selection.x, locationY, 4, 8);
  }
  
}
