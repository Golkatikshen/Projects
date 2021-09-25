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
  
  
  Slider(int _x, int _y, int _len, String _str)
  {
    x = rele(_x, "h");
    y = rele(_y, "v");
    w = rele(30, "h");
    h = rele(30, "v");
    y_off = 0;
    len = rele(_len, "h");
    
    str = _str;
    selected = false;
  }
  
  void display()
  {
    textAlign(CENTER, CENTER);
    label(str, (int)x, (int)(y+rele(35, "v")+len), (int)rele(60, "h"), (int)rele(30, "v"),  255, 255, 255,  0, 0, 0);
    
    rectMode(CENTER);
    fill(255);
    rect(x, y+len/2, rele(4, "h"), len);
    
    stroke(0);
    if(mouseHover())
      fill(175);
    else
      fill(125);
    rect(x, y+y_off, w, h);
    noStroke();
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
  
  void smouseReleased()
  {
    selected = false;
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y+y_off-h/2 && mouseY < y+y_off+h/2));
  }
}