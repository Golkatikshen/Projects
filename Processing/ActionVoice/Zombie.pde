class Zombie
{
  float x;
  float y;
  float r;
  float speed;
  boolean dead;
  
  Zombie(int _x, int _y, int _r)
  {
    x = _x;
    y = _y;
    r = _r;
    speed = 10;
    dead = false;
  }
  
  Zombie()
  {
    x = random(0, width);
    y = random(0, height);
    r = random(25, 35);
    speed = random(8, 15);
    dead = false;
    
    switch((int)random(0, 4))
    {
      case 0:
        x = -40;
      break;
      
      case 1:
        x = width + 40;
      break;
      
      case 2:
        y = -40;
      break;
      
      case 3:
        y = height + 40;
      break;
    }
  }
  
  void update(Player p)
  {
    PVector dir = new PVector(p.x - x, p.y -y);
    dir.normalize();
    dir.mult((float)(speed * deltaTime));
    x += dir.x;
    y += dir.y;
  }
  
  void display()
  {
    stroke(10);
    fill(46, 139, 87);
    ellipse(x, y, r, r);
  }
}