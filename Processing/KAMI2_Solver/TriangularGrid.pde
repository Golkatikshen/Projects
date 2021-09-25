class TriangularGrid
{
  float x;
  float y;
  int R;
  int C;
  
  Triangle[][] triangles;
  ArrayList<ArrayList<Triangle>> groups;
  
  float r;
  float l;
  float h;
  float a;
  
  TriangularGrid(float _x, float _y, int _R, int _C, float _r)
  {
    x = _x;
    y = _y;
    R = _R;
    C = _C;
    
    r = _r;
    l = r*sqrt(3);
    h = 1.5f*r;
    a = (1f/3f)*h;
    
    triangles = new Triangle[R][C];
    groups = new ArrayList();
    
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
          triangles[i][j] = new Triangle(x + x_off(i, j) + a*(i%2), y + (l/2)*i, r, 180*((j+(i%2))%2));
          
    createLinks();
  }
  
  TriangularGrid cloneTG()
  {
    TriangularGrid ntg = new TriangularGrid(x, y, R, C, r);
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        ntg.triangles[i][j] = triangles[i][j].cloneTriangle();
    ntg.createLinks();
    return ntg;
  }
  
  void display()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        triangles[i][j].display();
  }
  
  float x_off(int i, int j)
  {
    i = i%2;
    float val = x;
    
    for(int k=0; k<j; k++)
    {
      if(i==0)
      {
        if(k%2 == 0)
          val += 2*r;
        else
          val += 2*a;
      }
      else
      {
        if(k%2 == 1)
          val += 2*r;
        else
          val += 2*a;
      }
    }
    
    return val;
  }
  
  String getCoordTriangle(Triangle t)
  {    
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
      {
        if(t == triangles[i][j])
          return "["+i+","+j+"]";
      }
        
    return "null";
  }
  
  void createGroups()
  {
    groups.clear();
    
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
      {
        if(triangles[i][j].c != color(0) && notInGroup(triangles[i][j]))
        {
          groups.add(new ArrayList());
          ArrayList<Triangle> al = new ArrayList();
          al = triangles[i][j].addLinked(al);          
          groups.get(groups.size()-1).addAll(al);
        }
      }
  }
  
  boolean notInGroup(Triangle t)
  {
    for(int i=0; i<groups.size(); i++)
    {
      if(groups.get(i).contains(t))
        return false;
    }
    
    return true;
  }
  
  void createLinks()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        triangles[i][j].linked.clear();
        
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
      {
        if(triangles[i][j].c != color(0))
        {
          if(i != 0)
          {
            if(triangles[i-1][j].c == triangles[i][j].c && triangles[i-1][j].c != color(0))
              triangles[i][j].linked.add(triangles[i-1][j]);
          }
          
          if(i != R-1)
          {
            if(triangles[i+1][j].c == triangles[i][j].c && triangles[i+1][j].c != color(0))
              triangles[i][j].linked.add(triangles[i+1][j]);
          }
          
          if((j+(i%2))%2 == 0 && j != 0)
          {
            if(triangles[i][j-1].c == triangles[i][j].c && triangles[i][j-1].c != color(0))
              triangles[i][j].linked.add(triangles[i][j-1]);
          }
          
          if((j+(i%2))%2 == 1 && j != C-1)
          {
            if(triangles[i][j+1].c == triangles[i][j].c && triangles[i][j+1].c != color(0))
              triangles[i][j].linked.add(triangles[i][j+1]);
          }
        }
      }
  }
  
  boolean allSameColor()
  {
    boolean found = false;
    color ac = color(0);
    
    for(int i=0; i<R && !found; i++)
      for(int j=0; j<C && !found; j++)
        if(triangles[i][j].c != color(0))
        {
          ac = triangles[i][j].c;
          found = true;
        }
        
    
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        if(triangles[i][j].c != ac && triangles[i][j].c != color(0))
          return false;
            
    return true;
  }
  
  void mouseHover()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
      {
        if(triangles[i][j].pointInsideTriangle(new PVector(mouseX, mouseY)))
          triangles[i][j].c = color(100);
        else
          triangles[i][j].c = color(0);
      }
  }
  
  void tgmouseDragged()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        if(triangles[i][j].pointInsideTriangle(new PVector(mouseX, mouseY)))
          triangles[i][j].colorSelf(selected_color);
      
    createLinks();
  }
  
  void tgmouseClicked()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        if(triangles[i][j].pointInsideTriangle(new PVector(mouseX, mouseY)))
          triangles[i][j].colorSelfLinked(selected_color);
          
    createLinks();
  }
  
  void colorAll(color cl)
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
        triangles[i][j].c = cl;
    
    createLinks();
    createGroups();
  }
  
  String coordMouseHover()
  {
    for(int i=0; i<R; i++)
      for(int j=0; j<C; j++)
      {
        if(triangles[i][j].pointInsideTriangle(new PVector(mouseX, mouseY)))
          return "["+i+","+j+"]";
      }
      
    return "nothing";
  }
}