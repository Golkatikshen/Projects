
TrisBoard tb;
ANNetwork ann;
int turno;
int n_partite;
int n_vinte_ann;
int last_vinte;


void setup()
{
  size(500, 500);
  
  ann = new ANNetwork(0, 0, 10, new int[] {20, 9, 5}, 1);
  tb = new TrisBoard(width/2, height/2, 250);
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  text("Last vinte: " + last_vinte +"%", 5, 35);
  
  tb.display();
  
  //check fine partita
  if(tb.VictoryOrDraw() == 1)
    n_vinte_ann++;
    
  if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
  {
    tb.reset();
    n_partite++;
    turno = (int)random(0, 2);
  }
}


void keyPressed()
{
  if(key == 'q')
  {
    if(turno == 0)
      playANN();
    else
      playRandom();
      
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
    while(count < 10)
    {
      count ++;
      while(n_partite < 1000)
      {
        //turni
        if(turno == 0)
          playANN();
        else
          playRandom();
          
        turno = 1 - turno;
        
        
        //check fine partita
        if(tb.VictoryOrDraw() == 1)
          n_vinte_ann++;
          
        if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
        {
          tb.reset();
          n_partite++;
          turno = (int)random(0, 2);
        }
      }
    
      last_vinte = n_vinte_ann * 100 / n_partite;
      trainANN();
      
      println(last_vinte+"%");
    }
  }
    
    
  if(key == 'p')
    playANN();
  
  
  if(key == 'r')
    playRandom();
}



void trainANN()
{
  ann.qLearnTrain();
  n_vinte_ann = 0;
  n_partite = 0;
}


void playRandom()
{
  int r;
  do{
    r = (int)random(0, 9);
  }while(!tb.move(r, -1));
}


void playANN()
{
  float inputs[] = new float[10];
  float board_state[];
  float old_q;
  float max = -10;
  int i_max = 0;
  
  //seleziono quale mossa mi conviene di più grazzie alla valutazione Q(s, a)
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
  
  tb.move(i_max, 1);
  old_q = ann.forward(inputs)[0];
  
  
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
  
  
  println(tb.qRewardFunction(1));
  
  if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
    ann.qLearn(old_q, tb.qRewardFunction(1), 0, inputs, ann.forward(inputs)[0]);
  else
    ann.qLearn(old_q, tb.qRewardFunction(1), 0.5, inputs, ann.forward(inputs)[0]);
}