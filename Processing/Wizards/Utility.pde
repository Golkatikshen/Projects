float Width = 1300;
float Height = 900;
int millis;

PImage basic_particle;

float rele(float v, String mod)
{
  float perc;
  float new_val;

  if (mod.equals("h"))
  {
    perc = v * 100 / Width;
    new_val = perc * width / 100;
  } 
  else
  {
    perc = v * 100 / Height;
    new_val = perc * height / 100;
  }

  return new_val;
}

public static float getAngleOfLineBetweenTwoPoints(float p1x, float p1y, float p2x, float p2y)
{ 
  float xDiff = p2x - p1x; 
  float yDiff = p2y - p1y; 
  return atan2(yDiff, xDiff); 
}