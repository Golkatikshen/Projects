class QuestTab
{
  float x;
  float y;
  float h;
  float y_off;
  
  String txt;
  
  boolean active;
  
  QuestTab(float _x, float _y, float _h, String _txt)
  {
    x = _x;
    y = _y;
    h = _h;
    y_off = h;
    
    txt = _txt;
  }
  
  void display()
  {
    if(active)
    {
      y_off -= 5*(60/frameRate);
      if(y_off < 0)
        y_off = 0;
    }
    else
    {
      y_off += 5*(60/frameRate);
      if(y_off > h)
        y_off = h;
    }
    
    rectMode(CORNER);
    textAlign(TOP, LEFT);
    
    fill(255);
    rect(x, y-y_off, rele(300, "h"), h);
    
    fill(0);
    rect(x+rele(2, "h"), y+rele(2, "v")-y_off, rele(300, "h")-rele(4, "h"), h-rele(4, "v"));
    
    fill(255);
    textSize(rele(20, "v"));
    text(txt, x+rele(8, "h"), y+rele(8, "v")-y_off, rele(300, "h")-rele(8, "h"), h-rele(8, "v"));
  }
}