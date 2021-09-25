public class Quad 
{
  int c;
  int x;
  int y;
  int w;
  int id;
  

  Quad(int x, int y, int w)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    c = 6;
  }
  
  void display()
  {
    fill(uc[c]);

    rect(x, y, w, w);
  }
  

  public void reset()
  {
    c = 6;
  }

  public void clickChangeColor(int v)
  {
    if (v == 1)
    {
      if (c >= 5)
        c = 0;
      else
        c ++;
    } else
    {
      if (c == 0)
        c = 5;
      else
        c --;
    }
  }

  public boolean mouseHover()
  {
    return ((mouseX >= x && mouseX <= x+w) && (mouseY >= y && mouseY <= y+w));
  }
}