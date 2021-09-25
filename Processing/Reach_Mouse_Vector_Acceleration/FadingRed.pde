public class FadingRed
{
  PVector position;
  float w;
  float f;
  
  FadingRed(float x, float y)
  {
    position = new PVector(x, y);
    w = 55;
    f = 255;
  }
  
  void update()
  {
    w -= 1;
    f -= 5;
  }
  
  void display()
  {
    fill(100, 100, 100, f);
    stroke(255);
    ellipse(position.x, position.y, w, w);
  }
}