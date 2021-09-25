
boolean white;
Metaball[] metaballs;

void setup()
{
  size(640, 460);
  white = true;
  metaballs = new Metaball[3];
  for(int i=0; i<metaballs.length; i++)
    metaballs[i] = new Metaball(20, 5);
}

void draw()
{
  background(0);
  
  loadPixels();
  for(int x = 0; x < width; x++)
  {
    for(int y = 0; y < height; y++)
    {
      float r = 400 * metaballs[0].r / dist(x, y, metaballs[0].pos.x, metaballs[0].pos.y);
      float g = 400 * metaballs[1].r / dist(x, y, metaballs[1].pos.x, metaballs[1].pos.y);
      float b = 400 * metaballs[2].r / dist(x, y, metaballs[2].pos.x, metaballs[2].pos.y);
      
      if(white)
        pixels[x + y * width] = color(r + g + b);
      else
        pixels[x + y * width] = color(r, g, b);
    }
  }
  updatePixels();
  
  for(Metaball mb: metaballs)
  {
    mb.update();
    //mb.display();
  }
}

void keyPressed()
{
  if(key == 'x' || key == 'X')
    white = !white;
}