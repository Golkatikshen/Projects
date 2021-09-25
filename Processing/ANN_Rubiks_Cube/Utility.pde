
float Width = 1100;
float Height = 830;

color[] uc = new color[] {color(255, 165, 0), color(255, 255, 255), color(0, 0, 255), color(255, 255, 0), color(0, 255, 0), color(255, 0, 0), color(10, 10, 10)};

float rele(float v, String mod)
{
  float perc;
  float new_val;
  
  if(mod.equals("h"))
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


float sigmoid(float n, boolean der)
{
  if(der == true)
    return (sigmoid(n, false) * (1 - sigmoid(n, false)));
    
  return (1/(1+exp(-n)));
}

void print_array(float[] a)
{
  print("[");
  for(int i=0; i<a.length; i++)
    print((int)a[i]+", ");
  println("]");
}