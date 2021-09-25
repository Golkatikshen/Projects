int n=0;

void setup()
{
  size(600, 400);
  textFont(createFont("Consolas", 36));
}

void draw()
{
  background(0);
  
  textSize(15);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 10, 20);
  
  textSize(35);
  textAlign(CENTER);
  text(n, width/2, height/2);  
  
  count();
}

void count()
{
  int j=0;
  for(int i=0; i<1000000; i++)
  {
      j = j + 1;
  }
  
  n++;
}