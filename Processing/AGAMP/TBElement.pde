class TBElement
{
  float x;
  float y;
  float y_mem;
  float w;
  float h;
  String str;
  boolean selected;
  
  TBElement(float x_, float y_, float w_, float h_, String _str)
  {
    x = rele(x_, "h");
    y = rele(y_, "v");
    y_mem = y;
    w = rele(w_, "h");
    h = rele(h_, "v");
    str = _str;

    if(w < 3)
      w = 3;
  }
  
  void display()
  {
    rectMode(CENTER);
    
    noStroke();
    fill(0, 0, 0, 0);    
    rect(x, y, w, h);
    
    if(selected)
      label(str, (int)x, (int)y, (int)rele(80, "h"), (int)rele(30, "v"), 0, 0, 0, 255, 255, 255, 2);
    else
      label(str, (int)x, (int)y, (int)rele(80, "h"), (int)rele(30, "v"), 255, 255, 255, 0, 0, 0, 2);
  }
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}