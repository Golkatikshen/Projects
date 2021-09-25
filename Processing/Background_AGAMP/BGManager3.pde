class BGManager3
{
  BGPoint3[] points;
  
  BGManager3()
  {
    points = new BGPoint3[100];
    
    for(int i=0; i<points.length; i++)
      points[i] = new BGPoint3(random(0, width), random(0, height));
  }
  
  void display()
  {
    for(int i=0; i<points.length; i++)
      points[i].setVicini(points);
      
    for(int i=0; i<points.length; i++)
      points[i].display();
  }
}