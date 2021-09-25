class Quad
{
  int x;
  int y;
  int w;
  color c;
  
  Quad(int _x, int _y, int _w)
  {
    x = _x;
    y = _y;
    w = _w;
    changeColor(0);
  }
  
  void display()
  {
    fill(c);
    rect(x, y, w, w);
  }
  
  void changeColor(int v)
  {
    switch(v)
    {
      case 0:
        c = color(255, 255, 255);
      break;
      
      case 1:
        c = color(255, 0, 0);
      break;
      
      case 2:
        c = color(240, 140, 30);
      break;
      
      case 3:
        c = color(255, 255, 0);
      break;
      
      case 4:
        c = color(0, 255, 0);
      break;
      
      case 5:
        c = color(0, 0, 255);
      break;
      
      case 7:
        c = color(150, 0, 200);
      break;
    }
  }
}