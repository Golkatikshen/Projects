class RulerLine
{
  float x1;
  float y1;
  float x2;
  float y2;
  float s;
  color c;
  
  RulerLine(float _x, float _y, float _s, color _c)
  {
    x1 = _x;
    y1 = _y;
    x2 = _x;
    y2 = _y;
    s = _s;
    c = _c;
  }
  
  void display()
  {
    strokeWeight(s);
    stroke(c);
    
    line(x1, y1, x2, y2);
  }
}