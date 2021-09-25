
ArrayList<Circle> circles;
int new_x;
int new_y;
int new_w;
int n_new;
int n_temp;
int n_htf;

void setup()
{
  size(1000, 900);
  textFont(createFont("Consolas", 15));
  //colorMode(HSB);
  textAlign(CENTER);
  
  circles = new ArrayList();
  
  new_x = 0;
  new_y = 0;
  new_w = 35;
  n_new = 3;
  n_temp = 3;
}

void draw()
{
  background(0);
  
  if(new_w >= 1)
    createNew();
  
  for(Circle c: circles)
  {
    if(new_w >= 1)
      c.display(false);
    else
      c.display(true);
  }
  
  if(new_w < 1)
    noLoop();
}

int Nhtf = 3000;
void createNew()
{  
  do{
    new_x = (int)random(new_w, width-new_w);
    new_y = (int)random(new_w, height-new_w);
    n_htf ++;
  }while(intersecting() && n_htf < Nhtf);
  
  if(n_htf < Nhtf)
    circles.add(new Circle(new_x, new_y, new_w));
  
  
  if(n_temp == 1 || n_htf >= Nhtf)
  {
    new_w -= 2;
    n_new += n_new;
    n_temp = n_new;
    n_htf = 0;
  }
  else
    n_temp --;
}

boolean intersecting()
{
  if(circles.isEmpty())
    return false;
    
  for(Circle c: circles)
    if(((new_x - c.x) * (new_x - c.x) + (new_y - c.y) * (new_y - c.y)) < ((new_w + c.w) * (new_w + c.w)))
      return true;
      
  return false;
}