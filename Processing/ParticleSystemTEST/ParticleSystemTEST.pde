
ArrayList<ParticleSystem> pss;


void setup()
{
  size(700, 600);
  pss = new ArrayList<ParticleSystem>();
  
  textFont(createFont("Consolas", 15));
}

void draw()
{
  background(0);
  
  fill(0, 255, 0);
  text("FPS: " + (int)frameRate, 5, 15);
  text("PSSystems: " + pss.size(), 5, 30);
  
  for(ParticleSystem ps: pss)
    ps.exe();
}


void mouseClicked()
{
  pss.add(new ParticleSystem(new PVector(mouseX, mouseY), 120, 1));
}