class MenuLevels
{
  int x;
  int y;
  int yoff;
  ArrayList<MLElement> elements;
  
  Slider lev_slider;
  
  MenuLevels(int _x, int _y)
  {
    x = (int)rele(_x, "h");
    y = (int)rele(_y, "v");
    yoff = 0;
    
    lev_slider = new Slider(Width-180, 140, 615, "");
    
    elements = new ArrayList();
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Hello World!"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Entity TAGS?"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "SUM"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "SUB?"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "3 ? 4 = 12"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "The Powers"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "SQRT -> Square Root"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "The Module is interesting..."));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Add 1"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Add 1 without 1"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Cycle"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "How?"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Pascal's Triangle"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Conditions!"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "The Big Question"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "The PI"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Fibonacci"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "I Love Factorials"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "A bit of Math?"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Even && Odd"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "Pattern Recognition"));
    elements.add(new MLElement(x, y+(elements.size()*(int)rele(120, "v")), (int)rele(700, "h"), (int)rele(100, "v"), elements.size()+1, "bool isPrime(int n)"));
  }
  
  void display()
  {
    for(MLElement e: elements)
    {
      e.y = e.y_mem;
      e.y += yoff;
      e.display();
    }
    
    rectMode(CORNER);
    fill(0);
    stroke(200);
    strokeWeight(2);
    rect(rele(-10, "h"), rele(-10, "v"), rele(1400, "h"), rele(85, "v"));
    rect(rele(-10, "h"), rele(805, "v"), rele(1400, "h"), rele(200, "v"));
    noStroke();
    
    
    textAlign(LEFT, TOP);
    textFont(digits);
    textSize((int)rele(40, "v"));
    fill(255);
    text("Levels:", 15, 15);
    
    lev_slider.display();
  }
  
  
  void scroll(int v)
  {
    if(!lev_slider.selected)
    {
      yoff += (v*10);
      
      if(yoff > 0)
        yoff = 0;
        
      if(elements.size() <= 6)
        yoff = 0;
      else
      {
        int exc = elements.size() - 6;
        if(yoff < (int)rele(-120, "v") * exc)
          yoff = (int)rele(-120, "v") * exc;
      }
      
      int exc = elements.size() - 6;
      float pos = yoff * 100 / (rele(-120, "v") * exc);
      lev_slider.y_off = lev_slider.len * pos / 100;
    }
  }
  
  
  void mlmouseDragged()
  {
    lev_slider.smouseDragged();
    
    int exc = elements.size() - 6;
    float pos = (lev_slider.y_off * 100 / lev_slider.len);
    yoff = (int)(rele(-120, "v") * exc * pos) / 100;
  }
  
  void mlmouseReleased()
  {
    lev_slider.smouseReleased();
  }
}