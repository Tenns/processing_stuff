class Button implements Entity
{
  String label;
  float x;
  float y;
  float w;
  float h;
  color fill_color;
  
  Button(String label, float x, float y, float w)
  {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = 20;
    fill_color = #606090; 
  }
 
  
  void update()
  {
    if (contains(mouseX, mouseY))
    {
      if (mousePressed && mouseButton == LEFT)
      {
        fill_color = #99b3e6;
      }
      else
      {
        fill_color = #2952a3;
      }
    }
    else
    {
      fill_color = #0f1f3d;
    }
  }
  
  @Override
  void draw()
  {
    push();
    
    fill(fill_color);
    rect(x, y, w, h);
    
    fill(#FFFFFF);
    textSize(h - 6);
    textAlign(CENTER, CENTER);
    text(label, x , y , w, h);
    
    pop();
  }
  
  boolean contains(float x, float y)
  {
    return x >= this.x && y >= this.y && x < this.x + w && y < this.y + h;
  }
}
