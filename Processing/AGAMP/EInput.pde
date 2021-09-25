class EInput extends Entity
{
  int w;
  String tag;
  
  EInput(int _x, int _y, int _val, String _tag, boolean b)
  {
    super("input", _x, _y, circle_anchors_array, b);
    
    val = _val;
    tag = _tag;
    deletable = false;
    
    for(Anchor a: anchors)
      a.finish = false;
    
    w = (int)rele(70, "h");
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(255);
    else
      fill(205);
      
    stroke(10);
    ellipse(x, y, w, w);
    noStroke();
    
    label(adjustFormat(val), x, y-(int)rele(10, "v"), (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
    fill(0);
    textSize(rele(15, "v"));
    text("INPUT", x, y+rele(9, "v"));
    textSize(rele(12, "v"));
    text(tag, x, y+rele(22, "v"));
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