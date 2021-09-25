class EOpp extends Entity
{
  int w;
  int h;
  int d;
  Polygon rhombus;
  
  EOpp(int _x, int _y, boolean b)
  {
    super("opp", _x, _y, romb_anchors_array, b);
    
    w = (int)rele(65, "h");
    h = (int)rele(65, "h");
    
    d = (int)(sqrt(2)*w);
    
    int[] xs = new int[] {x-d/2, x, x+d/2, x};
    int[] ys = new int[] {y, y-d/2, y, y+d/2};
    
    rhombus = new Polygon(xs, ys, 4);
  }
  
  void display()
  {
    update();
    
    if(mouseHover() || grabbed)
      fill(125, 0, 175);
    else
      fill(100, 0, 150);
    
    noStroke();
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(radians(45));
    rect(0, 0, w, h);
    popMatrix();
    
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(texts);
    textSize(rele(20, "v"));
    text("*(-1)", x, y-rele(16, "v"));
    
    label(adjustFormat(val), x, y+(int)rele(13, "v"), (int)rele(50, "h"), (int)rele(20, "v"),  0, 255, 0,  0, 0, 0);
  }
  
  void update()
  {
    //bounds
    if(x-d/2 < rele(102, "h"))
      x = (int)rele(102, "h")+d/2;
      
    if(x+d/2 > rele(Width-100, "h"))
      x = (int)rele(Width-100, "h")-d/2;
      
    if(y-d/2 < 0)
      y = d/2;
      
    if(y+d/2 > rele(Height, "v"))
      y = (int)rele(Height, "v")-d/2;
    //bounds
    
    if(grabbed)
    {
      int[] xs = new int[] {x-d/2, x, x+d/2, x};
      int[] ys = new int[] {y, y-d/2, y, y+d/2};
      rhombus = new Polygon(xs, ys, 4);
    }
      
    super.update();
  }
  
  
  void active(float v)
  {
    val = v * (-1);
    super.active(val);
  }
  
  
  boolean mouseHover()
  {
    return rhombus.contains(mouseX, mouseY);
  }
}