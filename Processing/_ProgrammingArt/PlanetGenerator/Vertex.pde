class Vertex
{
  PVector v;
  int ia;
  int ib;
  
  Vertex(PVector _v)
  {
    v = _v;
    ia = -1;
    ib = -1;
  }
  
  Vertex(PVector _v, int _ia, int _ib)
  {
    v = _v;
    ia = _ia;
    ib = _ib;
  }
}