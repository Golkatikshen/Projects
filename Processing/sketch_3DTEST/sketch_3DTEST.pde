float x,y,z;
float a;

void setup()
{
  size(800, 600, P3D);
  x = width/2;
  y = height/2;
  z = 0;
  a = 0;
}

void draw() 
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  
  translate(x, y, z);
  rotateZ(radians(a));
  rectMode(CENTER);
  
  fill(0, 0, 255);
  stroke(125, 0, 250);
  strokeWeight(5);
  rect(50,50,100,100);
  
  a++;
}