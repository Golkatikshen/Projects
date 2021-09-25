public class Cibo extends Entity
{
  ArrayList<Cibo_Part> parts;
  
  Cibo(float x, float y)
  {
    super(x, y, 15);
    mass = 20;
    
    parts = new ArrayList();
  }
  
  void display()
  {
    if(parts.size() == 0)
      parts.add(new Cibo_Part(position.x, position.y, d));
    else if(parts.get(parts.size()-1).w >= d+10)
      parts.add(new Cibo_Part(position.x, position.y, d));
    
    for(int i=0; i<parts.size(); i++)
    {
      parts.get(i).update();
      parts.get(i).display();
      
      if(parts.get(i).w >= d+20)
        parts.remove(i);
    }
    
    stroke(0, 125, 255);
    fill(150, 231, 180);
    ellipse(position.x, position.y, d, d);
  }
}