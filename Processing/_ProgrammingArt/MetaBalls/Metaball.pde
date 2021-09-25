class Metaball
{
  PVector pos;
  PVector vel;
  float r;
  float speed;
  
  Metaball(float _r, float _speed)
  {
    r = _r;
    speed = _speed;
    
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D();
    vel.normalize();
    vel.mult(speed);
  }
  
  void update()
  {
    pos.add(vel);
    
    if(pos.x <= 0 || pos.x >= width)
      vel.x *= -1;
      
    if(pos.y <= 0 || pos.y >= height)
      vel.y *= -1;
  }
  
  void display()
  {
    noFill();
    stroke(0);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}