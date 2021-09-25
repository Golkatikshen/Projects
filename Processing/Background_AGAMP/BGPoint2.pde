class BGPoint2
{
  PVector pos;
  PVector dir;
  
  float ht;
  
  Polygon triangle;
  
  
  BGPoint2(int x, int y)
  {
    pos = new PVector(x, y);
    dir = PVector.random2D();
    
    ht = 0;
    
    float rot;
    rot = random(0, 360);
    float ndeg = 360 / 3;
    
    int a = 50;
    
    int[] xp = new int[3];
    int[] yp = new int[3];
    
    for(int i=0; i<360; i+=ndeg)
    {
      xp[(int)(i/ndeg)] = (int)(cos(radians(i+rot)) * a);
      yp[(int)(i/ndeg)] = (int)(sin(radians(i+rot)) * a);
    }
    
    triangle = new Polygon(xp, yp, 3);
  }
  
  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);  
    
    fill(ht/40);
    ht-=5;
    if(mouseHover())
      ht = 255;
    
    stroke(5);
    
    beginShape();
    vertex(triangle.xpoints[0], triangle.ypoints[0]);
    vertex(triangle.xpoints[1], triangle.ypoints[1]);
    vertex(triangle.xpoints[2], triangle.ypoints[2]);
    endShape(CLOSE);
    popMatrix();
    
    pos.add(dir);
    if(pos.x < 0 || pos.x > width)
      dir.x *= -1;
    if(pos.y < 0 || pos.y > height)
      dir.y *= -1;
  }
  
  boolean mouseHover()
  {
    return triangle.contains(mouseX-pos.x, mouseY-pos.y);
  }
}