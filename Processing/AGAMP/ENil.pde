class ENil extends Entity
{
  int w;
  
  ENil(int _x, int _y, boolean b)
  {
    super("nil", _x, _y, circle_anchors_array, b);
    w = (int)rele(70, "h");
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(255, 192, 203);
    else
      fill(255, 172, 193);
      
    noStroke();
    ellipse(x, y, w, w);
    
    label("NIL", x, y, (int)rele(50, "h"), (int)rele(20, "v"),  0, 0, 0,  255, 152, 183);
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