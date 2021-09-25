class Solver
{
  TriangularGrid s_tg;
  TriangularGrid mem_s_tg;
  String sol_moves;
  int n_moves;
  int n_col;
  
  Solver(TriangularGrid tg, int _n_moves, int _n_col, String _sol_moves)
  {
    s_tg = tg.cloneTG();
    mem_s_tg = tg.cloneTG();
    
    sol_moves = _sol_moves;
    n_moves = _n_moves;
    n_col = _n_col;
  }

  void solve_V2()
  {
    if(n_moves == 0)
    {
      if(s_tg.allSameColor())
        println(sol_moves);

      return;
    }
    
    s_tg.createLinks();
    s_tg.createGroups();
    mem_s_tg.createLinks();
    mem_s_tg.createGroups();
    //println("ginoA");
    
    for(int i=0; i<s_tg.groups.size(); i++)
    {
      //println("ginoB");
      for(int j=0; j<n_col; j++)
      {
        //println("ginoC");
        Triangle t = s_tg.groups.get(i).get(0);
        t.colorSelfLinked(selectColor(char(j+49)));
        //println(getColorName(s_tg.triangles[0][0].c) + " " + getColorName(s_tg.triangles[0][1].c));
        
        Solver sol = new Solver(s_tg, n_moves-1, 2, sol_moves+s_tg.getCoordTriangle(t)+getColorName(selectColor(char(j+49)))+";  ");
        sol.solve_V2();
        
        s_tg = mem_s_tg.cloneTG();
        s_tg.createLinks();
        s_tg.createGroups();
      }
    }
  }
  
  
  
  /*void solve()
  {
    while(!s_tg.allSameColor())
    {
      sol_moves = "";
      for(int i=0; i<s_tg.R; i++)
        for(int j=0; j<s_tg.C; j++)
          s_tg.triangles[i][j] = mem_s_tg.triangles[i][j].cloneTriangle();
      s_tg.createLinks();
      
      for(int i=0; i<n_moves; i++)
      {
        int rx, ry, rci;
        color rc;
        
        do{
          rx = int(random(0, s_tg.C));
          ry = int(random(0, s_tg.R));
          rci = int(random(1, 8));
          rc = selectColor(char(rci));
          println("gino");
        }while(s_tg.triangles[ry][rx].c != color(0));
        
        sol_moves += "["+rx+","+ry+"]"+rci+"; ";
        println(sol_moves);
        
        s_tg.triangles[ry][rx].colorSelfLinked(rc);
        s_tg.createLinks();
      }
    }
    
    println("Solved! " + sol_moves);
  }*/
}