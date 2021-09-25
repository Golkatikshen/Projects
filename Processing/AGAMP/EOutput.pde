class EOutput extends Entity
{
  int w;
  String tag;
  float expected;
  boolean activated;
  
  
  EOutput(int _x, int _y, float _expected, String _tag, boolean b)
  {
    super("output", _x, _y, circle_anchors_array, b);
    
    val = 0;
    tag = _tag;
    expected = _expected;
    deletable = false;
    
    for(Anchor a: anchors)
      a.start = false;
    
    w = (int)rele(70, "h");
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(20);
    else
      fill(0);
      
    stroke(255);
    ellipse(x, y, w, w);

    label(adjustFormat(val), x, y-(int)rele(10, "v"), (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
    
    fill(255);
    textSize(rele(15, "v"));
    text("OUTPUT", x, y+rele(9, "v"));
    textSize(rele(12, "v"));
    text(tag, x, y+rele(22, "v"));
    
    noStroke();
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
    activated = true;
  }
  
  
  boolean mouseHover()
  {
    return ((w/2)*(w/2) > (x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY));
  }
}