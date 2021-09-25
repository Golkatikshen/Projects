class Entity
{
  int x;
  int y;
  ArrayList<Anchor> anchors;
  int[][] anchor_pos;
  
  float val;
  boolean grabbed;
  PVector grab_point;
  
  boolean deletable;
  boolean deleted;
  boolean done;
  
  String id;
  int nid;
  
  Entity(String _id, int _x, int _y, int[][] _anchor_pos, boolean rel)
  {
    id = _id;
    if(rel)
    {
      x = (int)rele(_x, "h");
      y = (int)rele(_y, "v");
    }
    else
    {
      x = _x;
      y = _y;
    }
    
    anchor_pos = _anchor_pos;
    
    grabbed = false;
    grab_point = new PVector();
    
    deletable = true;
    deleted = false;
    done = false;
    
    anchors = new ArrayList();
    
    for(int i=0; i<anchor_pos.length; i++)
      anchors.add(new Anchor(rele(anchor_pos[i][0], "h"), rele(anchor_pos[i][1], "h"), this));
  }
  
  
  void update()
  {
    for(int i=0; i<anchor_pos.length; i++)
    {
      anchors.get(i).x = rele(anchor_pos[i][0], "h") + x;
      anchors.get(i).y = rele(anchor_pos[i][1], "h") + y;
    }
  }
  
  void display()
  {
    for(Anchor a: anchors)
      a.display();
  }
  
  
  void active(float v)
  {
    for(Anchor an: anchors)
    {
      if(an.c != null)
        if(an.c.a.e == an.e)
          an.c.activate();
    }
  }
  
  
  boolean mouseHover()
  {
    return ((mouseX > x-70/2 && mouseX < x+70/2) && (mouseY > y-70/2 && mouseY < y+70/2));
  }
}