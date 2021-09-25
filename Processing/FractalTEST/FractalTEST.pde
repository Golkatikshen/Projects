
void setup()
{
  size(900, 500);
}

void draw()
{
  background(0);
  noFill();
  stroke(255, 0, 0);
  drawCircles(width/2, height/2+200, 200); 
}

void drawCircles(float x, float y, float r)
{
  ellipse(x, y, r*2, r*2);
  if(r > 5)
  {
    float nr = r * 0.5;
    drawCircles(x+r, y, nr);
    drawCircles(x-r, y, nr);
    //drawCircles(x, y+r, nr);
    drawCircles(x, y-r, nr);
  }
}