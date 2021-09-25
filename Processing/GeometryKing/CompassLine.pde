class CompassLine
{
  float x;
  float y;
  float w;
  ArrayList<PVector> points;
  boolean pointed;
  boolean aperture_set;
  float s;
  color c;
  
  CompassLine(float _x, float _y, float _s, color _c)
  {
    w = 0;
    x = _x;
    y = _y;
    points = new ArrayList();
    pointed = false;
    aperture_set = false;
    s = _s;
    c = _c;
  }
  
  void display()
  {
    strokeWeight(s);
    
    stroke(100);
    ellipse(x,y,1,1);
    stroke(c);

    beginShape();
    for(PVector p: points)
      curveVertex(p.x, p.y);
    endShape();
  }
}