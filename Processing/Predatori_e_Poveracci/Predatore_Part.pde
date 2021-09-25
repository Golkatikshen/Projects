public class Predatore_Part
{
  float x1, y1, x2, y2;
  float s;
  
  Predatore_Part(float x1, float y1, float x2, float y2)
  {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    
    s = 255;
  }
  
  void update()
  {
    s -= 4;
  }
  
  void display()
  {
    stroke(255, 0, 0, s);
    line(x1, y1, x2, y2);
  }
}