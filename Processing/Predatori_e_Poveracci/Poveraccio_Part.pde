public class Poveraccio_Part
{
  float w;
  float s;
  float x, y;
  
  
  Poveraccio_Part(float x, float y, float w)
  {
    this.x = x;
    this.y = y;
    
    this.w = w;
    s = 255;
  }
  
  void update()
  {
    w -= 1;
    s -= 5;
  }
  
  void display()
  {
    stroke(255, 255, 255, s);
    fill(0, 0, 0, 0);
    ellipse(x, y, w, w);
  }
}