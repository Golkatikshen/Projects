Tavolo t;

void setup()
{
  size(800, 600);
  t = new Tavolo();
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  t.update();
  t.display();
}

void keyPressed()
{
  if(key == 'x')
    t.palle.get(0).applyForce(new PVector(100, 0));
}