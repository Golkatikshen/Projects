class Nuvole
{
  ArrayList<PVector> nuv_pos;
  
  float r;
  float poff;
  float threshhold;
  float x;
  float y;
  float z;
  
  Nuvole()
  {
    nuv_pos = new ArrayList();
    
    r = 150;
    poff = PI/500;
    threshhold = 0.97;
    
    for(float theta = 0; theta<PI; theta+=poff)
    {
      for(float fi = 0; fi<2*PI; fi+=poff)
      {
        x = r*sin(theta)*cos(fi);
        y = r*sin(theta)*sin(fi);
        z = r*cos(theta);
        
        if(noise(x+2000, y+2000, z+2000) > threshhold)
          nuv_pos.add(new PVector(x,y,z));
      }
    }
  }
  
  void display()
  {
    for(PVector v : nuv_pos)
    {
      fill(255, 55);
      translate(v.x, v.y, v.z);
      sphere(28);
    }
  }
}