
Terrain terrain;


void setup()
{
  size(1200, 800);
  
  rectMode(CENTER);
  terrain = new Terrain();
}

void draw()
{
  background(0);
  terrain.display();
}