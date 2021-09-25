
Entity e;
float wind_x;
float wind_y;
float wind_f;
boolean wind_on;

void setup()
{
  size(600, 500);
  e = new Entity(width/2, height/2);
  textFont(createFont("Consolas", 36));
  
  wind_x = 10;
  wind_y = 2000;
  wind_y = 5000;
  wind_on = false;
}

void draw()
{
  //HUD
  background(0);
  
  fill(0, 255, 0);
  textSize(15);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 20);
  text("vX: " + (int)(e.velocity.x*10), 5, 40);
  text("vY: " + (int)(e.velocity.y*10), 5, 55);
    
  fill(0, 255, 255);
  if(wind_on)
    text("W: ON", 5, 75);
  else
    text("W: OFF", 5, 75);
    
  textAlign(RIGHT);
  fill(255, 0, 0);
  text("Acceleration Force", width-5, 20);
  fill(0, 0, 255);
  text("Break Force", width-5, 40);
  fill(0, 255, 255);
  text("Wind Force", width-5, 60);
  
  
  //FORCES
  if(mousePressed)
  {
    if(mouseButton == LEFT)
    {
      PVector mouseV = new PVector(mouseX, mouseY);
      PVector accelerationForce = PVector.sub(mouseV, e.position);
      
      accelerationForce.normalize();
      accelerationForce.mult(3);
      
      e.applyForce(accelerationForce);
    }
    
    if(mouseButton == RIGHT)
    {
      if((int)(e.velocity.x*10) != 0 || (int)(e.velocity.y*10) != 0)
      {
        int breakPower = 10;
        PVector breakForce = e.velocity.get();
        breakForce.mult(-1);
        breakForce.normalize();
        breakForce.mult(0.1);
        
        for(int i=0; i<breakPower; i++)
          e.applyForce(breakForce);
      }
    }
  }
  
  if(wind_on)
  {
    float wx = map(noise(wind_x), 0, 1, -1, 1);
    float wy = map(noise(wind_y), 0, 1, -1, 1);
    float wf = map(noise(wind_f), 0, 1, 0.1, 0.5);
    
    PVector windForce = new PVector(wx, wy);
    windForce.normalize();
    windForce.mult(wf);
    
    e.applyForce(windForce);
  }
  
  
  //ENTITY
  e.update();
  e.display();
  
  
  //ARROWS
  if(mousePressed)
  {
    if(mouseButton == LEFT)
    {
      PVector mouseV = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mouseV, e.position);
      dir.normalize();
      dir.mult(70);
      dir.add(e.position);
      
      stroke(255, 0, 0);
      arrow((int)e.position.x, (int)e.position.y, (int)dir.x, (int)dir.y);
    }
    
    if(mouseButton == RIGHT && ((int)(e.velocity.x*10) != 0 || (int)(e.velocity.y*10) != 0))
    {
      PVector dirvel = PVector.add(e.position, e.velocity);
      PVector oppdir = PVector.sub(dirvel, e.position);
      oppdir.normalize();
      oppdir.mult(-1);
      oppdir.mult(30);
      oppdir.add(e.position);
      
      stroke(0, 0, 255);
      arrow((int)e.position.x, (int)e.position.y, (int)oppdir.x, (int)oppdir.y);
    }
  }
  
  if(wind_on)
  {
    float wx = map(noise(wind_x), 0, 1, -1, 1);
    float wy = map(noise(wind_y), 0, 1, -1, 1);
    float wf = map(noise(wind_f), 0, 1, 10, 100);
    
    PVector dirwind = new PVector(wx, wy);
    dirwind.normalize();
    dirwind.mult(wf);
    dirwind.add(e.position);
    
    stroke(0, 255, 255);
    arrow((int)e.position.x, (int)e.position.y, (int)dirwind.x, (int)dirwind.y);
    
    wind_x += 0.01;
    wind_y += 0.01;
    wind_f += 0.01;
  }
}


void arrow(int x1, int y1, int x2, int y2) 
{
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}


void keyPressed()
{
  if(key=='w' || key=='W')
    wind_on = !wind_on;
}