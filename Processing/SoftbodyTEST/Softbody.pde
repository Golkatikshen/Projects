class Softbody
{
  ArrayList<Cell> cells;
  ArrayList<Joint> joints;
  boolean showSkeleton;
  boolean showJoints;
  boolean showCells;
  
  Softbody(int x, int y, int n_cells, int w_cells, float len)
  {
    cells = new ArrayList();
    joints = new ArrayList();
    showSkeleton = true;
    showJoints = true;
    showCells = true;
     
    float pgrad = 360 / n_cells;
    n_cells ++;
    
    for(int i=0; i<n_cells; i++)
    {
      if(i+1 == n_cells)
        cells.add(new Cell(x, y, len/2, 0.01));
      else
        cells.add(new Cell(x+cos(radians(pgrad * i))*(len+10), y+sin(radians(pgrad * i))*(len+10), w_cells, 1));
        
      cells.get(cells.size()-1).body.setFixedRotation(true);
    }
    
      
    for(int i=0; i<n_cells-1; i++)
    {
      for(int j=i+1; j<n_cells; j++)
      {
        if(j+1 == n_cells)
          joints.add(new Joint(cells.get(i), cells.get(j), len, 3, 0.1));
        else
          joints.add(new Joint(cells.get(i), cells.get(j), len, 4, 0.1));
      }
    }
  }
  
  

  void display()
  {
    if(showCells)
    {
      for(Cell c: cells)
        c.display();
    }
    
    if(showJoints)
    {
      for(Joint j: joints)
        j.display();
    }
    
    if(!showSkeleton)
    {
      beginShape();
      fill(255, 0, 0);
      for(int i=0; i<cells.size()-1; i++)
      {
        Cell c = cells.get(i);
        Vec2 pos = box2d.getBodyPixelCoord(c.body);
        vertex(pos.x, pos.y);
      }
      endShape(CLOSE);
    }
  }
}