class Anchor
{
  float x;
  float y;
  boolean start;
  boolean finish;
  Entity e;
  Connection c;
  
  
  Anchor(float _x, float _y, Entity _e)
  {
    x = _e.x + _x;
    y = _e.y + _y;
    e = _e;
    c = null;
    
    start = true;
    finish = true;
  }
  
  void display()
  {
    noFill();
    stroke(255, 0, 0);
    ellipse(x, y, 4, 4);
  }
}