class ECUgu extends Entity
{
    int w;
  int h;
  
  ECUgu(int _x, int _y, boolean b)
  {
    super("cugu", _x, _y, comp_anchors_array, b);
    
    w = (int)rele(70, "h");
    h = (int)rele(70, "h");
    
    for(Anchor a: anchors)
    {
      a.finish = true;
      a.start = false;
    }
    
    anchors.get(anchors.size()-2).finish = false;
    anchors.get(anchors.size()-2).start = true;
    
    anchors.get(anchors.size()-1).finish = false;
    anchors.get(anchors.size()-1).start = true;
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(225, 225, 0);
    else
      fill(200, 200, 0);
    
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h, 3);
    fill(0);
    rect(x-(int)rele(18, "v"), y+(int)rele(30, "v"), rele(3, "h") < 1 ? 1 : rele(3, "h"), rele(8, "v") < 1 ? 1 : rele(8, "v"));
    rect(x+(int)rele(18, "v"), y+(int)rele(30, "v"), rele(3, "h") < 1 ? 1 : rele(3, "h"), rele(8, "v") < 1 ? 1 : rele(8, "v"));
     
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(texts);
    textSize(rele(22, "v"));
    text("= 0", x, y-rele(17, "v"));
    textSize(rele(10, "v"));
    
    text("true", x-(int)rele(18, "v"), y+(int)rele(16, "v"), (int)rele(50, "h"), (int)rele(20, "v"));
    text("flase", x+(int)rele(18, "v"), y+(int)rele(16, "v"), (int)rele(50, "h"), (int)rele(20, "v"));
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
    Anchor an;
    val = v;
    
    if(v == 0)
      an = anchors.get(anchors.size()-1);
    else
      an = anchors.get(anchors.size()-2);
    
    if(an.c != null)
      if(an.c.a.e == an.e)
        an.c.activate();
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-w/2 && mouseX < x+w/2) && (mouseY > y-h/2 && mouseY < y+h/2));
  }
}