class Line
{
  String text;
  String t_pu;
  int index_string;
  boolean sel;
  int id;
  
  Line(int _id)
  {
    text = "";
    t_pu = "";
    sel = false;
    index_string = 0;
    id = _id;
  }
  
  void display(int x, int y)
  {
    textAlign(LEFT, BOTTOM);
    textSize(rele(10, "v"));
    fill(150);
    text(nf(id, 4), x, y);
    
    fill(0, 255, 0);
    textSize(rele(20, "v"));
    text(text, x+rele(32, "h"), y+rele(1, "v"));
    if(sel)
      text(t_pu, x+rele(32, "h"), y+rele(4, "v"));
      
    textAlign(LEFT);
  }
  
  void insert(char c)
  {
    text = text.substring(0, index_string) + c + text.substring(index_string);
    index_string++;
    updatePuntator();
  }
  
  void cancel()
  {
    if(index_string < 0)
      index_string = 0;
    if(index_string > text.length())
      index_string = text.length();
          
    if(index_string >= 1)
    {
      text = text.substring(0, index_string-1) + text.substring(index_string);
      index_string--;
      updatePuntator();
    }
  }
  
  void updatePuntator()
  {
    if(index_string < 0)
      index_string = 0;
    if(index_string > text.length())
      index_string = text.length();
      
    t_pu = " ";
    for(int i=0; i<text.length(); i++)
      t_pu += " ";
      
    t_pu = t_pu.substring(0, index_string) + "_" + t_pu.substring(index_string);
  }
}