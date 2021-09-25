class BSoftbody
{
  ArrayList<Cell> cells;
  ArrayList<Joint> joints;
  boolean showSkeleton;
  boolean showJoints;
  boolean showCells;
  
  
  BSoftbody(int x, int y, int n_cells, float r, float len)
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
        cells.add(new Cell(x+cos(radians(pgrad * i))*(len), y+sin(radians(pgrad * i))*(len), r*2, 1));
        
      cells.get(cells.size()-1).body.setFixedRotation(true);
    }
    
    for(int i=0; i<n_cells-1; i++)
    {
      if(i+1 == n_cells-1)
        joints.add(new Joint(cells.get(i), cells.get(0), r*4, 6, 0.1));
      else
        joints.add(new Joint(cells.get(i), cells.get(i+1), r*4, 6, 0.1));

      joints.add(new Joint(cells.get(i), cells.get(n_cells-1), len, 5, 0.1));
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
        if(i==0 || i+1 == cells.size()-1)
          curveVertex(pos.x, pos.y);
        curveVertex(pos.x, pos.y);
      }
      endShape(CLOSE);
    }
  }
}