float speedx = 1;

void setup()
{
  size(600, 500);
  textFont(createFont("Consolas", 36));
  noiseDetail(1);
}


void draw()
{
  loadPixels();
  float xoff = speedx;
  float yoff = 0;
  float inc = 0.01;
  
  for (int x = 0; x < width; x++)
  {
    yoff = 0;
    for (int y = 0; y < height; y++)
    {
      float bright = map(noise(xoff, yoff), 0, 1, 0, 255);
      pixels[x+y*width] = color(bright);
      
      yoff += inc;
    }
    
    xoff += inc;
  }
  updatePixels();
  
  fill(255, 0, 0);
  textSize(15);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 20);
  
  speedx += 0.03;
}