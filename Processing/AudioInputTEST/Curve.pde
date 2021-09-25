class Curve
{
  PVector[] points;
  int x;
  int y;
  
  Curve(int _x, int _y, int _n_p)
  {
    x = _x;
    y = _y;
    
    points = new PVector[_n_p];
    for(int i=0; i<_n_p; i++)
      points[i] = new PVector(x+(2*i), y);
  }
  
}