class Button
{
  float x;
  float y;
  float w;
  float h;
  String str;
  float thickness;
  boolean hover;
  
  Button(float x_, float y_, float w_, float h_, String str_, float thickness_)
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    str = str_;
    thickness = thickness_;
    
    if(thickness < 0)
      thickness = 0;
      
    if(w < 3)
      w = 3;
  }
  
  void display()
  {
    rectMode(CENTER);
    
    fill(255, 0, 0);    
    rect(x, y, w+thickness, h+thickness);
    
    fill(0);
    rect(x, y, w, h);
    
    if(mouseHover())
      fill(255, 0, 0);
    else
      fill(255);
    textAlign(CENTER, CENTER);
    for(int i=0; i<w/2; i++)
    {
      textSize(w/2-i);
      if(textWidth(str) < w && textAscent()+textDescent() < h)
        break;
    }
    text(str, x, y);
  }
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}