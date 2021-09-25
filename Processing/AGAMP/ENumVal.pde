class ENumVal extends Entity
{
  int w;
  
  ENumVal(int _x, int _y, boolean b)
  {
    super("num", _x, _y, circle_anchors_array, b);
    w = (int)rele(70, "h");
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(130);
    else
      fill(100);
      
    noStroke();
    ellipse(x, y, w, w);
    
    label(adjustFormat(val), x, y, (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
  }
  
  void update()
  {
    //bounds
    if(x-w/2 < rele(102, "h"))
      x = (int)rele(102, "h")+w/2;
      
    if(x+w/2 > rele(Width-100, "h"))
      x = (int)rele(Width-100, "h")-w/2;
      
    if(y-w/2 < 0)
      y = w/2;
      
    if(y+w/2 > rele(Height, "v"))
      y = (int)rele(Height, "v")-w/2;
    //bounds
      
    super.update();
  }
  
  
  void active(float v)
  {
    val = v;
    super.active(val);
  }
  
  
  boolean mouseHover()
  {
    return ((w/2)*(w/2) > (x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY));
  }
}