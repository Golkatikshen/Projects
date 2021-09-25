class Palla
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float mass;
  float c;
  
  Palla(float x_, float y_, float r_)
  {
    position = new PVector(x_, y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    r = r_;
    mass = 10;
    c = 0.1;
  }
  
  void update()
  {
    //friction
    PVector friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    applyForce(friction);
      
    //velocity
    velocity.add(acceleration);
    velocity.limit(10);
    position.add(velocity);
    acceleration.mult(0);
    
    //bounds
    if(position.x < width/2-325+r)
      velocity.x *= -1;
      
    if(position.x > width/2+325-r)
      velocity.x *= -1;
      
    if(position.y < height/2+80-162.5+r)
      velocity.y *= -1;
      
    if(position.y > height/2+80+162.5-r)
      velocity.y *= -1;
  }
  
  void display()
  {
    stroke(255, 255, 0);
    fill(255, 0, 0);
    ellipse(position.x, position.y, r*2, r*2);
  }
  
  void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void collisions(Palla p)
  {
    float d2 = (position.x - p.position.x) * (position.x - p.position.x) + (position.y - p.position.y) * (position.y - p.position.y);
    float r2 = (r + p.r) * (r + p.r);
    
    if(d2 < r2)
    {
      PVector counter_vel = velocity.copy();
      counter_vel.mult(-1);
      
      PVector col_force = PVector.sub(position, p.position);
      col_force.normalize();
      col_force.mult(counter_vel.mag());
      
      applyForce(counter_vel);
      applyForce(col_force);
      
      
      PVector col_force_p = PVector.sub(p.position, position);
      col_force_p.normalize();
      col_force_p.mult(counter_vel.mag());
      
      p.applyForce(col_force_p);
    }
  }
}