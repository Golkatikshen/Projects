class BGTriangManager
{
  BGPoint[] points;
  float inc_nfac;
  
  BGTriangManager()
  {
    points = new BGPoint[200];
    
    for(int i=0; i<200; i++)
      points[i] = new BGPoint();
      
    inc_nfac = 0.006;
  }
  
  void display()
  {
    fill(0);
    stroke(15);
    beginShape(TRIANGLE_STRIP);
    for(BGPoint p: points)
    {
      vertex(p.p.x, p.p.y);
      
      p.p.x = map(noise(p.x_nfac), 0, 1, -500, width+500);
      p.p.y = map(noise(p.y_nfac), 0, 1, -500, height+500);
      
      p.x_nfac += inc_nfac;
      p.y_nfac += inc_nfac;
      
      if(p.x_nfac > 2000000000)
        p.x_nfac = random(0, 100000);
        
      if(p.y_nfac > 2000000000)
        p.y_nfac = random(0, 100000);
    }
    endShape();
  }
}

class BGPoint
{
  PVector p;
  float x_nfac;
  float y_nfac;
  
  BGPoint()
  {
    p = new PVector(random(0, width), random(0, height));
    x_nfac = random(0, 100000);
    y_nfac = random(0, 100000);
  }
}