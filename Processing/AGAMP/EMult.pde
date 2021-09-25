class EMult extends Entity
{
  int w;
  int h;
  
  EMult(int _x, int _y, boolean b)
  {
    super("mult", _x, _y, quad_anchors_array, b);
    
    w = (int)rele(70, "h");
    h = (int)rele(70, "h");
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(0, 90, 250);
    else
      fill(0, 90, 200);
    
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);
     
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(texts);
    textSize(rele(22, "v"));
    text("MULT", x, y-rele(17, "v"));
    
    if(done)
      label(adjustFormat(val), x, y+(int)rele(16, "v"), (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
    else
      label("NIL", x, y+(int)rele(16, "v"), (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
  }
  
  void update()
  {
    //bounds
    if(x-w/2 < rele(102, "h"))
      x = (int)rele(102, "h")+w/2;
      
    if(x+w/2 > rele(Width-100, "h"))
      x = (int)rele(Width-100, "h")-w/2;
    
    if(y-h/2 < 0)
      y = h/2;
      
    if(y+h/2 > rele(Height, "v"))
      y = (int)rele(Height, "v")-h/2;
    //bounds
      
    super.update();
  }
  
  
  void active(float v)
  {
    if(!done)
    {
     val = v;
     done = true;
    }
    else
      val *= v;
      
    if(done)
      super.active(val);
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}