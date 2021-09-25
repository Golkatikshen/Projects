class Cell
{
  Body body;
  float r;
  
  Cell(float sx, float sy, float r_, float d_)
  {
    r = r_;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(sx, sy));
    body = box2d.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = d_;
    fd.friction = 0.3;
    fd.restitution = 0.2;
    
    body.createFixture(fd);
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255, 0, 0);
    stroke(255);
    ellipse(0, 0, r*2, r*2);
    line(0, 0, 0+r, 0);
    popMatrix();
  }
}