class CellularAutomaton_OneLine
{
  ArrayList<Cell> cells;
  ArrayList<Integer> new_states;
  
  String code;
  int n_generation;
  int n_cells;
  int w;
  
  
  CellularAutomaton_OneLine(String code_, int n_cells_, int w_)
  {
    code = code_;
    n_generation = 0;
    n_cells = n_cells_;
    w = w_;
    
    cells = new ArrayList();
    new_states = new ArrayList();
    
    for(int i=0; i<n_cells; i++)
      cells.add(new Cell(0));
      
    cells.get((int)cells.size()/2).state = 1;
      
    updateVicini();
  }
  
  void updateVicini()
  {
    for(int i=0; i<n_cells; i++)
    {
      if(i == 0)
      {
        cells.get(i).vicini.add(new Cell(0));
        cells.get(i).vicini.add(cells.get(i));
        cells.get(i).vicini.add(cells.get(i+1));
      }
      else if(i+1 == n_cells)
      {
        cells.get(i).vicini.add(cells.get(i-1));
        cells.get(i).vicini.add(cells.get(i));
        cells.get(i).vicini.add(new Cell(0));
      }
      else
      {
        cells.get(i).vicini.add(cells.get(i-1));
        cells.get(i).vicini.add(cells.get(i));
        cells.get(i).vicini.add(cells.get(i+1));
        
      }
    }
  }
 
  
  void exe()
  {
    if(n_generation != 0)
      update();
    else
      n_generation ++;
      
    display();
  }
  
  
  void update()
  {
    new_states.clear();
    String s;
    
    for(Cell c: cells)
    {
      s = "";
      
      for(Cell v: c.vicini)
        s += v.state;
        
      switch(s)
      {
        case "000":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(0))));
          break;
        case "001":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(1))));
          break;
        case "010":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(2))));
          break;
        case "011":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(3))));
          break;
        case "100":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(4))));
          break;
        case "101":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(5))));
          break;
        case "110":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(6))));
          break;
        case "111":
          new_states.add(Integer.parseInt(String.valueOf(code.charAt(7))));
          break;
      }
    }
    
    for(Cell c: cells)
      c.changeState(new_states.remove(0));
      
    n_generation++;
  }
  
  
  void display()
  {
    for(int i=0; i<n_cells; i++)
    {
      if(cells.get(i).state == 0)
      {
        stroke(0);
        fill(0);
      }
      else
      {
        stroke(255);
        fill(255);
      }
      
      rect(w*i, w*n_generation, w, w);
    }
  }
}