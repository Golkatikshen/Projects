class TrisBoard
{
  float x;
  float y;
  float w;
  int[][] board;
  
  TrisBoard(float x_, float y_, float w_)
  {
    x = x_;
    y = y_;
    w = w_;
    
    board = new int[3][3];
  }
  
  void display()
  {
    stroke(255);
    strokeCap(ROUND);
    strokeWeight(6);
    
    line(x-w/2, y+w/6, x+w/2, y+w/6);
    line(x-w/2, y-w/6, x+w/2, y-w/6);
    line(x-w/6, y-w/2, x-w/6, y+w/2);
    line(x+w/6, y-w/2, x+w/6, y+w/2);
    
    
    for(int i=0; i<3; i++)
    {
      for(int j=0; j<3; j++)
      {
        float xoff = x-w/3+(j*(w/3));
        float yoff = y-w/3+(i*(w/3));
        
        if(board[j][i] == 1)
        {
          stroke(240, 140, 50);
          line(xoff-w/9, yoff-w/9, xoff+w/9, yoff+w/9);
          line(xoff-w/9, yoff+w/9, xoff+w/9, yoff-w/9);
        }
        
        if(board[j][i] == -1)
        {
          stroke(0, 190, 255);
          noFill();
          ellipse(xoff, yoff, w/4.5, w/4.5);
        }
      }
    }
  }
  
  
  float[] retState()
  {
    float[] states = new float[18];
    
    int count = 0;
    
    for(int i=0; i<3; i++)
      for(int j=0; j<3; j++)
      {
        if(board[j][i] == 1)
          states[count] = 1;
        else if(board[j][i] == -1)
          states[count+1] = 1;
          
        count+=2;
      }
      
    return states;
  }
  
  
  boolean move(int m, int v)
  {
    int count = 0;
    
    for(int i=0; i<3; i++)
    {
      for(int j=0; j<3; j++)
      {
        if(m == count && board[j][i] == 0)
        {
          board[j][i] = v;
          return true;
        }
        
        count++;
      }
    }
    
    return false;
  }
  
  boolean movable(int m)
  {
    int count = 0;
    
    for(int i=0; i<3; i++)
    {
      for(int j=0; j<3; j++)
      {
        if(m == count && board[j][i] == 0)
          return true;
          
        count++;
      }
    }
    
    return false;
  }
  
  
  int VictoryOrDraw()
  {
    for(int i=0; i<3; i++)
      if(board[0][i] + board[1][i] + board[2][i] == 3)
        return 1;
      else if(board[0][i] + board[1][i] + board[2][i] == -3)
        return -1;
        
    for(int j=0; j<3; j++)
      if(board[j][0] + board[j][1] + board[j][2] == 3)
        return 1;
      else if(board[j][0] + board[j][1] + board[j][2] == -3)
        return -1;
        
    if(board[0][0] + board[1][1] + board[2][2] == 3)
      return 1;
    if(board[0][2] + board[1][1] + board[2][0] == 3)
      return 1;
    if(board[0][0] + board[1][1] + board[2][2] == -3)
      return -1;
    if(board[0][2] + board[1][1] + board[2][0] == -3)
      return -1;
      
    return 0;
  }
  
  boolean full()
  {
    for(int i=0; i<3; i++)
      for(int j=0; j<3; j++)
        if(board[j][i] == 0)
          return false;
          
    return true;
  }
  
  void reset()
  {
    for(int i=0; i<3; i++)
      for(int j=0; j<3; j++)
        board[j][i] = 0;
  }
  
  
  
  float qRewardFunction(int v)
  {
    if(VictoryOrDraw() == 0 && full())
      return 6;
      
    if(VictoryOrDraw() == v)
      return 8;
      
    if(VictoryOrDraw() == -v)
      return -8;
    
    return VictoryEval(v) - VictoryEval(-v);
  }
  
  int VictoryEval(int v)
  {
    int c = 0;
    
    for(int i=0; i<3; i++)
      if(board[0][i] + board[1][i] + board[2][i] == v && !(board[0][i] == -v || board[1][i] == -v || board[2][i] == -v))
        c++;
        
    for(int i=0; i<3; i++)
      if(board[i][0] + board[i][1] + board[i][2] == v && !(board[i][0] == -v || board[i][1] == -v || board[i][2] == -v))
        c++;
    
    if(board[0][0] + board[1][1] + board[2][2] == v && !(board[0][0] == -v || board[1][1] == -v || board[2][2] == -v))
      c++;
      
    if(board[0][2] + board[1][1] + board[2][0] == v && !(board[0][2] == -v || board[1][1] == -v || board[2][0] == -v))
      c++;
      
    
    for(int i=0; i<3; i++)
      if(board[0][i] + board[1][i] + board[2][i] == v+v && !(board[0][i] == -v || board[1][i] == -v || board[2][i] == -v))
        c += 2;
        
    for(int i=0; i<3; i++)
      if(board[i][0] + board[i][1] + board[i][2] == v+v && !(board[i][0] == -v || board[i][1] == -v || board[i][2] == -v))
        c += 2;
    
    if(board[0][0] + board[1][1] + board[2][2] == v+v && !(board[0][0] == -v || board[1][1] == -v || board[2][2] == -v))
      c += 2;
      
    if(board[0][2] + board[1][1] + board[2][0] == v+v && !(board[0][2] == -v || board[1][1] == -v || board[2][0] == -v))
      c += 2;
      
    return c;
  }
}