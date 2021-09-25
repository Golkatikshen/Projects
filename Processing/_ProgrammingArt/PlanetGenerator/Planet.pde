class Planet
{
  Icosphere ico;
  ArrayList<Vertex> ver;
  ArrayList<TriangleIndices> faces;
  
  Water water;
  Nuvole nuvole;
  
  Planet()
  {
    ico = new Icosphere(5, 100);
    ver = ico.ver;
    faces = ico.faces;
    
    water = new Water(color(0, 255, 0, 80));
    nuvole = new Nuvole();
    
    TerrainGeneration();
  }
  
  void display()
  {
    for(int i=0; i<faces.size(); i++)
    {
      TriangleIndices currentFace = faces.get(i);
      
      fill(currentFace.col);
        
      beginShape(TRIANGLES);
      vertex(ver.get(currentFace.a).v.x, ver.get(currentFace.a).v.y, ver.get(currentFace.a).v.z);
      vertex(ver.get(currentFace.b).v.x, ver.get(currentFace.b).v.y, ver.get(currentFace.b).v.z);
      vertex(ver.get(currentFace.c).v.x, ver.get(currentFace.c).v.y, ver.get(currentFace.c).v.z);
      endShape();
    }
    
    water.display();
    nuvole.display();
  }
  
  void TerrainGeneration()
  {
    noiseDetail(1);
    noiseSeed((long)(random(0, 2000000000)));
    
    float inc = random(0.02, 0.05);
    float off = 10000;
    float max_height = 1.2;
    
    for(Vertex v : ver)
    {
      PVector p = v.v;
      p.mult(map(noise(off+p.x*inc, off+p.y*inc, off+p.z*inc), 0, 1, 1, max_height));
    }
    
    for(int i=0; i<faces.size(); i++)
    {
      TriangleIndices currentFace = faces.get(i);
      PVector heightLevel = PVector.add(ver.get(currentFace.a).v.copy(), ver.get(currentFace.b).v.copy(), ver.get(currentFace.c).v.copy());
      heightLevel.div(2);
      float h = heightLevel.mag();
      
      if(h < ico.radius*1.05)
        faces.get(i).col = color(0, 0, 255);
      else if(h < ico.radius*1.07)
        faces.get(i).col = color(0, 255, 0);
      else
        faces.get(i).col = color(102, 51, 0);
    }
  }
}