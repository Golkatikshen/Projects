public class Entity
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float c;
  
  ArrayList<FadingRed> trail;
  int n_trails;
  
  Entity(int x, int y)
  {
    //FORCES
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 10;
    c = 0.1;
    
    
    //TRAIL
    trail = new ArrayList<FadingRed>();
    n_trails = 100;
  }
  
  void update()
  {
    //FORCES
    //-friction
    PVector friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    
    applyForce(friction);
    
    velocity.add(acceleration);
    velocity.limit(10);
    position.add(velocity);
    
    acceleration.mult(0);
    
    
    //TRAIL
    if(trail.size() < n_trails)
    {
      if(trail.size() >= 1)
      {
        if(trail.get(trail.size()-1).w == 50)
          trail.add(new FadingRed(position.x, position.y));
      }
      else
        trail.add(new FadingRed(position.x, position.y));
    }
      
      
    for(int i=0; i<trail.size(); i++)
    {
      trail.get(i).update();
      if(trail.get(i).w == 0)
        trail.remove(i);
    }
    
    
    //BOUNDs
    if(position.x - 55/2 < 0)
    {
      position.x = 55/2;
      velocity.x = 0;
    }
    
    if(position.y - 55/2 < 0)
    {
      position.y = 55/2;
      velocity.y = 0;
    }
    
    if(position.x + 55/2 > width)
    {
      position.x = width - 55/2;
      velocity.x = 0;
    }
    
    if(position.y + 55/2 > height)
    {
      position.y = height  - 55/2;
      velocity.y = 0;
    }
  }
  
  void display()
  {
    for(int i=0; i<trail.size(); i++)
      trail.get(i).display();
      
    stroke(255);
    fill(100);
    ellipse(position.x, position.y, 55, 55);
  }
  
  void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}