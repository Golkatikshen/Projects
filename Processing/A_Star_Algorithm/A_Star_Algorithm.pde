
int NN = 90;
int WW = 900 / NN;
Node[] nodes;
boolean arrivati;
boolean go;

void setup()
{
  size(900, 900);
  textFont(createFont("Consolas", 15));
  textAlign(LEFT);
  
  nodes = new Node[NN*NN];
  for(int i=0; i<NN; i++)
    for(int j=0; j<NN; j++)
      nodes[j+i*NN] = new Node(j, i, WW);
}

void draw()
{
  for(Node n: nodes)
      n.display();
      
  if(go && !arrivati)
  {
    if(nodes[calcNextOver()].end)
      arrivati = true;
      
    calcNeighNearOver();
    
    if(arrivati)
      calFinalPath();
  }
}

void mouseDragged()
{
  if(mouseButton == LEFT)
  {
    for(Node n: nodes)
        if(n.mouseIsNear(15))
          n.wall = true;
  }
  
  if(mouseButton == RIGHT)
  {
    for(Node n: nodes)
        if(n.mouseIsNear(15))
          n.wall = false;
  }
}

int I(int x, int y)
{
  if(x < 0 || x >= NN || y < 0 || y >= NN)
    return -1;
    
  return (x + y * NN);
}

void keyPressed()
{
  if(key == 'g')
  {
    calcNeighNearOver();
    go = true;
  }
  
  if(key == 'x' && !arrivati)
  {
    if(nodes[calcNextOver()].end)
      arrivati = true;
      
    calcNeighNearOver();
    
    if(arrivati)
      calFinalPath();
  }
  
  if(key == 'a' && !arrivati)
    calcNeighNearOver();
    
  if(key == 'r')
  {
    for(int i=0; i<NN; i++)
      for(int j=0; j<NN; j++)
        nodes[j+i*NN] = new Node(j, i, WW);
    arrivati = false;
    go = false;
  }
  
  if(key == 's')
  {
    for(Node n: nodes)
      if(n.mouseIsHover())
      {
        n.start = true;
        n.closed = true;
        n.over = true;
        n.parent = n;
      }
  }
  
  if(key == 'e')
  {
    for(Node n: nodes)
      if(n.mouseIsHover())
        n.end = true;
        
    calcNeighbour();
  }
}


//A* functions
void start_as()
{
  nodes[I(7, 7)].start = true;
  nodes[I(7, 7)].closed = true;
  nodes[I(7, 7)].over = true;
  nodes[I(7, 7)].parent = nodes[I(7, 7)];
  nodes[I(4, 4)].end = true;
  
  calcNeighbour();
}

void calcNeighbour()
{
  for(Node n: nodes)
  {
    if(I(n.x-1, n.y-1) != -1)
      n.neighbours[0] = nodes[I(n.x-1, n.y-1)];
      
    if(I(n.x, n.y-1) != -1)
      n.neighbours[1] = nodes[I(n.x, n.y-1)];
      
    if(I(n.x+1, n.y-1) != -1)
      n.neighbours[2] = nodes[I(n.x+1, n.y-1)];
      
    if(I(n.x+1, n.y) != -1)
      n.neighbours[3] = nodes[I(n.x+1, n.y)];
      
    if(I(n.x+1, n.y+1) != -1)
      n.neighbours[4] = nodes[I(n.x+1, n.y+1)];
      
    if(I(n.x, n.y+1) != -1)
      n.neighbours[5] = nodes[I(n.x, n.y+1)];
      
    if(I(n.x-1, n.y+1) != -1)
      n.neighbours[6] = nodes[I(n.x-1, n.y+1)];
      
    if(I(n.x-1, n.y) != -1)
      n.neighbours[7] = nodes[I(n.x-1, n.y)];
  }
}

void calcNeighNearOver()
{
  int ex = 0, ey = 0;
  
  for(Node n: nodes)
  {
    if(n.end)
    {
      ex = n.x;
      ey = n.y;
    }
  }
      
  for(Node n: nodes)
    if(n.over)
    {
      for(Node nb: n.neighbours)
      {
        if(nb != null)
          if(!nb.closed && !nb.wall)
          {
            int tempH = round(sqrt((nb.x*11 - ex*11) * (nb.x*11 - ex*11) + (nb.y*11 - ey*11) * (nb.y*11 - ey*11)));
            int tempG = n.G + round(sqrt((nb.x*10 - n.x*10) * (nb.x*10 - n.x*10) + (nb.y*10 - n.y*10) * (nb.y*10 - n.y*10)));
            
            if(tempG + tempH < nb.F || !nb.open)
            {
              nb.H = tempH;
              nb.G = tempG;
              nb.calcF();
              nb.parent = n;
              nb.open = true;
            }
          }
      }
    }
}

int calcNextOver()
{
  int minF = -1;
  int minH = -1;
  int min_i = 0;
  
  for(Node n: nodes)
  {
    if(n.open)
    {
      if(minF == -1)
      {
        minF = n.F;
        min_i = I(n.x, n.y);
      }
      else if(minF > n.F)
      {
        minF = n.F;
        min_i = I(n.x, n.y);
      }
    }
  }
  
  int count = 0;
  for(Node n: nodes)
    if(n.open)
      if(n.F == minF)
        count ++;
  
  if(count > 1)
  {
    for(Node n: nodes)
    {
      if(n.open && n.F == minF)
      {
        if(minH == -1)
        {
          minH = n.H;
          min_i = I(n.x, n.y);
        }
        else if(minH > n.H)
        {
          minH = n.H;
          min_i = I(n.x, n.y);
        }
      }
    }
  }
  
  for(Node n: nodes)
    if(n.over == true)
    {
      n.over = false;
    }
    
  nodes[min_i].open = false;
  nodes[min_i].over = true;
  nodes[min_i].closed = true;
  
  return min_i;
}

void calFinalPath()
{
  for(Node n: nodes)
  {
    if(n.end && n.over)
    {
      Node n_tmp = n.parent;
      while(n_tmp.start != true)
      {
        n_tmp.final_path = true;
        n_tmp = n_tmp.parent;
      }
    }
  }
}
//A* functions



/*
void calculateH()
{
  int ex = 0, ey = 0;
  
  for(Node[] nb: nodes)
    for(Node n: nb)
      if(n.end)
      {
        ex = n.x;
        ey = n.y;
      }
      
  for(Node[] nb: nodes)
    for(Node n: nb)
      n.H = round(sqrt((n.x - ex) * (n.x - ex) + (n.y - ey) * (n.y - ey)));
}

void calculateG()
{
  int sx = 0, sy = 0;
  
  for(Node[] nb: nodes)
    for(Node n: nb)
      if(n.start)
      {
        sx = n.x;
        sy = n.y;
      }
      
  for(Node[] nb: nodes)
    for(Node n: nb)
      n.G = round(sqrt((n.x - sx) * (n.x - sx) + (n.y - sy) * (n.y - sy)));
}

void calculateF()
{
  for(Node[] nb: nodes)
    for(Node n: nb)
    n.F = n.H + n.G;
}
*/