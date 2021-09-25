public class Block
{
  PVector pos;
  float w;
  color c;
  
  Block(int _x, int _y, float _w, color _c)
  {
    pos = new PVector(_x, _y);
    w = _w;
    c = _c;
  }
  
  public void display()
  {
    fill(c);
    rect(pos.x, pos.y, w, w);
  }
}