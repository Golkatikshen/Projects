class Circle
{
  int x;
  int y;
  int w;
  
  Circle(int _x, int _y, int _w)
  {
    x = _x;
    y = _y;
    w = _w;
  }
  
  void display(boolean done)
  {
    noFill();
    if(!done)
      stroke(255, 0, 0);
    else
      stroke(0, 255, 0);
    ellipse(x, y, w*2, w*2);
  }
}