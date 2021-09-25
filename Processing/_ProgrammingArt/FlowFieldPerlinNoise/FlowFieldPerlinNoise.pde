
float w_cells;
float noise_scale;
float noise_z;

Particle[] particles = new Particle[10000];
PVector[] flowfield;


void setup()
{
  size(1200, 900);
  textFont(createFont("Consolas", 25));
  w_cells = 10;
  noise_scale = 0.05;
  
  flowfield = new PVector[floor((width / w_cells) * (height / w_cells))];
  for(int i = 0; i < particles.length; i++)
    particles[i] = new Particle(new PVector(random(width), random(height)), 1);
}

void draw()
{
  //background(255);

  for(int x = 0; x < width / w_cells; x++)
  {
    for(int y = 0; y < height / w_cells; y++)
    {
      float angle = map(noise(x * noise_scale, y * noise_scale, noise_z), 0, 1, 0, TWO_PI);
      //pushMatrix();
      //translate(x * w_cells + (w_cells / 2), y * w_cells + (w_cells / 2));
      //rotate(angle);
      //line(0, 0, w_cells / 2, w_cells / 2);
      flowfield[x + y * floor(width / w_cells)] = new PVector(2 * cos(angle), 2 * sin(angle));
      
      //popMatrix();
    }
  }
  noise_z += 0.001;
  
  for(Particle p: particles)
  {
    p.update();
    p.display();
    p.follow(flowfield);
  }
  
  //fill(255, 0, 0);
  //text(floor(frameRate), 5, 20);
}

void mouseWheel(MouseEvent event)
{
  int e = event.getCount();
  
  if(e == 1)
    noise_scale += 0.01;
  else
    noise_scale -= 0.01;
}