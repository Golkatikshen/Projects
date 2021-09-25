
PVector point;
color c;
String color_name;
boolean center_mirror;
int pnum;
int sw;

void setup()
{
  size(1200, 1000);
  
  strokeCap(ROUND);
  strokeWeight(3);
  background(0);
  
  c = color(255);
  color_name = "Bianco";
  center_mirror = true;
  pnum = 2;
  sw = 3;
  
  refreshTitle();
}

void draw(){}

void mousePressed()
{
  if(mouseButton == LEFT)
  {
    point = new PVector(mouseX, mouseY);
  }
}

void mouseDragged()
{
  if(mouseButton == LEFT)
  {
    stroke(c);
    PVector A = new PVector(point.x - width/2, point.y - height/2);
    PVector B = new PVector(mouseX - width/2, mouseY - height/2);
    float deg = 360 / pnum;
    double angA = atan2(A.y, A.x);
    double angB = atan2(B.y, B.x);
    float rA = sqrt(A.x * A.x + A.y * A.y);
    float rB = sqrt(B.x * B.x + B.y * B.y);
    
    for(int i=1; i<=pnum; i++)
    {
      float p1x = rA*cos((float)angA + DEG_TO_RAD * (deg*i)) + width/2;
      float p2x = rB*cos((float)angB + DEG_TO_RAD * (deg*i)) + width/2;
      float p1y = rA*sin((float)angA + DEG_TO_RAD * (deg*i)) + height/2;
      float p2y = rB*sin((float)angB + DEG_TO_RAD * (deg*i)) + height/2;
      
      line(p1x, p1y, p2x, p2y);
      
      if(center_mirror)
      {
        float dist1, dist2;
        if(p1x < width/2)
        {
          dist1 = width/2 - p1x;
          dist2 = width/2 - p2x;
          line(p1x + dist1*2, p1y, p2x + dist2*2, p2y);
        }
        else
        {
          dist1 = p1x - width/2;
          dist2 = p2x - width/2;
          line(p1x - dist1*2, p1y, p2x - dist2*2, p2y);
        }
      }
    }
    
    point = new PVector(mouseX, mouseY);
  }
}

void lines()
{
  PVector A = new PVector(0, -2000);
  PVector B = new PVector(0, 0);
  float deg = 360 / pnum;
  double angA = atan2(A.y, A.x);
  double angB = atan2(B.y, B.x);
  float rA = sqrt(A.x * A.x + A.y * A.y);
  float rB = sqrt(B.x * B.x + B.y * B.y);
  
  for(int i=1; i<=pnum; i++)
  {
    float p1x = rA*cos((float)angA + DEG_TO_RAD * (deg*i)) + width/2;
    float p2x = rB*cos((float)angB + DEG_TO_RAD * (deg*i)) + width/2;
    float p1y = rA*sin((float)angA + DEG_TO_RAD * (deg*i)) + height/2;
    float p2y = rB*sin((float)angB + DEG_TO_RAD * (deg*i)) + height/2;
    
    line(p1x, p1y, p2x, p2y);
  }
}

//<>
void keyPressed()
{
  if(key == 'c')
    background(0);
    
  if(key == 'o')
    center_mirror = !center_mirror;
  
  if(key == 'l')
    lines();
    
  if(key >= '0' && key <= '9')
  {
    if(key == '0')
      pnum = 10;
    else
      pnum = key - 48;
  }
  
  if(key == 'q')
  {
    c = color(255);
    color_name = "Bianco";
  }
  
  if(key == 'w')
  {
    c = color(255, 0, 0);
    color_name = "Rosso";
  }
  
  if(key == 'e')
  {
    c = color(0, 0, 255);
    color_name = "Blu";
  }
  
  if(key == 'r')
  {
    c = color(255, 255, 0);
    color_name = "Giallo";
  }
  
  if(key == 't')
  {
    c = color(0, 255, 0);
    color_name = "Verde";
  }
  
  if(key == 'y')
  {
    c = color(120, 0, 180);
    color_name = "Viola";
  }
  
  if(key == 'u')
  {
    c = color(235, 145, 0);
    color_name = "Arancione";
  }
  
  if(key == 'i')
  {
    c = color(128);
    color_name = "Grigio";
  }
  
  refreshTitle();
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  sw += e;
  
  if(sw < 1)
    sw = 1;
  if(sw > 5)
    sw = 5;
    
  strokeWeight(sw);
  
  refreshTitle();
}

void refreshTitle()
{
  surface.setTitle("Mirroring | Center Mirror: " + center_mirror + " | Numero Cursori: " + pnum + " | Colore: " + color_name + " | Spessore Linea: " + sw);
}