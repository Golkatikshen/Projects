Entity entity;
Spring spring;


void setup()
{
  size(700, 600);
  entity = new Entity(350, 200, 50);
  spring = new Spring(new PVector(350, 0), 200, entity);
}

void draw()
{
  background(0);
  
  PVector gravity = new PVector(0, 1);
  entity.applyForce(gravity);
  
  
  if(mousePressed)
  {
    PVector dirf = PVector.sub(new PVector(mouseX, mouseY), new PVector(entity.position.x, entity.position.y));
    dirf.normalize();
    dirf.mult(5);
    
    entity.applyForce(dirf);
  }
  
  spring.display();
  entity.update();
  entity.display();
  
  spring.connect(entity);
}


void keyPressed()
{
  
}