class Icosphere
{
  float f;
  float radius;
  ArrayList<Vertex> ver;
  ArrayList<TriangleIndices> faces;
  
  Icosphere(int ref_times, float _radius)
  {
    f = phi;
    radius = _radius;
    ver = new ArrayList();
    faces = new ArrayList();
    
    ver.add(new Vertex(new PVector(-1, f, 0)));
    ver.add(new Vertex(new PVector(1, f, 0)));
    ver.add(new Vertex(new PVector(-1, -f, 0)));
    ver.add(new Vertex(new PVector(1, -f, 0)));
    
    ver.add(new Vertex(new PVector(0, -1, f)));
    ver.add(new Vertex(new PVector(0, 1, f)));
    ver.add(new Vertex(new PVector(0, -1, -f)));
    ver.add(new Vertex(new PVector(0, 1, -f)));
    
    ver.add(new Vertex(new PVector(f, 0, -1)));
    ver.add(new Vertex(new PVector(f, 0, 1)));
    ver.add(new Vertex(new PVector(-f, 0, -1)));
    ver.add(new Vertex(new PVector(-f, 0, 1)));
    
    for(int i=0; i<ver.size(); i++)
      ver.get(i).v.normalize().mult(radius);
      
    faces.add(new TriangleIndices(0, 11, 5));
    faces.add(new TriangleIndices(0, 5, 1));
    faces.add(new TriangleIndices(0, 1, 7));
    faces.add(new TriangleIndices(0, 7, 10));
    faces.add(new TriangleIndices(0, 10, 11));
    faces.add(new TriangleIndices(1, 5, 9));
    faces.add(new TriangleIndices(5, 11, 4));
    faces.add(new TriangleIndices(11, 10, 2));
    faces.add(new TriangleIndices(10, 7, 6));
    faces.add(new TriangleIndices(7, 1, 8));
    faces.add(new TriangleIndices(3, 9, 4));
    faces.add(new TriangleIndices(3, 4, 2));
    faces.add(new TriangleIndices(3, 2, 6));
    faces.add(new TriangleIndices(3, 6, 8));
    faces.add(new TriangleIndices(3, 8, 9));
    faces.add(new TriangleIndices(4, 9, 5));
    faces.add(new TriangleIndices(2, 4, 11));
    faces.add(new TriangleIndices(6, 2, 10));
    faces.add(new TriangleIndices(8, 6, 7));
    faces.add(new TriangleIndices(9, 8, 1));
    
    for(int i=0; i<ref_times; i++)
      refine();
  }
  
  void refine()
  {
    ArrayList<TriangleIndices> new_faces = new ArrayList();
    
    for(int i=0; i<faces.size(); i++)
    {
      int nab = getMiddlePoint(faces.get(i).a, faces.get(i).b);
      int nac = getMiddlePoint(faces.get(i).a, faces.get(i).c);
      int nbc = getMiddlePoint(faces.get(i).b, faces.get(i).c);
      
      new_faces.add(new TriangleIndices(faces.get(i).a, nac, nab));
      new_faces.add(new TriangleIndices(faces.get(i).b, nbc, nab));
      new_faces.add(new TriangleIndices(faces.get(i).c, nac, nbc));
      new_faces.add(new TriangleIndices(nab, nac, nbc));
    }
    
    faces = new_faces;
  }
  
  int getMiddlePoint(int a, int b)
  {    
    for(int i=0; i<ver.size(); i++)
    {
      if((ver.get(i).ia == a && ver.get(i).ib == b) || (ver.get(i).ia == b && ver.get(i).ib == a))
        return i;
    }
    
    PVector ap = ver.get(a).v;
    PVector bp = ver.get(b).v;
    PVector mp = new PVector((ap.x+bp.x)/2, (ap.y+bp.y)/2, (ap.z+bp.z)/2);
    
    mp.normalize();
    mp.mult(radius);
    
    ver.add(new Vertex(mp, a, b));
    
    return (ver.size()-1);
  }
  
  
}