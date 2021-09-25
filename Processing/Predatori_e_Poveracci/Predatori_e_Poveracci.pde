
ArrayList<Predatore> predatori;
ArrayList<Poveraccio> poveracci;
ArrayList<Cibo> cibi;

int predatori_iniziali = 4;
int poveracci_iniziali = 12;
int cibi_iniziali = 15;

boolean pause;
boolean cmap = true;


void setup()
{
  size(800, 500);
  predatori = new ArrayList();
  poveracci = new ArrayList();
  cibi = new ArrayList();
  
  for(int i=0; i<predatori_iniziali; i++)
    predatori.add(new Predatore(random(50, 750), random(50, 450)));
    
  for(int i=0; i<poveracci_iniziali; i++)
    poveracci.add(new Poveraccio(random(50, 750), random(50, 450)));
    
  for(int i=0; i<cibi_iniziali; i++)
    cibi.add(new Cibo(random(50, 750), random(50, 450)));
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  text("Predatori iniziali: " + predatori_iniziali, 5, 40);
  text("Poveracci iniziali: " + poveracci_iniziali, 5, 55);
  text("Cibo iniziale: " + cibi_iniziali, 5, 70);
  
  if(cmap)
  {
    textFont(createFont("Consolas", 14));
    textAlign(LEFT, BOTTOM);
    text("M: Mostra/Nascondi Comandi", 10, 305);
    text("P/L: Inc/Dec predatori iniziali", 10, 330);
    text("O/K: Inc/Dec poveracci iniziali", 10, 350);
    text("I/J: Inc/Dec cibo iniziale", 10, 370);
    text("F: Pausa", 10, 390);
    text("R: Cancella Entità", 10, 410);
    text("E: Spawn Cibo", 10, 430);
    text("W: Spawn Poveraccio", 10, 450);
    text("Q: Spawn Predatore",10, 470);
    text("X: Restart", 10, 490);
  }
  
  
  if(!pause)
  {
    //FORCES
      //poveracci
    for(int i=0; i<poveracci.size(); i++)
    {
      float dist_cibo = 1000000;
      int index_cibo = -1;
      
      for(int j=0; j<cibi.size(); j++)
      {
        PVector v = PVector.sub(cibi.get(j).position, poveracci.get(i).position);
        if(v.mag() < dist_cibo)
        {
          dist_cibo = v.mag();
          index_cibo = j;
        }
      }
      
      
      float dist_predatore = 1000000;
      int index_predatore = -1;
      
      for(int j=0; j<predatori.size(); j++)
      {
        PVector v = PVector.sub(predatori.get(j).position, poveracci.get(i).position);
        if(v.mag() < dist_predatore)
        {
          dist_predatore = v.mag();
          index_predatore = j;
        }
      }
      
      
      float dist_poveraccio = 1000000;
      int index_poveraccio = -1;
      
      for(int j=0; j<poveracci.size(); j++)
      {
        if(i != j)
        {
          PVector v = PVector.sub(poveracci.get(j).position, poveracci.get(i).position);
          if(v.mag() < dist_poveraccio)
          {
            dist_poveraccio = v.mag();
            index_poveraccio = j;
          }
        }
      }
      
      
      
      if(index_cibo != -1)
      {
        PVector f = PVector.sub(cibi.get(index_cibo).position, poveracci.get(i).position);
        f.normalize();
        f.mult(0.8);
        poveracci.get(i).applyForce(f);
      }
      
      if(index_predatore != -1)
      {
        PVector f = PVector.sub(predatori.get(index_predatore).position, poveracci.get(i).position);
        f.normalize();
        f.mult(-1);
        f.mult(0.4);
        poveracci.get(i).applyForce(f);
      }
      
      if(index_poveraccio != -1)
      {
        PVector f = PVector.sub(poveracci.get(index_poveraccio).position, poveracci.get(i).position);
        f.normalize();
        f.mult(-1);
        f.mult(0.25);
        poveracci.get(i).applyForce(f);
      }
    }
  
  
    for(int i=0; i<predatori.size(); i++)
    {
      float dist_poveraccio = 1000000;
      int index_poveraccio = -1;
      
      for(int j=0; j<poveracci.size(); j++)
      {
        PVector v = PVector.sub(poveracci.get(j).position, predatori.get(i).position);
        if(v.mag() < dist_poveraccio)
        {
          dist_poveraccio = v.mag();
          index_poveraccio = j;
        }
      }
      
      
      float dist_predatore = 1000000;
      int index_predatore = -1;
      
      for(int j=0; j<predatori.size(); j++)
      {
        if(j != i)
        {
          PVector v = PVector.sub(predatori.get(j).position, predatori.get(i).position);
          if(v.mag() < dist_predatore)
          {
            dist_predatore = v.mag();
            index_predatore = j;
          }
        }
      }
      
      
      if(index_predatore != -1)
      {
        PVector f = PVector.sub(predatori.get(index_predatore).position, predatori.get(i).position);
        f.normalize();
        f.mult(-1);
        f.mult(0.25);
        predatori.get(i).applyForce(f);
      }
      
      if(index_poveraccio != -1)
      {
        PVector f = PVector.sub(poveracci.get(index_poveraccio).position, predatori.get(i).position);
        f.normalize();
        f.mult(0.5);
        predatori.get(i).applyForce(f);
      }
    }
    
    
    
    //COLLISIONS
    for(int i=0; i<predatori.size(); i++)
    {
      for(int j=0; j<poveracci.size(); j++) 
      {
        if(predatori.get(i).collided(poveracci.get(j)))
          poveracci.remove(j);
      }
    }
    
    for(int i=0; i<poveracci.size(); i++)
    {
      for(int j=0; j<cibi.size(); j++) 
      {
        if(poveracci.get(i).collided(cibi.get(j)))
          cibi.remove(j);
      }
    }
  }
  
  
  //DISPLAY
  for(int i=0; i<cibi.size(); i++)
  {
    if(!pause)
      cibi.get(i).update();
    cibi.get(i).display();
  }
  
  for(int i=0; i<poveracci.size(); i++)
  {
    if(!pause)
      poveracci.get(i).update();
    poveracci.get(i).display();
  }
  
  for(int i=0; i<predatori.size(); i++)
  {
    if(!pause)
      predatori.get(i).update();
    predatori.get(i).display();
  }
  
  
  //WINS
  if(poveracci.size() == 0)
  {
    textAlign(CENTER, CENTER);
    fill(0, 255, 0);
    textSize(45);
    text("PREDATORS WON!", width/2, height/2);
    pause = true;
  }
  
  if(cibi.size() == 0)
  {
    textAlign(CENTER, CENTER);
    fill(0, 255, 0);
    textSize(45);
    text("POVERACCI WON!", width/2, height/2);
    pause = true;
  }
}


void keyPressed()
{
  if(key == 'f' || key == 'F')
    pause = !pause;
    
  if(key == 'm' || key == 'M')
    cmap = !cmap;
    
  
  
  if(key == 'x' || key == 'X')
  {
    predatori.clear();
    poveracci.clear();
    cibi.clear();
    
    for(int i=0; i<predatori_iniziali; i++)
      predatori.add(new Predatore(random(50, 750), random(50, 450)));
    
    for(int i=0; i<poveracci_iniziali; i++)
      poveracci.add(new Poveraccio(random(50, 750), random(50, 450)));
      
    for(int i=0; i<cibi_iniziali; i++)
      cibi.add(new Cibo(random(50, 750), random(50, 450)));
    
    pause = false;
  }
  
  
  
  if(key == 'p' || key == 'P')
    predatori_iniziali++;
  
  if(key == 'l' || key == 'L')
    if(predatori_iniziali != 0)
      predatori_iniziali--;
      
  
  if(key == 'o' || key == 'O')
    poveracci_iniziali++;
  
  if(key == 'k' || key == 'K')
    if(poveracci_iniziali != 0)
      poveracci_iniziali--;
      
   
  if(key == 'i' || key == 'I')
    cibi_iniziali++;
  
  if(key == 'j' || key == 'J')
    if(cibi_iniziali != 0)
      cibi_iniziali--;
      
      
      
  if(key == 'q' || key == 'Q')
    predatori.add(new Predatore(mouseX, mouseY));
    
  if(key == 'w' || key == 'W')
    poveracci.add(new Poveraccio(mouseX, mouseY));
    
  if(key == 'e' || key == 'E')
    cibi.add(new Cibo(mouseX, mouseY));
    
    
    
  if(key == 'r' || key == 'R')
  {
    for(int i=0; i<predatori.size(); i++)
    {
      if(predatori.get(i).Vinside(new PVector(mouseX, mouseY)))
        predatori.remove(i);
    }
    
    for(int i=0; i<poveracci.size(); i++)
    {
      if(poveracci.get(i).Vinside(new PVector(mouseX, mouseY)))
        poveracci.remove(i);
    }
    
    for(int i=0; i<cibi.size(); i++)
    {
      if(cibi.get(i).Vinside(new PVector(mouseX, mouseY)))
        cibi.remove(i);
    }
  }
}