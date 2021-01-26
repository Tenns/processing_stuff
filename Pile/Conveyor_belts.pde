class Conveyor_belts extends Pile_structure
{
  float x_offset;
  float y_offset;
  
  Conveyor_belts(int size, float x, float y, int type)
  {
    super(size, x, y, type);
    
    x_offset = 0;
    y_offset = 0;
  }


  void move(float x_offset, float y_offset)
  {
    
      x += x_offset;
      y += y_offset;
      this.x_offset = -x_offset;
      this.y_offset = -y_offset;
    
  }
}
