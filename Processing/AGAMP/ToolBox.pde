class ToolBox
{
  int index_element;
  
  int tab;
  
  ArrayList<TBElement> elements;
  ArrayList<TBElement> elements_basics;
  ArrayList<TBElement> elements_math;
  ArrayList<TBElement> elements_energy;
  
  int yoff;
  
  Button btn_basics;
  Button btn_math;
  Button btn_logic;
  
  
  ToolBox()
  {
    yoff = 0;
    tab = 0;
    
    btn_basics = new Button(50, 820, 80, 20, "BASICS", 2, -2, 0, 0, 255);
    btn_math = new Button(50, 850, 80, 20, "MATH", 2, -2, 0, 0, 255);
    btn_logic = new Button(50, 880, 80, 20, "LOGIC", 2, -2, 0, 0, 255);
    
    elements = new ArrayList();
    elements_basics = new ArrayList();
    elements_math = new ArrayList();
    elements_energy = new ArrayList();

    
    elements.add(new TBElement(50, 50, 100, 100, "LINK"));
    elements.add(new TBElement(50, 150, 100, 100, "NUM"));
    elements.add(new TBElement(50, 250, 100, 100, "NIL"));
    elements.add(new TBElement(50, 350, 100, 100, "DEL"));

    elements_basics.add(new TBElement(50, 50, 100, 100, "LINK"));
    elements_basics.add(new TBElement(50, 150, 100, 100, "NUM"));
    elements_basics.add(new TBElement(50, 250, 100, 100, "NIL"));
    elements_basics.add(new TBElement(50, 350, 100, 100, "DEL"));
    
    elements_math.add(new TBElement(50, 50, 100, 100, "SUM"));
    elements_math.add(new TBElement(50, 150, 100, 100, "OPP"));
    elements_math.add(new TBElement(50, 250, 100, 100, "MULT"));
    elements_math.add(new TBElement(50, 350, 100, 100, "DIV"));
    elements_math.add(new TBElement(50, 450, 100, 100, "SQRT"));
    elements_math.add(new TBElement(50, 550, 100, 100, "MOD"));
    
    elements_energy.add(new TBElement(50, 50, 100, 100, "="));
    elements_energy.add(new TBElement(50, 150, 100, 100, ">"));
    elements_energy.add(new TBElement(50, 250, 100, 100, "<"));
  }
  
  void display()
  {
    for(TBElement tbe: elements)
    {
      tbe.y = tbe.y_mem;
      tbe.y += yoff;
      tbe.display();
    }
    
    fill(255);
    rectMode(CORNER);
    rect(rele(100, "h"), rele(0, "v"), rele(2, "h"), rele(1000, "v"));
    fill(0);
    rect(rele(0, "h"), rele(800, "v"), rele(100, "h"), rele(100, "v"));
    fill(255);
    rect(rele(0, "h"), rele(800, "v"), rele(100, "h"), rele(2, "v"));
    
    btn_basics.display();
    btn_math.display();
    btn_logic.display();
  }
  
  
  void tbmousePressed()
  {
    if(mouseButton == LEFT)
    {
      if(mouseHover())
        for(int i=0; i<elements.size(); i++)
        {
          if(elements.get(i).mouseHover())
          {
            elements.get(i).selected = true;
            index_element = i+1;
          }
          else
            elements.get(i).selected = false;
        }
        
        
      if(btn_basics.mouseHover())
      {
        tab = 0;
        index_element = 0;
        elements.clear();
        for(TBElement tbe : elements_basics)
          elements.add(tbe);
      }
      
      if(btn_math.mouseHover())
      {
        tab = 1;
        index_element = 0;
        elements.clear();
        for(TBElement tbe : elements_math)
          elements.add(tbe);
      }
      
      if(btn_logic.mouseHover())
      {
        tab = 2;
        index_element = 0;
        elements.clear();
        for(TBElement tbe : elements_energy)
          elements.add(tbe);
      }
    }
        
    if(mouseButton == RIGHT)
    {
      for(TBElement tbe: elements)
        tbe.selected = false;
      index_element = 0;
    }
  }
  
  void scroll(int v)
  {
    if(mouseHover())
    {
      yoff += (v*10);
      
      if(yoff > 0)
        yoff = 0;
        
      if(elements.size() <= 8)
        yoff = 0;
      else
      {
        int exc = elements.size() - 8;
        if(yoff < rele(-100, "v") * exc)
          yoff = (int)rele(-100, "v") * exc;
      }
    }
  }
  
  
  
  boolean mouseHover()
  {
    return (mouseX > 0 && mouseX < rele(100, "h"));
  }
}