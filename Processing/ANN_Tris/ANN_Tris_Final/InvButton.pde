class InvButton
{
  float x;
  float y;
  float w;
  float h;
  String str;
  boolean hover;
  
  InvButton(float x_, float y_, float w_, float h_)
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    if(w < 3)
      w = 3;
  }
  
  void display()
  {
    rectMode(CENTER);
    
    noStroke();
    fill(0, 0, 0, 0);    
    rect(x, y, w, h);
  }
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}