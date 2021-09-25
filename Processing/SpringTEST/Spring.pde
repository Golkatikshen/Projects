public class Spring
{
  PVector anchor;
  PVector end;
  float restLength;
  
  float k = 0.05;
  
  
  Spring(PVector anchor_, float restLength_, Entity connected)
  {
    anchor = anchor_.get();
    restLength = restLength_;
    
    end = connected.position.get();
  }

  
  void display()
  {
    stroke(0, 255, 0);
    line(anchor.x, anchor.y, end.x, end.y);
  }
  
  
  void connect(Entity e)
  {
    end = e.position.get();
    
    PVector dirf = PVector.sub(end, anchor);
    float currentLength = dirf.mag();
    float x = currentLength - restLength;
    
    dirf.normalize();
    dirf.mult(-1 * k * x);
    
    e.applyForce(dirf);
  }
}