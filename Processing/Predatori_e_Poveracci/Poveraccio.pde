public class Poveraccio extends Entity
{
  ArrayList<Poveraccio_Part> parts;
  
  Poveraccio(float x, float y)
  {
    super(x, y, 30);
    mass = 15;

    parts = new ArrayList();
  }
  
  void display()
  {
    if(parts.size() == 0)
      parts.add(new Poveraccio_Part(position.x, position.y, d));
    else if(parts.get(parts.size()-1).w <= d-5)
      parts.add(new Poveraccio_Part(position.x, position.y, d));
    
    for(int i=0; i<parts.size(); i++)
    {
      parts.get(i).update();
      parts.get(i).display();
      
      if(parts.get(i).w <= 0)
        parts.remove(i);
    }
    
    stroke(255);
    fill(255, 192, 203);
    ellipse(position.x, position.y, d, d);
  }
}