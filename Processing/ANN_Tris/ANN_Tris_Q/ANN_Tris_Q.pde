
TrisBoard tb;
ANNetwork ann;
int turno;
int n_partite;
int n_partite_tot;
int n_perse_ann;
int last_perse;


void setup()
{
  size(500, 500);
  
  ann = new ANNetwork(0, 0, 10, new int[] {40, 30, 20, 10}, 1);
  tb = new TrisBoard(width/2, height/2, 250);
  
  turno = 0;
  
  //training
  boolean first = true;
  float[] inputs;
  float[] board_state;
  int[] vals = new int[] {0, 1, -1};
  
  int[] i = new int[9];
  for(i[0] = 0; i[0] < 3; i[0]++)
    for(i[1] = 0; i[1] < 3; i[1]++)
      for(i[2] = 0; i[2] < 3; i[2]++)
        for(i[3] = 0; i[3] < 3; i[3]++)
          for(i[4] = 0; i[4] < 3; i[4]++)
            for(i[5] = 0; i[5] < 3; i[5]++)
              for(i[6] = 0; i[6] < 3; i[6]++)
                for(i[7] = 0; i[7] < 3; i[7]++)
                  for(i[8] = 0; i[8] < 3; i[8]++)
                  {
                    if(first)
                    {
                      first = false;
                      
                      for(int j=0; j<9; j++)
                      {
                        inputs = new float[] {0, 0, 0, 0, 0, 0, 0, 0, 0, map(j, 0, 8, 0, 1)};
                        if(j == 2)
                          ann.qLearn(10, 0.5, inputs, ann.forward(inputs)[0]);
                        else
                          ann.qLearn(-10, 0.5, inputs, ann.forward(inputs)[0]);
                      }
                    }
                    else
                    {
                      //modifico i valori della tabella nell'oggetto TrisBoard
                      tb.board = new int[][] {{vals[i[0]], vals[i[1]], vals[i[2]]},
                                              {vals[i[3]], vals[i[4]], vals[i[5]]},
                                              {vals[i[6]], vals[i[7]], vals[i[8]]}};
                      
                      
                      
                      //controlli vari per evitare stati di gioco invalidi o finiti
                      int count_1 = 0;
                      int count_m1 = 0;
                      inputs = tb.retState();
                      
                      for(int j=0; j<inputs.length; j++)
                        if(inputs[j] == 1)
                          count_1++;
                        else if(inputs[j] == -1)
                          count_m1++;
                          
                      if(count_1 - count_m1 != 0 && count_1 - count_m1 != 1 && count_1 - count_m1 != -1)
                        break;
                      
                      if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
                        break;
                        
                      
                       
                       
                      float max = 0;
                      int i_max = 0;
                      
                      //inizializzo in una posizione valida
                      int r;
                      do{
                        r = (int)random(0, 9);
                      }while(!tb.movable(r));
                      i_max = r;
                      
                      
                      
                      //seleziono la mossa migliore
                      for(int j=0; j<9; j++)
                      {
                        if(max <tb. qRewardFunction(1))
                        {
                          max = tb.qRewardFunction(1);
                          i_max = j;
                        }
                      }
                      
                      
                      
                      //inserisco il set stato tabella e mossa in un array della rete che poi dovrà imparare insieme a tutte le altre
                      board_state = tb.retState();
                      inputs = new float[10];
                      
                      for(int j=0; j<9; j++)
                      {
                        for(int k=0; k<9; k++)
                          inputs[k] = board_state[k];
                          
                        inputs[9] = map(j, 0, 8, 0, 1);
          
                        if(j == i_max)
                          ann.qLearn(10, 0.5, inputs, ann.forward(inputs)[0]);
                        else
                          ann.qLearn(-10, 0.5, inputs, ann.forward(inputs)[0]);
                      }
                    }
                  }
             
  ann.qLearnTrain();
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
    turno = 0;
  }
}




void keyPressed()
{
  if(key == 'q')
  {
    if(turno == 0)
      playANN();
    else
      playRandom(-1);
      
    turno = 1 - turno;
  }
    
    
  if(key == 's')
  {
    ann.annSave("tris_brain.txt");
    println("saved.");
  }
    
    
  if(key == 't')
  {
    int count = 0;
    while(count < 1)
    {
      count ++;
      while(n_partite < 100)
      {
        //turni
        if(turno == 0)
          playANNTrain(false);
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
      trainANN();
      
      println(last_perse+"%");
    }
  }
  
  if(key == 'r')
  {
    while(n_partite < 100)
    {
      //turni
      if(turno == 0)
        playANNTrain(n_partite_tot % 2 == 0 ? true : false);
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
    trainANN();
    
    println("Exploration complete.");
  }
  
  
  if(key == 'e')
  {
    int count = 0;
    while(count < 100000)
    {
      count ++;
      println(count);
      while(n_partite < 50)
      {
        //turni
        if(turno == 0)
          playANNTrain((int)random(0, 1000) > n_partite_tot);
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
      trainANN();
      
      println(last_perse+"%e");
      if(last_perse < 10)
        break;
    }
  }
}




void trainANN()
{
  ann.qLearnTrain();
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




void playANN()
{
  float inputs[] = new float[10];
  float board_state[];
  float max = -10;
  int i_max = 0;
  
  for(int i=0; i<9; i++)
  {
    if(tb.movable(i))
    {
      //do alla rete come input lo stato della tris board e l'azione compiuta
      board_state = tb.retState();
      
      for(int j=0; j<9; j++)
        inputs[j] = board_state[j];
        
      inputs[9] = map(i, 0, 8, 0, 1);

      println(i+": "+ann.forward(inputs)[0]);

      if(max < ann.forward(inputs)[0])
      {
        max = ann.forward(inputs)[0];
        i_max = i;
      }
    }
  }
  
  tb.move(i_max, 1);
}





void playANNTrain(boolean exp)
{
  float inputs[] = new float[10];
  float board_state[];
  float old_q;
  float max = -10;
  int i_max = 0;
  int r;
  
  //seleziono quale mossa mi conviene di più grazzie alla valutazione Q(s, a) oppure seleziono una mossa casuela detta Exploration Move
  if(!exp)
  {
    for(int i=0; i<9; i++)
    {
      if(tb.movable(i))
      {
        //do alla rete come input lo stato della tris board e l'azione compiuta
        board_state = tb.retState();
        
        for(int j=0; j<9; j++)
          inputs[j] = board_state[j];
          
        inputs[9] = map(i, 0, 8, 0, 1);

        if(max < ann.forward(inputs)[0])
        {
          max = ann.forward(inputs)[0];
          i_max = i;
        }
      }
    }
  }
  else
  {
    do{
      r = (int)random(0, 9);
    }while(!tb.movable(r));
    
    board_state = tb.retState();
        
    for(int j=0; j<9; j++)
      inputs[j] = board_state[j];
      
    inputs[9] = map(r, 0, 8, 0, 1);
    i_max = r;
  }
  
  tb.move(i_max, 1);
  old_q = ann.forward(inputs)[0];
  float[] old_inputs = inputs;
  
  //calcolo il valore massimo del next state (appena compiuto)
  max = -10;
  i_max = 0;
  for(int i=0; i<9; i++)
  {
    if(tb.movable(i))
    {
      board_state = tb.retState();
      
      for(int j=0; j<9; j++)
        inputs[j] = board_state[j];
        
      inputs[9] = map(i, 0, 8, 0, 1);
      
      if(max < ann.forward(inputs)[0])
      {
        max = ann.forward(inputs)[0];
        i_max = i;
      }
    }
  }
  
  inputs[9] = map(i_max, 0, 8, 0, 1);
  
  
  
  if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
    ann.qLearn(tb.qRewardFunction(1), 0, old_inputs, ann.forward(inputs)[0]);
  else
    ann.qLearn(tb.qRewardFunction(1), 0.5, old_inputs, ann.forward(inputs)[0]);
}