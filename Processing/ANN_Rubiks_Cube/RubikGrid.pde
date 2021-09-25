class RubikGrid 
{
  int x;
  int y;
  int w;
  int b;
  int W;

  Quad[][][] faces = new Quad[3][3][6];

  RubikGrid(int x, int y, int w, int b)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.b = b;
    this.W = w*3+b*4;

    //0
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][0] = new Quad(W+x+(j*w)+(j*b), y+(i*w)+(i*b), w);

    //1
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][1] = new Quad(x+(j*w)+(j*b), W+y+(i*w)+(i*b), w);

    //2
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][2] = new Quad(W+x+(j*w)+(j*b), W+y+(i*w)+(i*b), w);

    //3
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][3] = new Quad(2*W+x+(j*w)+(j*b), W+y+(i*w)+(i*b), w);

    //4
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][4] = new Quad(3*W+x+(j*w)+(j*b), W+y+(i*w)+(i*b), w);

    //5
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
        faces[j][i][5] = new Quad(W+x+(j*w)+(j*b), 2*W+y+(i*w)+(i*b), w);
        
        
    reset();
  }
  
  
  void display()
  {
    fill(0);
    rect(W+x-b, y-b, W, W);
    rect(x-b, W+y-b, W, W);
    rect(W+x-b, W+y-b, W, W);
    rect(2*W+x-b, W+y-b, W, W);
    rect(3*W+x-b, W+y-b, W, W);
    rect(W+x-b, 2*W+y-b, W, W);

    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
          faces[j][i][k].display();
  }
  
  
  
  void clickQuadCheck(int nb)
  {
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
        {
          if (faces[j][i][k].mouseHover())
          {
            if (nb == 1)
              faces[j][i][k].c = 0;
            else
              faces[j][i][k].c = 2;
          }
        }
  }
  
  String[] retCoordIdMouseHover()
  {
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
          if (faces[j][i][k].mouseHover())
            return new String[] {(j + ", " + i + ", " + k), String.valueOf(faces[j][i][k].id)};
            
    return new String[] {"", ""};
  }
  
  
  float[] retGridPieceFocus(int[] vs)
  {
    float[] to_ret = new float[162];
    int index = 0;
    boolean done;
    
    for(int k=0; k<6; k++)
      for(int i=0; i<3; i++)
        for(int j=0; j<3; j++)
        {
          done = false;
          for(int iv=0; iv<vs.length; iv++)
          {
            if(faces[j][i][k].id == vs[iv])
            {
              switch(faces[j][i][k].c)
              {
                case 0:
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 0; index ++;
                  done = true;
                  break;
                
                case 1:
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 1; index ++;
                  done = true;
                  break;
                
                case 2:
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 0; index ++;
                  done = true;
                  break;
                
                case 3:
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 1; index ++;
                  done = true;
                  break;
                
                case 4:
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 0; index ++;
                  done = true;
                  break;
                
                case 5:
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 0; index ++;
                  to_ret[index] = 1; index ++;
                  done = true;
                  break;
                
                case 6:
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 1; index ++;
                  to_ret[index] = 0; index ++;
                  done = true;
                  break;
              }
            }
          }
          
          if(!done)
          {
            to_ret[index] = 1; index ++;
            to_ret[index] = 1; index ++;
            to_ret[index] = 0; index ++;
          }
        }
        
    return to_ret;
  }
  
  
  
  void exeMove(int m)
  {
    println(m);
    switch(m)
    {
      case 0:
        R();
        break;
        
      case 1:
        Ri();
        break;
      
      case 2:
        L();
        break;
      
      case 3:
        Li();
        break;
      
      case 4:
        U();
        break;
      
      case 5:
        Ui();
        break;
      
      case 6:
        D();
        break;
      
      case 7:
        Di();
        break;
      
      case 8:
        F();
        break;
      
      case 9:
        Fi();
        break;
      
      case 10:
        B();
        break;
      
      case 11:
        Bi();
        break;
    }
  }
  
  
  void printGrid()
  {
    String s = "";
    for(int k=0; k<6; k++)
      for(int i=0; i<3; i++)
        for(int j=0; j<3; j++)
          switch(faces[j][i][k].c)
          {
            case 0:
              s += "0, 0, 0, ";
              break;
            
            case 1:
              s += "0, 0, 1, ";
              break;
            
            case 2:
              s += "0, 1, 0, ";
              break;
            
            case 3:
              s += "0, 1, 1, ";
              break;
            
            case 4:
              s += "1, 0, 0, ";
              break;
            
            case 5:
              s += "1, 0, 1, ";
              break;
            
            case 6:  
              s += "1, 1, 0, ";
              break;
          }
          
    s = s.substring(0, s.length()-2);
    s +="});\n";
    println(s+"\n");
  }
  
  
  /////////////////////
  /*void Hov()
  {
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
        {
          if (faces[j][i][k].Hover())
          {
            Main.game.POS = "["+j+", "+i+", "+k+"]";
            return;
          }
        }

    Main.game.POS = "";
  }*/
  /////////////////////


  int[] getFC(int x, int y, int s)
  {
    return new int[] {faces[x][y][s].c, faces[x][y][s].id};
  }
  
  void setFC(int x, int y, int s, int[] fc)
  {
    faces[x][y][s].c = fc[0];
    faces[x][y][s].id = fc[1];
  }

  
  

  //RESET
  void reset()
  {
    scramble_mem = "";
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
          faces[j][i][k].reset();
          
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
          faces[j][i][k].id = (k * 3 * 3) + (i * 3) + j;
  }


  //COLOR
  void setColors()
  {
    scramble_mem = "";
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
      {
        faces[j][i][0].c = 0;
        faces[j][i][1].c = 1;
        faces[j][i][2].c = 2;
        faces[j][i][3].c = 3;
        faces[j][i][4].c = 4;
        faces[j][i][5].c = 5;
      }
      
    for (int k=0; k<6; k++)
      for (int i=0; i<3; i++)
        for (int j=0; j<3; j++)
          faces[j][i][k].id = (k * 3 * 3) + (i * 3) + j;
  }


  //SCRAMBLE
  void scramble(int n_moves)
  {
    setColors();
    scramble_mem = "";
    for (int i=0; i<n_moves; i++)
    {
      switch((int)random(0, 6))
      {
      case 0:
        U();
        scramble_mem += "U - ";
        break;
      case 1:
        L();
        scramble_mem += "L - ";
        break;
      case 2:
        F();
        scramble_mem += "F - ";
        break;
      case 3:
        R();
        scramble_mem += "R - ";
        break;
      case 4:
        B();
        scramble_mem += "B - ";
        break;
      case 5:
        D();
        scramble_mem += "D - ";
        break;
      }
    }

    scramble_mem = scramble_mem.substring(0, scramble_mem.length()-3);
  }


  //SOLVE
  void Solve()
  {
    if (CheckSolution())
    {
      println("RISOLTO!??!!?");
    }
  }

  private boolean CheckSolution()
  {
    for (int i=0; i<3; i++)
      for (int j=0; j<3; j++)
      {
        if (faces[j][i][0].c != 0)
          return false;
        if (faces[j][i][1].c != 1)
          return false;
        if (faces[j][i][2].c != 2)
          return false;
        if (faces[j][i][3].c != 3)
          return false;
        if (faces[j][i][4].c != 4)
          return false;
        if (faces[j][i][5].c != 5)
          return false;
      }

    return true;
  }




  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  //MOVES
  void R()
  {
    int[] tmp;
    for (int i=0; i<3; i++)
    {
      tmp = getFC(2, 0, 2);
      setFC(2, 0, 2, getFC(2, 1, 2));
      setFC(2, 1, 2, getFC(2, 2, 2));
      setFC(2, 2, 2, getFC(2, 0, 5));
      setFC(2, 0, 5, getFC(2, 1, 5));
      setFC(2, 1, 5, getFC(2, 2, 5));
      setFC(2, 2, 5, getFC(0, 2, 4));
      setFC(0, 2, 4, getFC(0, 1, 4));
      setFC(0, 1, 4, getFC(0, 0, 4));
      setFC(0, 0, 4, getFC(2, 0, 0));
      setFC(2, 0, 0, getFC(2, 1, 0));
      setFC(2, 1, 0, getFC(2, 2, 0));
      setFC(2, 2, 0, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 3);
      setFC(0, 0, 3, getFC(0, 1, 3));
      setFC(0, 1, 3, getFC(0, 2, 3));
      setFC(0, 2, 3, getFC(1, 2, 3));
      setFC(1, 2, 3, getFC(2, 2, 3));
      setFC(2, 2, 3, getFC(2, 1, 3));
      setFC(2, 1, 3, getFC(2, 0, 3));
      setFC(2, 0, 3, getFC(1, 0, 3));
      setFC(1, 0, 3, tmp);
    }
  }


  void L()
  {
    int[] tmp;
    for (int i=0; i<3; i++)
    {
      tmp = getFC(0, 0, 2);
      setFC(0, 0, 2, getFC(0, 2, 0));
      setFC(0, 2, 0, getFC(0, 1, 0));
      setFC(0, 1, 0, getFC(0, 0, 0));
      setFC(0, 0, 0, getFC(2, 0, 4));
      setFC(2, 0, 4, getFC(2, 1, 4));
      setFC(2, 1, 4, getFC(2, 2, 4));
      setFC(2, 2, 4, getFC(0, 2, 5));
      setFC(0, 2, 5, getFC(0, 1, 5));
      setFC(0, 1, 5, getFC(0, 0, 5));
      setFC(0, 0, 5, getFC(0, 2, 2));
      setFC(0, 2, 2, getFC(0, 1, 2));
      setFC(0, 1, 2, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 1);
      setFC(0, 0, 1, getFC(0, 1, 1));
      setFC(0, 1, 1, getFC(0, 2, 1));
      setFC(0, 2, 1, getFC(1, 2, 1));
      setFC(1, 2, 1, getFC(2, 2, 1));
      setFC(2, 2, 1, getFC(2, 1, 1));
      setFC(2, 1, 1, getFC(2, 0, 1));
      setFC(2, 0, 1, getFC(1, 0, 1));
      setFC(1, 0, 1, tmp);
    }
  }


  void U()
  {
    int[] tmp;
    for (int i=0; i<3; i++)
    {
      tmp = getFC(0, 0, 1);
      setFC(0, 0, 1, getFC(1, 0, 1));
      setFC(1, 0, 1, getFC(2, 0, 1));
      setFC(2, 0, 1, getFC(0, 0, 2));
      setFC(0, 0, 2, getFC(1, 0, 2));
      setFC(1, 0, 2, getFC(2, 0, 2));
      setFC(2, 0, 2, getFC(0, 0, 3));
      setFC(0, 0, 3, getFC(1, 0, 3));
      setFC(1, 0, 3, getFC(2, 0, 3));
      setFC(2, 0, 3, getFC(0, 0, 4));
      setFC(0, 0, 4, getFC(1, 0, 4));
      setFC(1, 0, 4, getFC(2, 0, 4));
      setFC(2, 0, 4, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 0);
      setFC(0, 0, 0, getFC(0, 1, 0));
      setFC(0, 1, 0, getFC(0, 2, 0));
      setFC(0, 2, 0, getFC(1, 2, 0));
      setFC(1, 2, 0, getFC(2, 2, 0));
      setFC(2, 2, 0, getFC(2, 1, 0));
      setFC(2, 1, 0, getFC(2, 0, 0));
      setFC(2, 0, 0, getFC(1, 0, 0));
      setFC(1, 0, 0, tmp);
    }
  }

  void D()
  {
    int[] tmp;
    for (int i=0; i<9; i++)
    {
      tmp = getFC(0, 2, 1);
      setFC(0, 2, 1, getFC(1, 2, 1));
      setFC(1, 2, 1, getFC(2, 2, 1));
      setFC(2, 2, 1, getFC(0, 2, 2));
      setFC(0, 2, 2, getFC(1, 2, 2));
      setFC(1, 2, 2, getFC(2, 2, 2));
      setFC(2, 2, 2, getFC(0, 2, 3));
      setFC(0, 2, 3, getFC(1, 2, 3));
      setFC(1, 2, 3, getFC(2, 2, 3));
      setFC(2, 2, 3, getFC(0, 2, 4));
      setFC(0, 2, 4, getFC(1, 2, 4));
      setFC(1, 2, 4, getFC(2, 2, 4));
      setFC(2, 2, 4, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 5);
      setFC(0, 0, 5, getFC(0, 1, 5));
      setFC(0, 1, 5, getFC(0, 2, 5));
      setFC(0, 2, 5, getFC(1, 2, 5));
      setFC(1, 2, 5, getFC(2, 2, 5));
      setFC(2, 2, 5, getFC(2, 1, 5));
      setFC(2, 1, 5, getFC(2, 0, 5));
      setFC(2, 0, 5, getFC(1, 0, 5));
      setFC(1, 0, 5, tmp);
    }
  }


  void F()
  {
    int[] tmp;
    for (int i=0; i<9; i++)
    {
      tmp = getFC(0, 2, 0);
      setFC(0, 2, 0, getFC(1, 2, 0));
      setFC(1, 2, 0, getFC(2, 2, 0));
      setFC(2, 2, 0, getFC(0, 0, 3));
      setFC(0, 0, 3, getFC(0, 1, 3));
      setFC(0, 1, 3, getFC(0, 2, 3));
      setFC(0, 2, 3, getFC(2, 0, 5));
      setFC(2, 0, 5, getFC(1, 0, 5));
      setFC(1, 0, 5, getFC(0, 0, 5));
      setFC(0, 0, 5, getFC(2, 2, 1));
      setFC(2, 2, 1, getFC(2, 1, 1));
      setFC(2, 1, 1, getFC(2, 0, 1));
      setFC(2, 0, 1, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 2);
      setFC(0, 0, 2, getFC(0, 1, 2));
      setFC(0, 1, 2, getFC(0, 2, 2));
      setFC(0, 2, 2, getFC(1, 2, 2));
      setFC(1, 2, 2, getFC(2, 2, 2));
      setFC(2, 2, 2, getFC(2, 1, 2));
      setFC(2, 1, 2, getFC(2, 0, 2));
      setFC(2, 0, 2, getFC(1, 0, 2));
      setFC(1, 0, 2, tmp);
    }
  }


  void B()
  {
    int[] tmp;
    for (int i=0; i<3; i++)
    {
      tmp = getFC(0, 0, 0);
      setFC(0, 0, 0, getFC(1, 0, 0));
      setFC(1, 0, 0, getFC(2, 0, 0));
      setFC(2, 0, 0, getFC(2, 0, 3));
      setFC(2, 0, 3, getFC(2, 1, 3));
      setFC(2, 1, 3, getFC(2, 2, 3));
      setFC(2, 2, 3, getFC(2, 2, 5));
      setFC(2, 2, 5, getFC(1, 2, 5));
      setFC(1, 2, 5, getFC(0, 2, 5));
      setFC(0, 2, 5, getFC(0, 2, 1));
      setFC(0, 2, 1, getFC(0, 1, 1));
      setFC(0, 1, 1, getFC(0, 0, 1));
      setFC(0, 0, 1, tmp);
    }

    for (int i=0; i<2; i++)
    {
      tmp = getFC(0, 0, 4);
      setFC(0, 0, 4, getFC(0, 1, 4));
      setFC(0, 1, 4, getFC(0, 2, 4));
      setFC(0, 2, 4, getFC(1, 2, 4));
      setFC(1, 2, 4, getFC(2, 2, 4));
      setFC(2, 2, 4, getFC(2, 1, 4));
      setFC(2, 1, 4, getFC(2, 0, 4));
      setFC(2, 0, 4, getFC(1, 0, 4));
      setFC(1, 0, 4, tmp);
    }
  }


  void Ri()
  {
    R(); 
    R(); 
    R();
  }


  void Li()
  {
    L(); 
    L(); 
    L();
  }


  void Ui()
  {
    U(); 
    U(); 
    U();
  }


  void Di()
  {
    D(); 
    D(); 
    D();
  }


  void Fi()
  {
    F(); 
    F(); 
    F();
  }


  void Bi()
  {
    B(); 
    B(); 
    B();
  }
}