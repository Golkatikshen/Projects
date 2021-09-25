//><

float phi = (1+sqrt(5))/2;

color getRandomColor()
{
  int c = (int)random(0, 3);
  
  if(c == 0)
    return color(255, 0, 0);
  else if(c == 1)
    return color(0, 255, 0);
  else
    return color(0, 0, 255);
}