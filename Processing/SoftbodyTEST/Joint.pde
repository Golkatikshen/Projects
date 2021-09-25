class Joint
{
  Cell c1;
  Cell c2;
  float len;
  float hz;
  
  Joint(Cell c1_, Cell c2_, float len_, float hz_, float damp)
  {
    c1 = c1_;
    c2 = c2_;
    len = len_;
    hz = hz_;
    
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = c1.body;
    djd.bodyB = c2.body;
    djd.length = box2d.scalarPixelsToWorld(len);
    djd.frequencyHz = hz;
    djd.dampingRatio = damp;
    
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
  
  void display()
  {
    Vec2 pos1 = box2d.getBodyPixelCoord(c1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(c2.body);
    stroke(0, 0, 255);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }
}