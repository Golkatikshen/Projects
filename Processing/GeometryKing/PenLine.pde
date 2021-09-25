class PenLine
{
  ArrayList<PVector> points;
  float s;
  color c;
  
  PenLine(float _x, float _y, float _s, color _c)
  {
    points = new ArrayList();
    points.add(new PVector(_x, _y));
    s = _s;
    c = _c;
  }
  
  void display()
  {
    strokeWeight(s);
    stroke(c);

    beginShape();
    for(PVector p: points)
      curveVertex(p.x, p.y);
    endShape();
  }
}