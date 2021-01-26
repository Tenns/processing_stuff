class Lift extends Conveyor_belts
{
  int level;

  Lift(int size, float x, float y, int type)
  {
    super(size, x, y, type);
    level = 0;
  }

  void move_up()
  {
    if (!animation_playing && level < 6)
    {
      level++;
      move(0, -80);
    }
  }

  void move_down()
  {
    if (!animation_playing && level > 0)
    {
      level--;
      move(0, 80);
    }
  }
}
