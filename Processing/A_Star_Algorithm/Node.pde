class Node
{
  int H;
  int G;
  int F;
  
  int x;
  int y;
  int w;
  
  boolean start;
  boolean end;
  boolean wall;
  
  boolean over;
  
  boolean open;
  boolean closed;
  boolean final_path;
  
  Node[] neighbours;
  Node parent;
  
  
  Node(int _x, int _y, int _w)
  {
    x = _x;
    y = _y;
    w = _w;
    
    neighbours = new Node[8];
  }
  
  
  void display()
  {
    if(start)
      fill(130, 215, 55);
    else if(end)
      fill(240, 150, 70);
    else if(wall)
      fill(0);
    else if(final_path)
      fill(255, 0, 0);
    else if(closed)
      fill(0, 255, 255);
    else if(open)
      fill(255, 255, 0);
    else
      fill(255);
      
    stroke(0);
    rect(x*w, y*w, w, w);
    
    if(false)
    {
      if(!start && !end && (open || closed))
      {
        fill(0, 140, 140);
        text(""+(int)H, x*w + (w/10)*7, y*w + (w/10)*2);
        if(G > 0)
        {
          fill(200, 140, 0);
          text(""+(int)G, x*w + (w/10)*7, y*w + (w/10)*4);
          fill(200, 0, 240);
          text(""+(int)F, x*w + (w/10)*7, y*w + (w/10)*6);
        }
      }
    }
    
    if(over)
    {
      fill(255, 0, 0);
      ellipse(x*w+w/2, y*w+w/2, w/4, w/4);
    }
  }
  
  void displayParent()
  {
    if(parent != null)
    {
      stroke(255, 0, 255);
      line(x*w+w/2, y*w+w/2, parent.x*w+w/2, parent.y*w+w/2);
    }
  }
  
  void calcF()
  {
    F = H + G;
  }
  
  boolean mouseIsHover()
  {
    return(x*w < mouseX && x*w+w >= mouseX && y*w < mouseY && y*w+w >= mouseY);
  }
  
  boolean mouseIsNear(float v)
  {
    float d = ((x*w+w/2) - mouseX) * ((x*w+w/2) - mouseX) + ((y*w+w/2) - mouseY) * ((y*w+w/2) - mouseY);
    
    return(d < (v * v));
  }
}