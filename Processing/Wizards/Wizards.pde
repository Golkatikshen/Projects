
Wiz wizard;
boolean W, A, S, D;
boolean spells_board;
DrawBoard sdb;

void setup()  
{
  size(1300, 900);
  frameRate(60);
  
  basic_particle = loadImage("imgs/basic_particle_mod.png");
  
  sdb = new DrawBoard(0, 0, 40, 6);
  
  wizard = new Wiz(width/2, height/2, 25, color(220, 0, 0), new color[] {color(240, 140, 20), color(240, 240, 0), color(250, 0, 0)});
}


void draw()  
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  //lights();
  wizard.update();
  wizard.display();
  
  //movimento
  if(W)
    wizard.applyForce(new PVector(0, -1*(60/frameRate)));
    
  if(A)
    wizard.applyForce(new PVector(-1*(60/frameRate), 0));
    
  if(S)
    wizard.applyForce(new PVector(0, 1*(60/frameRate)));
    
  if(D)
    wizard.applyForce(new PVector(1*(60/frameRate), 0));
    
    
  if(spells_board)
  {
    sdb.display();
    
    if(mousePressed == true) 
    {
      for(int i=0; i<sdb.l; i++)
      {
        for(int j=0; j<sdb.l; j++)
        {
          float dist = pow((mouseX - (sdb.x+(j*sdb.w))), 2) + pow((mouseY - (sdb.y+(i*sdb.w))), 2);
          float off = pow(8, 2);
          if(dist < off)
          { 
            dist = map(dist, 0, off, 255, 0);
            if(sdb.pixel_val[j][i] < dist)
              sdb.pixel_val[j][i] = (int)dist;
          }
        }
      }
    }
  }
}


void mousePressed()
{
  wizard.wmousePressed();
}

void mouseReleased()
{
  if(!spells_board)
  {
    if(mouseButton == LEFT)
    {
      spells_board = true;
      sdb.cleanBoard();
      sdb.x = mouseX - (sdb.l * sdb.w / 2);
      sdb.y = mouseY - (sdb.l * sdb.w / 2);
    }
  }
  else
  {
    if(mouseButton == LEFT)
    {
      spells_board = false;
      sdb.center();
    }
  }
}


void keyPressed()
{
  switch(key)
  {
    case 'W':
    case 'w':
      W = true;
    break;
    
    case 'S':
    case 's':
      S = true;
    break;
    
    case 'A':
    case 'a':
      A = true;
    break;
    
    case 'D':
    case 'd':
      D = true;
    break;
  }
}

void keyReleased()
{
  switch(key)
  {
    case 'W':
    case 'w':
      W = false;
    break;
    
    case 'S':
    case 's':
      S = false;
    break;
    
    case 'A':
    case 'a':
      A = false;
    break;
    
    case 'D':
    case 'd':
      D = false;
    break;
  }
}