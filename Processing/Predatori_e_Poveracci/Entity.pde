public class Entity
{
  float d;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float c;
  float G;

  Entity(float x, float y, float d)
  {
    this.d = d;
    //FORCES
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 10;
    c = 0.1;
    G = 1;
  }
  
  void update()
  {
    //FORCES
      //friction
    PVector friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    
    applyForce(friction);
      //friction
    
    
    velocity.add(acceleration);
    velocity.limit(10);
    position.add(velocity);
    
    acceleration.mult(0);
    
    
    //BOUND
    if(position.x - d/2 < 0)
    {
      position.x = d/2;
      velocity.x = 0;
    }
    
    if(position.y - d/2 < 0)
    {
      position.y = d/2;
      velocity.y = 0;
    }
    
    if(position.x + d/2 > width)
    {
      position.x = width - d/2;
      velocity.x = 0;
    }
    
    if(position.y + d/2 > height)
    {
      position.y = height  - d/2;
      velocity.y = 0;
    }
  }
  
  void display()
  {
    stroke(255);
    fill(100);
    ellipse(position.x, position.y, d, d);
  }
  
  void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  PVector attract(Entity e)
  {
    PVector force = PVector.sub(position, e.position);
    float distance = force.mag();
    distance = constrain(distance,5,25);
    force.normalize();
    float strength = (G * mass * e.mass) / (distance * distance);
    force.mult(strength);
   
    return force;
  }
  
  boolean collided(Entity e)
  {
    if(PVector.sub(position, e.position).mag() < (d/2 + d/2))
      return true;
    
    return false;
  }
  
  boolean Vinside(PVector v)
  {
    if(PVector.sub(position, v).mag() < (d/2 + d/2))
      return true;
    
    return false;
  }
}