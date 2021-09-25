Vehicle v;

void setup()
{
  size(700, 600);
  textFont(createFont("Consolas", 15));
  v = new Vehicle(width/2, height/2);
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  v.seek(new PVector(mouseX, mouseY));
  
  v.update();
  v.display();
}