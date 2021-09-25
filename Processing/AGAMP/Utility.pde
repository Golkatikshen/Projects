
int Width = 1200;
int Height = 900;

boolean fullscreen;

PFont texts;
PFont digits;
PFont alt1;
PFont del;

int [][] circle_anchors_array = new int[][] {{40, 0}, {-40, 0}, {0, 40}, {0, -40}, 
                                             {28, 28}, {-28, 28}, {28, -28}, {-28, -28},
                                             {37, 15}, {37, -15}, {15, 37}, {15, -37}, {-37, -15}, {-37, 15}, {-15, -37}, {-15, 37}};
                                             
int [][] quad_anchors_array = new int[][] {{40, 0}, {0, 40}, {-40, 0}, {0, -40},
                                           {40, 15}, {40, 30}, {40, -15}, {40, -30},
                                           {15, 40}, {30, 40}, {-15, 40}, {-30, 40},
                                           {-40, 15}, {-40, 30}, {-40, -15}, {-40, -30},
                                           {15, -40}, {30, -40}, {-15, -40}, {-30, -40}};
                                           
int [][] comp_anchors_array = new int[][] {{40, 0}, {-40, 0}, {0, -40},
                                           {40, 15}, {40, -15}, {40, -30},
                                           {-40, 15}, {-40, -15}, {-40, -30},
                                           {15, -40}, {30, -40}, {-15, -40}, {-30, -40},
                                           {18, 40}, {-18, 40}};
                                           
int [][] romb_anchors_array = new int[][] {{50, 0}, {-50, 0}, {0, 50}, {0, -50},
                                           {26, 26}, {26, -26}, {-26, 26}, {-26, -26}};
                                           
                                           /*
                                           {39, 13}, {39, -13}, {-39, 13}, {-39, -13},
                                           {13, 39}, {13, -39}, {-13, 39}, {-13, -39}
                                           */


void drawArrow(float x0, float y0, float x1, float y1, float beginHeadSize, float endHeadSize, boolean filled) 
{
  PVector d = new PVector(x1 - x0, y1 - y0);
  d.normalize();
  
  float coeff = 1.5;
  
  strokeCap(SQUARE);
  
  line(x0+d.x*beginHeadSize*coeff/(filled?1.0f:1.75f), 
        y0+d.y*beginHeadSize*coeff/(filled?1.0f:1.75f), 
        x1-d.x*endHeadSize*coeff/(filled?1.0f:1.75f), 
        y1-d.y*endHeadSize*coeff/(filled?1.0f:1.75f));
  
  float angle = atan2(d.y, d.x);
  
  if (filled) 
  {
    // begin head
    pushMatrix();
    translate(x0, y0);
    rotate(angle+PI);
    triangle(-beginHeadSize*coeff, -beginHeadSize, 
             -beginHeadSize*coeff, beginHeadSize, 
             0, 0);
    popMatrix();
    // end head
    pushMatrix();
    translate(x1, y1);
    rotate(angle);
    triangle(-endHeadSize*coeff, -endHeadSize, 
             -endHeadSize*coeff, endHeadSize, 
             0, 0);
    popMatrix();
  } 
  else
  {
    // begin head
    pushMatrix();
    translate(x0, y0);
    rotate(angle+PI);
    strokeCap(ROUND);
    line(-beginHeadSize*coeff, -beginHeadSize, 0, 0);
    line(-beginHeadSize*coeff, beginHeadSize, 0, 0);
    popMatrix();
    // end head
    pushMatrix();
    translate(x1, y1);
    rotate(angle);
    strokeCap(ROUND);
    line(-endHeadSize*coeff, -endHeadSize, 0, 0);
    line(-endHeadSize*coeff, endHeadSize, 0, 0);
    popMatrix();
  }
  
  strokeWeight(1);
  noStroke();
}



void label(String str, int x, int y, int w, int h, int rs, int gs, int bs, int rl, int gl, int bl)
{
  textFont(digits);
  rectMode(CENTER);
  fill(rl, gl, bl);
  rect(x, y, w, h, 8);
  
  fill(rs, gs, bs);
  textAlign(CENTER, CENTER);
  for(int i=0; i<w/2; i++)
  {
    textSize(w/2-i);
    if(textWidth(str) < w && textAscent()+textDescent() < h)
      break;
  }
  text(str, x, y-1);
}

void label(String str, int x, int y, int w, int h, int rs, int gs, int bs, int rl, int gl, int bl, int rc)
{
  textFont(digits);
  rectMode(CENTER);
  fill(rl, gl, bl);
  rect(x, y, w, h, rc);
  
  fill(rs, gs, bs);
  textAlign(CENTER, CENTER);
  for(int i=0; i<w/2; i++)
  {
    textSize(w/2-i);
    if(textWidth(str) < w && textAscent()+textDescent() < h)
      break;
  }
  text(str, x, y-1);
}


String adjustFormat(float f)
{
  String str = "";
  if(f % 1 == 0)
    str = String.valueOf((long)f);
  else
    str = String.valueOf(f);
    
  return str;
}



float d(PVector A, PVector B)
{
  return ((B.x-A.x)*(B.x-A.x)+(B.y-A.y)*(B.y-A.y));
}
  
float pointToLine(PVector A , PVector B, PVector P)
{
     //A = P0
     //B = P1
     PVector v = PVector.sub(B, A);
     PVector w = PVector.sub(P, A);

     double c1 = PVector.dot(w,v);
     if ( c1 <= 0 )
          return d(P, A);

     double c2 = PVector.dot(v,v);
     if ( c2 <= c1 )
          return d(P, B);

     double b = c1 / c2;
     
     PVector Pb = v.mult((float)b);
     Pb = PVector.add(A, Pb);
     
     return d(P, Pb);
}

long factorial(int n)
{
  long fact = 1;
  for(int i=n; i>0; i--)
    fact *= i;
    
  return fact;
}

boolean isPrime(int n)
{
  int sqr = (int)sqrt(n);
  
  for(int i=2; i<=sqr; i++)
    if(n % i == 0)
      return false;
      
  return true;
}

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