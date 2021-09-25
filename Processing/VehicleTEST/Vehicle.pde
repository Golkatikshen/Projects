class Vehicle
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxForce;
  float maxSpeed;

  Vehicle(float x, float y)
  {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);
    
    r = 3.0;
    maxSpeed = 4;
    maxForce = 0.2;
  }
  
  void update()
  {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector f)
  {
    acceleration.add(f);
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector .sub(target, position);
    float d = desired.mag();
    desired.normalize();
    if (d < 100)
    {
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.mult(m);
    } 
    else 
      desired.mult(maxSpeed);
      
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void display()
  {
    float theta = velocity.heading() + PI/2;
    fill(255, 0, 0);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}