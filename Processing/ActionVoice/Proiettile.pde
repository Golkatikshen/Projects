class Proiettile
{
  float x;
  float y;
  float d;
  PVector dir;
  float speed;
  
  Proiettile(float _x, float _y, PVector _dir)
  {
    x = _x;
    y = _y;
    d = 10;
    dir = _dir;
    speed = 200;
    dir.mult(speed);
  }
  
  boolean run(Zombie[] zombies)
  { 
    update();
    display();
    
    for(Zombie z: zombies)
    {
      if(z != null)
        if(((x-z.x)*(x-z.x))+((y-z.y)*(y-z.y)) < ((d/2) + (z.r/2))*((d/2) + (z.r/2)))
        {
          z.dead = true;
          return true;
        }
    }
    
    if(x < 0 || x > width || y < 0 || y > height)
      return true;
    
    return false;
  }
  
  void update()
  {
    x += dir.x * deltaTime;
    y += dir.y * deltaTime;
  }
  
  void display()
  {
    fill(0);
    ellipse(x, y, d, d);
  }
}