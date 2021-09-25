class Particle
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector pos_)
  {
    acceleration = new PVector(0, 0.1);
    velocity = new PVector(random(-2, 2), random(-3, 0.5));
    position = pos_.get();
    lifespan = 255;
  }
  
  void exe()
  {
    update();
    display();
  }
  
  void update()
  {
    velocity.add(acceleration);
    position.add(velocity);
    
    lifespan -= 2;
  }
  
  void display()
  {
    stroke(128, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }
  
  boolean isDead()
  {
    if(lifespan <= 0)
      return true;
    else
      return false;
  }
}