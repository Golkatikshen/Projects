public class Predatore extends Entity
{ 
  ArrayList<ArrayList<Predatore_Part>> parts;
  int nt = 3;
  
  Predatore(float x, float y)
  {
    super(x, y, 40);
    mass = 15;
    
    parts = new ArrayList();
    
    for(int i=0; i<nt; i++)
      parts.add(new ArrayList());
  }
  
  void display()
  {
    for(int j=0; j<nt; j++)
    {
      if(parts.get(j).size() == 0)
        parts.get(j).add(new Predatore_Part(position.x-d/2+random(d), position.y-d/2+random(d), position.x-d/2+random(d), position.y-d/2+random(d)));
      else if(parts.get(j).get(parts.get(j).size()-1).s <= 210)
        parts.get(j).add(new Predatore_Part(parts.get(j).get(parts.get(j).size()-1).x2, parts.get(j).get(parts.get(j).size()-1).y2, position.x-d/2+random(d), position.y-d/2+random(d)));
      
      for(int i=0; i<parts.get(j).size(); i++)
      {
        parts.get(j).get(i).update();
        parts.get(j).get(i).display();
        
        if(parts.get(j).get(i).s <= 0)
          parts.get(j).remove(i);
      }
    }
    
    stroke(255, 255, 0);
    fill(255, 0, 0);
    ellipse(position.x, position.y, d, d);
  }
}