class Wiz
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float c;
  float rotation;
  float r;
  
  String name;
  
  color cb;
  color[] ce;
  
  Bacchetta bacchetta;
  
  
  Wiz(float x, float y, float _r, color _cb, color[] _ce)
  {
    position = new PVector(x, y);
    r = _r;
    
    cb = _cb;
    ce = _ce;
    
    velocity = new PVector();
    acceleration = new PVector();
    mass = 1;
    c = 0.4;
    
    bacchetta = new Bacchetta("");
  }
  
  
  void display()
  {
    noStroke();
    fill(cb);
    pushMatrix();
    //translate(position.x, position.y, -100);
    translate(position.x, position.y);
    //sphere(r);
    ellipse(0, 0, r*2, r*2);
    rotate(rotation);
    bacchetta.display(-r-3);
    fill(cb);
    rectMode(CENTER);
    rect(r/10, r, 10, 15, 6);
    rect(r/10, -r, 10, 15, 6);
    rectMode(CORNER);
    fill(ce[(int)random(0, 3)]);
    translate(-r/3, 0);
    ellipse(0, r/5, r/4, r/4);
    ellipse(0, -r/5, r/4, r/4);
    popMatrix();
  }
  
  
  void update()
  {
    //ROTATION
    rotation = getAngleOfLineBetweenTwoPoints(mouseX, mouseY, position.x, position.y);
    
    //FORCES
      //check velocity
    if(velocity.mag() < 0.5)
      velocity.mult(0);
    
      //friction
    PVector friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    
    applyForce(friction);
    
      //apply forces and limits
    velocity.add(acceleration);
    velocity.limit(10);
    position.add(velocity);
    
    acceleration.mult(0);
    
    
    //BOUND
    if(position.x - r < 0)
    {
      position.x = r;
      velocity.x = 0;
    }
    
    if(position.y - r < 0)
    {
      position.y = r;
      velocity.y = 0;
    }
    
    if(position.x + r > width)
    {
      position.x = width - r;
      velocity.x = 0;
    }
    
    if(position.y + r > height)
    {
      position.y = height  - r;
      velocity.y = 0;
    }
  }
  
  void applyForce(PVector force)
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void wmousePressed()
  {
    bacchetta.castSpell();
  }
}