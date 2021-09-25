public class Cibo_Part
{
  float w;
  float s;
  float x, y;
  
  
  Cibo_Part(float x, float y, float w)
  {
    this.x = x;
    this.y = y;
    
    this.w = w;
    s = 255;
  }
  
  void update()
  {
    w += 0.35;
    s -= 5;
  }
  
  void display()
  {
    stroke(0, 125, 255, s);
    fill(0, 0, 0, 0);
    ellipse(x, y, w, w);
  }
}