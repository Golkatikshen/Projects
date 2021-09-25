class Triangle
{
  float x;
  float y;
  float r;
  float angle;
  color c;
  PVector p1, p2, p3;
  ArrayList<Triangle> linked;
  
  
  Triangle(float _x, float _y, float _r, float _angle)
  {
    x = _x;
    y = _y;
    r = _r;
    angle = _angle;
    c = color(255, 0, 0);
    
    p1 = new PVector(x+r*cos(angle*DEG_TO_RAD), y+r*sin(angle*DEG_TO_RAD));
    p2 = new PVector(x+r*cos((120+angle)*DEG_TO_RAD), y+r*sin((120+angle)*DEG_TO_RAD));
    p3 = new PVector(x+r*cos((240+angle)*DEG_TO_RAD), y+r*sin((240+angle)*DEG_TO_RAD));
    
    linked = new ArrayList();
  }
  
  Triangle cloneTriangle()
  {
    Triangle t = new Triangle(x, y, r, angle);
    t.c = c;
    return t;
  }
  
  void display()
  {
    stroke(255);
    fill(c);
    
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    endShape(CLOSE);
  }
  
  void colorSelfLinked(color nc)
  {
    c = nc;
    for(Triangle t: linked)
    {
      if(nc != t.c)
        t.colorSelfLinked(nc);
    }
  }
  
  ArrayList<Triangle> addLinked(ArrayList<Triangle> al)
  {
    ArrayList<Triangle> tra = new ArrayList();
    tra.add(this);
    al.add(this);
    
    for(Triangle t: linked)
    {
      if(!al.contains(t))
      {
        ArrayList<Triangle> nl = new ArrayList();
        nl = t.addLinked(al);
        tra.addAll(nl);
      }
    }

    return tra;
  }
  
  void colorSelf(color nc)
  {
    c = nc;
  }
  
  boolean pointInsideTriangle(PVector s)
  {
    PVector a = p1;
    PVector b = p2;
    PVector c = p3;
    
    float as_x = s.x-a.x;
    float as_y = s.y-a.y;

    boolean s_ab = (b.x-a.x)*as_y-(b.y-a.y)*as_x > 0;

    if((c.x-a.x)*as_y-(c.y-a.y)*as_x > 0 == s_ab) 
      return false;

    if((c.x-b.x)*(s.y-b.y)-(c.y-b.y)*(s.x-b.x) > 0 != s_ab) 
      return false;

    return true;
  }
}