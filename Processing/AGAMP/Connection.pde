class Connection
{
  Anchor a;
  Anchor b;
  
  boolean active;
  float active_perc;  
  float vel;
  
  Connection(Anchor _a)
  {
    a = _a;
    b = null;
    active_perc = 0;
  }
  
  void display(int rr, int gg, int bb)
  {
    strokeWeight(2);
    stroke(rr, gg, bb);
    
    
    if((a.e.id.equals("mod") || a.e.id.equals("mult") || a.e.id.equals("div")) && a.e.done == false)
    {
      active = false;
      active_perc = 0;
    }
    
    if(active_perc >= 0.95)
    {
      active = false;
      active_perc = 0;
      if(a.e.id.equals("nil"))
      {
        b.e.done = false;
        b.e.val = 0;
      }
      else
        b.e.active(a.e.val);
        
      stroke(0, 0, 0);
    }
    
    if(b == null)
      drawArrow(a.x, a.y, mouseX, mouseY, 0, 6, false);
    else
      drawArrow(a.x, a.y, b.x, b.y, 0, 6, false);
    
    
    if(active)
    {
      float x = lerp(a.x, b.x, active_perc);
      float y = lerp(a.y, b.y, active_perc);
            
      active_perc += (vel/d(new PVector(a.x, a.y), new PVector(b.x, b.y)))*(60/frameRate);
  
      strokeWeight(4);
      switch((int)random(0, 3))
      {
        case 0:
        stroke(255, 255, 0);
        break;
      
        case 1:
        stroke(255, 248, 31);
        break;
        
        case 2:
        stroke(216, 214, 15);
        break;
      }
      
      line(a.x, a.y, x, y);
    }
    
    strokeWeight(1);
    noStroke();
  }
  
  
  void activate()
  {
    active = true;
  }
}