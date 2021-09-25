class BGManager2
{
  ArrayList<BGPoint2> triangles;
  
  BGManager2()
  {
    triangles = new ArrayList();
    
    for(int i=0; i<350; i++)
      triangles.add(new BGPoint2((int)random(0, width), (int)random(0, height)));
  }
  
  void display()
  {
    for(BGPoint2 p: triangles)
      p.display();
  }
}