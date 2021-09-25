class Tavolo
{
  ArrayList<Palla> palle;
  
  Tavolo()
  {
    palle = new ArrayList();
    palle.add(new Palla(200, height/2+80, 15));
    
    palle.add(new Palla(500, height/2+80, 15));
    
    palle.add(new Palla(525, height/2+55, 15));
    palle.add(new Palla(525, height/2+105, 15));
    
    palle.add(new Palla(550, height/2+30, 15));
    palle.add(new Palla(550, height/2+80, 15));
    palle.add(new Palla(550, height/2+130, 15));
  }
  
  
  void run()
  {
    update();
    display();
  }
  
  void update()
  {
    for(Palla p1: palle)
    {
      for(Palla p2: palle)
      {
        if(p1 != p2)
          p1.collisions(p2);
      }
      p1.update();
    }
  }
  
  void display()
  {
    rectMode(CENTER);
    noStroke();
    fill(163, 89, 64);
    rect(width/2, height/2+80, 700, 375);
    fill(130, 196, 108);
    rect(width/2, height/2+80, 650, 325);
    
    for(Palla p: palle)
      p.display();
  }
}