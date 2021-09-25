class Wave
{
  ArrayList<Float> y_ver;
  float x;
  float y;
  int len;
  
  Wave(float x_, float y_, int len_)
  {
    y_ver = new ArrayList();
    x = x_;
    y = y_;
    len = len_;
  }
  
  void display()
  {
    if(y_ver.size() > 0)
    {
      noFill();
      stroke(255, 0, 255);
      strokeWeight(1);
      line(x, y, x+len, y);
      beginShape();
      for(int i=1; i<y_ver.size()-1; i++)
        vertex(x+i, y-y_ver.get(i)-10);
      endShape();
      
      fill(0, 255, 0);
      text("Error Graph:", x, y-100);
    }
  }
  
  void addYVer(float yv)
  {
    if(y_ver.size() > len)
      y_ver.remove(0);
    y_ver.add(yv);
  }
}