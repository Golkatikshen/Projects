import java.awt.Polygon;
BGManager2 bgm;

void setup()
{
  size(1200, 900);
  bgm = new BGManager2();
}

void draw()
{
  background(0);
  
  bgm.display();
  
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
}


void keyPressed()
{
  bgm = new BGManager2();
}