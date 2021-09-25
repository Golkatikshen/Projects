class Water
{
  Icosphere ico;
  ArrayList<Vertex> ver;
  ArrayList<TriangleIndices> faces;
  color wcol;
  float wspeed;
  
  Water(color _wcol)
  {
    ico = new Icosphere(5, 105);
    ver = ico.ver;
    faces = ico.faces;
    wcol = _wcol;
    wspeed = random(1000, 2000);
    WaterGeneration();
  }
  
  void display()
  {
    for(int i=0; i<faces.size(); i++)
    {
      TriangleIndices currentFace = faces.get(i);
      
      fill(wcol);
        
      beginShape(TRIANGLES);
      vertex(ver.get(currentFace.a).v.x, ver.get(currentFace.a).v.y, ver.get(currentFace.a).v.z);
      vertex(ver.get(currentFace.b).v.x, ver.get(currentFace.b).v.y, ver.get(currentFace.b).v.z);
      vertex(ver.get(currentFace.c).v.x, ver.get(currentFace.c).v.y, ver.get(currentFace.c).v.z);
      endShape();
    }
    
    for(Vertex v : ver)
    {
      PVector p = v.v;
      float r = p.mag();
      float theta = acos(p.z / r);
      float fi = atan2(p.y, p.x);
      fi += PI/wspeed;
      p.set(r*sin(theta)*cos(fi), r*sin(theta)*sin(fi), r*cos(theta));
    }
  }
  
  void WaterGeneration()
  {
    float inc = 0.8;
    float off = 10000;
    float max_height = 1.01;
    
    for(Vertex v : ver)
    {
      PVector p = v.v;
      p.mult(map(noise(off+p.x*inc, off+p.y*inc, off+p.z*inc), 0, 1, 1, max_height));
    }
  }
}