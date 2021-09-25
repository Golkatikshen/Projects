
PVector p1, p2, pm;
float line_len;

void setup()
{
  size(800, 600);
  
  p1 = new PVector(200, 100);
  p2 = new PVector(600, 500);
  pm = new PVector(mouseX, mouseY);
  
  line_len = d(p1, p2);
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  
  stroke(255, 0, 0);
  strokeWeight(1);
  line(p1.x, p1.y, mouseX, mouseY);
  line(p2.x, p2.y, mouseX, mouseY);
  
  pm.x = mouseX;
  pm.y = mouseY;
  
  if(d(p1, pm) + d(p2, pm) < line_len+0.5)
    stroke(0, 0, 255);
  else
    stroke(255);
    
  strokeWeight(3);
  line(p1.x, p1.y, p2.x, p2.y);
}


float d(PVector A, PVector B)
{
  return sqrt((B.x-A.x)*(B.x-A.x)+(B.y-A.y)*(B.y-A.y));
}