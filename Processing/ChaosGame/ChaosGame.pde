
ArrayList<PVector> points;
PVector trace_point;
boolean points_drawn = false;
int update_rate = 1000;
int r;

//Rules
int n_points;


void setup()
{
  size(1200, 900);
  points = new ArrayList();
  trace_point = new PVector(random(0, width), random(0, height));
  
  
  /*points.add(new PVector(600, 50));
  points.add(new PVector(100, 650));
  points.add(new PVector(1100, 850));*/
  
  points.add(new PVector(100, 50));
  points.add(new PVector(1100, 50));
  points.add(new PVector(100, 850));
  points.add(new PVector(1100, 850));
  
  //points.add(new PVector(width/2, height/2));
  
  n_points = points.size();
  
  background(0);
}

void draw()
{
  if(!points_drawn)
  {
    for(PVector p: points)
    {
      fill(255, 0, 0);
      ellipse(p.x, p.y, 5, 5);
    }
    points_drawn = true;
  }
  
  loadPixels();
  for(int i=0; i<update_rate; i++)
  {
    r = (int)random(0, n_points);
    trace_point.set((trace_point.x+points.get(r).x)/2.01f, (trace_point.y+points.get(r).y)/2.01f);
    pixels[(int)trace_point.y*width+(int)trace_point.x] = #00FF00;
  }
  updatePixels();
}