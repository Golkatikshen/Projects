class Slider
{
  float x;
  float y;
  float w;
  float h;
  float y_off;
  float len;
  String str;
  
  boolean selected;
  
  
  Slider(int _x, int _y, int _len)
  {
    x = rele(_x, "h");
    y = rele(_y, "v");
    w = rele(20, "h");
    h = rele(30, "v");
    y_off = 0;
    len = rele(_len, "v");
    
    selected = false;
  }
  
  void display()
  {
    rectMode(CENTER);
    noStroke();
    fill(20);
    rect(x, y+len/2, rele(4, "h"), len);
    
    stroke(0);
    if(mouseHover())
      fill(70);
    else
      fill(50);
    rect(x, y+y_off, w, h);
    rectMode(CORNER);
  }
  
  
  void smouseDragged()
  {
    if(mouseHover())
      selected = true;
      
    if(selected)
    {
      y_off = mouseY-y;
      
      if(y_off < 0)
        y_off = 0;
      
      if(y_off > len)
        y_off = len;
    }
  }
  
  void smouseWheel(int v)
  {
    y_off += v;
      
    if(y_off < 0)
      y_off = 0;
    
    if(y_off > len)
      y_off = len;
  }
  
  void smouseReleased()
  {
    selected = false;
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y+y_off-h/2 && mouseY < y+y_off+h/2));
  }
}