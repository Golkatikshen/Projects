
TrisBoard tb;
ANNetwork ann_ettore;
ANNetwork ann_achille;
int turno;
int n_partite;
int n_partite_tot;
int n_perse_ann;
int last_perse;


void setup()
{
  size(500, 500);
  
  ann_ettore = new ANNetwork(0, 0, 18, new int[] {27}, 9);
  ann_achille = new ANNetwork(0, 0, 9, new int[] {27, 9}, 9);
  tb = new TrisBoard(width/2, height/2, 250);
  
  turno = (int)random(0, 2);
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  text("Last perse: " + last_perse +"%", 5, 35);
  
  tb.display();
  
  //check fine partita
  if(tb.VictoryOrDraw() == -1)
    n_perse_ann++;
    
  if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
  {
    tb.reset();
    n_partite++;
    turno = (int)random(0, 2);
  }
}




void keyPressed()
{
  if(key == 't')
  {
    int count = 0;
    while(count < 100)
    {
      count ++;
      
      while(n_partite < 50)
      {
        if(turno == 0)
          playANN(1, "Ettore");
        else
          playRandom(-1);
          
        turno = 1 - turno;
        
        //check fine partita
        if(tb.VictoryOrDraw() == -1)
          n_perse_ann++;
          
        if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
        {
          tb.reset();
          n_partite++;
          turno = (int)random(0, 2);
        }
      }
      
      last_perse = n_perse_ann * 100 / n_partite;
      println(last_perse+"% Ettoreq");
      
      n_partite = 0;
      n_perse_ann = 0;
    }
  }
  
  if(key == 'q')
  {
    if(turno == 0)
      playANN(1, "Ettore");
    else
      playRandom(-1);
      
    turno = 1 - turno;
  }
  
  if(key == 'v')
  {
    if(turno == 0)
      playANN(1, "Ettore");
    else
      playANN(-1, "Achille");
      
    turno = 1 - turno;
  }
    
    
  if(key == 's')
  {
    ann_ettore.annSave("tris_ettore_brain.txt");
    ann_achille.annSave("tris_achille_brain.txt");
    println("saved.");
  }
    
   
  
  if(key == 'e')
  {
    int count = 0;
    while(count < 1)
    {
      count ++;
      while(n_partite < 50)
      {
        //turni
        if(turno == 0)
          playTrainANN(1, "Ettore");
        else
          playRandom(-1);
          
        turno = 1 - turno;
        
        
        //check fine partita
        if(tb.VictoryOrDraw() == -1)
          n_perse_ann++;
          
        if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
        {
          tb.reset();
          n_partite++;
          n_partite_tot++;
          turno = (int)random(0, 2);
        }
      }
    
      last_perse = n_perse_ann * 100 / n_partite;
      trainANN("Ettore");
      
      println(last_perse+"% Ettore");
    }
  }
  
  if(key == 'a')
  {
    int count = 0;
    while(count < 100)
    {
      count ++;
      while(n_partite < 50)
      {
        //turni
        if(turno == 0)
          playTrainANN(1, "Achille");
        else
          playRandom(-1);
          
        turno = 1 - turno;
        
        
        //check fine partita
        if(tb.VictoryOrDraw() == -1)
          n_perse_ann++;
          
        if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
        {
          tb.reset();
          n_partite++;
          n_partite_tot++;
          turno = (int)random(0, 2);
        }
      }
    
      last_perse = n_perse_ann * 100 / n_partite;
      trainANN("Achille");
      
      println(last_perse+"% Achille");
    }
  }
  
  if(key == 'd')
  {
    int count = 0;
    int n_vinte_ettore = 0;
    int n_vinte_achille = 0;
    
    while(count < 100)
    {
      count ++;
      while(n_partite < 50)
      {
        //turni
        if(turno == 0)
          playTrainANN(1, "Ettore");
        else
          playTrainANN(-1, "Achille");
          
        turno = 1 - turno;
        
        
        //check fine partita
        if(tb.VictoryOrDraw() == 1)
          n_vinte_ettore++;
        if(tb.VictoryOrDraw() == -1)
          n_vinte_achille++;
          
        if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
        {
          tb.reset();
          n_partite++;
          n_partite_tot++;
          turno = (int)random(0, 2);
        }
      }
    
      println("Vinte Achille: " + (n_vinte_achille * 100 / n_partite) + "% | Vinte Ettore: " + (n_vinte_ettore * 100 / n_partite) + "%");
    
      trainANN("Ettore");
      trainANN("Achille");
      
      n_vinte_ettore = 0;
      n_vinte_achille = 0;
    }
  }
}




void trainANN(String nome)
{
  if(nome.equals("Ettore"))
    ann_ettore.dataLearnTrain();
  else
    ann_achille.dataLearnTrain();
    
  n_perse_ann = 0;
  n_partite = 0;
}




void playRandom(int v)
{
  int r;
  do{
    r = (int)random(0, 9);
  }while(!tb.move(r, v));
}


void playTrainANN(int v, String nome)
{
  float max = 0;
  int i_max = 0;
  int board_mem[][] = new int[3][3];
  
  
  for(int i=0; i<3; i++)
    for(int j=0; j<3; j++)
      board_mem[j][i] = tb.board[j][i];
  
  
  int r;
  do{
    r = (int)random(0, 9);
  }while(!tb.movable(r));
  i_max = r;
  
  
  for(int i=0; i<9; i++)
  {
    if(tb.movable(i))
    {
      tb.move(i, v);

      if(max < tb.qRewardFunction(v))
      {
        max = tb.qRewardFunction(v);
        i_max = i;
      }
      
      for(int k=0; k<3; k++)
        for(int j=0; j<3; j++)
          tb.board[j][k] = board_mem[j][k];
    }
  }
  
  tb.move(i_max, v);
  
  if(nome.equals("Ettore"))
  {
    switch(i_max)
    {
      case 0:  
        ann_ettore.dataLearn(tb.retState(), new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0});
        break;
      
      case 1:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 1, 0, 0, 0, 0, 0, 0, 0});
        break;
      
      case 2:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0});
        break;
      
      case 3:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0});
        break;
      
      case 4:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 1, 0, 0, 0, 0});
        break;
      
      case 5:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 1, 0, 0, 0});
        break;
      
      case 6:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 1, 0, 0});
        break;
      
      case 7:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 0, 1, 0});
        break;
      
      case 8:  
        ann_ettore.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1});
        break;
      
    }
  }
  else
  {
    switch(i_max)
    {
      case 0:  
        ann_achille.dataLearn(tb.retState(), new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0});
        break;
      
      case 1:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 1, 0, 0, 0, 0, 0, 0, 0});
        break;
      
      case 2:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0});
        break;
      
      case 3:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0});
        break;
      
      case 4:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 1, 0, 0, 0, 0});
        break;
      
      case 5:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 1, 0, 0, 0});
        break;
      
      case 6:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 1, 0, 0});
        break;
      
      case 7:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 0, 1, 0});
        break;
      
      case 8:  
        ann_achille.dataLearn(tb.retState(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1});
        break;
      
    }
  }
}


void playANN(int v, String nome)
{
  float inputs[] = tb.retState();
  float outputs[] = null;
  
  if(nome.equals("Ettore"))
    outputs = ann_ettore.forward(inputs);
  else
    outputs = ann_achille.forward(inputs);
    
  float max = 0;
  int i_max = 0;
  
  for(int i=0; i<9; i++)
  {
    if(tb.movable(i))
    {
      if(max < outputs[i])
      {
        max = outputs[i];
        i_max = i;
      }
    }
  }
  
  tb.move(i_max, v);
}