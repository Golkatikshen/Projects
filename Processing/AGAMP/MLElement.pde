class MLElement
{
  int x;
  int y;
  int w;
  int h;
  int b;
  int y_mem;
  int n_level;
  String title;
  
  boolean completed;
  Button btn_start;
  
  
  MLElement(int _x, int _y, int _w, int _h, int _n_level, String _title)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    b = (int)rele(6, "v");
    if(b < 4)
      b = 4;
      
    y_mem = y;
    n_level = _n_level;
    title = _title;
    
    completed = false;
    btn_start = new Button(x+w/2-rele(80, "h"), y+h/2-rele(20, "v"), 140, 25, "START", 4, -2, 0, 255, 0);
  }
  
  void display()
  {
    rectMode(CENTER);
    fill(255);
    rect(x, y, w+b, h+b);
    fill(10);
    rect(x, y, w, h);
    
    textAlign(LEFT, TOP);
    textFont(digits);
    textSize(rele(30, "v"));
    fill(255);
    text(title, x-w/2+rele(5, "h"), y-h/2+rele(5, "v"));
    
    textSize(rele(14, "v"));
    text("Level: " + n_level, x-w/2+rele(5, "h"), y-h/2+rele(40, "v"));
    
    if(completed)
    {
      textAlign(RIGHT, TOP);
      fill(0, 255, 0);
      textFont(alt1);
      textSize(rele(45, "v"));
      text("COMPLETED", x+w/2-rele(5, "h"), y-h/2+rele(5, "v"));
    }
    
    btn_start.x = x+w/2-rele(80, "h");
    btn_start.y = y+h/2-rele(20, "v");
    btn_start.display();
  }
}