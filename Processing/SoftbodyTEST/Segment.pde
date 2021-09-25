class Segment
{
  Body b1;
  Body b2;
  
  Body bseg;
  DistanceJoint dj1, dj2;
  Vec2[] vertices;
  
  
  Segment(Body b1_, Body b2_)
  {
    b1 = b1_;
    b2 = b2_;
    
    update();
  }
  
  void update()
  {
    vertices = new Vec2[2];
    vertices[0] = box2d.getBodyPixelCoord(b1);
    vertices[1] = box2d.getBodyPixelCoord(b2);
    
    ChainShape segment = new ChainShape();
    segment.createChain(vertices, 2);
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bseg = box2d.createBody(bd);
    
    
    DistanceJointDef djd1 = new DistanceJointDef();
    djd1.bodyA = b1;
    djd1.bodyB = bseg;
    djd1.localAnchorA.set(0, 0);
    djd1.localAnchorB.set(box2d.coordPixelsToWorld(vertices[0].x, vertices[0].y));
    djd1.collideConnected = false;
    djd1.length = box2d.scalarPixelsToWorld(5);
    djd1.frequencyHz = 1;
    djd1.dampingRatio = 0;
    
    DistanceJointDef djd2 = new DistanceJointDef();
    djd2.bodyA = b2;
    djd2.bodyB = bseg;
    djd2.localAnchorA.set(0, 0);
    djd2.localAnchorB.set(box2d.coordPixelsToWorld(vertices[1].x, vertices[1].y));
    djd2.collideConnected = false;
    djd2.length = box2d.scalarPixelsToWorld(5);
    djd2.frequencyHz = 1;
    djd2.dampingRatio = 0;
    
    dj1 = (DistanceJoint) box2d.world.createJoint(djd1);
    dj2 = (DistanceJoint) box2d.world.createJoint(djd2);
  }
  
  void display()
  {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    line(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y);
  }
}