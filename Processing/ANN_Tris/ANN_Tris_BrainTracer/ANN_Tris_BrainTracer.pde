import java.util.Arrays;

TrisBoard tb;
ANNetwork ann;
static Wave wave;
String nv = "24";

ArrayList<float[][]> sets;

void setup()
{
  size(1400, 300);
  
  ann = new ANNetwork(0, 0, 18, new int[] {72, 54}, 9);
  tb = new TrisBoard(width/2, height/2, 250);
  wave = new Wave(10, 290, 1380);
  
  sets = new ArrayList();

  
  //training
  boolean first = true;
  float[] inputs;
  float[] outputs;
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

                      inputs = new float[] {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                      outputs = new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0};
                      
                      sets.add(new float[2][]);
                      sets.get(sets.size()-1)[0] = newFloatArray(inputs);
                      sets.get(sets.size()-1)[1] = newFloatArray(outputs);
                      


                      tb.board = new int[][] {{-1,  0,  0},
                                              { 0,  1,  0},
                                              { 0,  0, -1}};
     
                      outputs = new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0};
                      
                      sets.add(new float[2][]);
                      sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                      sets.get(sets.size()-1)[1] = newFloatArray(outputs);
                      
                      
                      
                      tb.board = new int[][] {{ 0,  0,  0},
                                              { 0,  1, -1},
                                              {-1,  0,  0}};                    
                                            
                      outputs = new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1};
                      
                      sets.add(new float[2][]);
                      sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                      sets.get(sets.size()-1)[1] = newFloatArray(outputs);
                      
                      
                      
                      tb.board = new int[][] {{ 0,  0,  0},
                                              {-1,  1,  0},
                                              { 0, -1,  0}};                    
                                            
                      outputs = new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0};
                      
                      sets.add(new float[2][]);
                      sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                      sets.get(sets.size()-1)[1] = newFloatArray(outputs);
                      
                      
                      
                      tb.board = new int[][] {{ 0,  0,  0},
                                              { 0, -1,  0},
                                              { 0,  0,  0}};                    
                                            
                      outputs = new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0};
                      
                      sets.add(new float[2][]);
                      sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                      sets.get(sets.size()-1)[1] = newFloatArray(outputs);
                    }
                    else
                    {
                      //modifico i valori della tabella nell'oggetto TrisBoard e la salvo in una seconda variabile
                      tb.board = new int[][] {{vals[i[0]], vals[i[1]], vals[i[2]]},
                                              {vals[i[3]], vals[i[4]], vals[i[5]]},
                                              {vals[i[6]], vals[i[7]], vals[i[8]]}};
                      
                      
                      int board_mem[][] = new int[3][3];
  
                      for(int k=0; k<3; k++)
                        for(int j=0; j<3; j++)
                          board_mem[j][k] = tb.board[j][k];
                          
                          
                      
                      
                      //controlli vari per evitare stati di gioco invalidi o finiti o simmetrici
                      int count_1 = 0;
                      int count_m1 = 0;
                      inputs = tb.retState();
                      
                      for(int j=0; j<inputs.length; j++)
                        if(inputs[j] == 1)
                          count_1++;
                        else if(inputs[j] == -1)
                          count_m1++;
                          
                          
                      if(count_1 - count_m1 != 0 && count_1 - count_m1 != -1)
                        continue;
                      
                      if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
                        continue;
                      
                      
                      boolean t = false;
                      for(int j=0; j<8; j++)
                      {
                        if(arrayUgualeSets(tb.retStatex2()))
                          t = true;
                          
                        tb.rotate_board();
                        
                        if(j == 3)
                          tb.flip_board();
                      }
                      
                      if(t)
                        continue;
                        
                      for(int k=0; k<3; k++)
                        for(int j=0; j<3; j++)
                          tb.board[j][k] = board_mem[j][k];
                       
                      
                        
                        
                      
                       
                      float max = -100;
                      int i_max = 0;
                      
                      //inizializzo in una posizione valida
                      int r;
                      do{
                        r = (int)random(0, 9);
                      }while(!tb.movable(r));
                      i_max = r;
                      
                      
                      
                      //seleziono la mossa migliore
                      for(int h=0; h<9; h++)
                      {
                        if(tb.movable(h))
                        {
                          tb.move(h, 1);
                    
                          if(max < tb.qRewardFunction(1))
                          {
                            max = tb.qRewardFunction(1);
                            i_max = h;
                          }
                          
                          for(int k=0; k<3; k++)
                            for(int j=0; j<3; j++)
                              tb.board[j][k] = board_mem[j][k];
                        }
                      }
                                            
                      
                      sets.add(new float[2][]);
                      //alleno al rete
                      switch(i_max)
                      {
                        case 0:
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0};
                          break;
                        
                        case 1:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 1, 0, 0, 0, 0, 0, 0, 0};
                          break;
                        
                        case 2:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0};
                          break;
                        
                        case 3:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0};
                          break;
                        
                        case 4:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 0, 1, 0, 0, 0, 0};
                          break;
                        
                        case 5:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 0, 0, 1, 0, 0, 0};
                          break;
                        
                        case 6:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 0, 0, 0, 1, 0, 0};
                          break;
                        
                        case 7:
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 0, 0, 0, 0, 1, 0};
                          break;
                        
                        case 8:  
                          sets.get(sets.size()-1)[0] = newFloatArray(tb.retStatex2());
                          sets.get(sets.size()-1)[1] = new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1};
                          break;
                        
                      }
                  }
                }
                
  println("N Sets: "+sets.size()+"\n");
  
  /*for(int j=0; j<sets.size(); j++)
  {
    float[] a = sets.get(j)[0];
    int count = 0;
    
    
    for(int k=0; k<18; k++)
      if(a[k] == 1)
        count ++;
        
    if(count > 1)
      continue;
       
    count = 0;
    
        
    TrisBoard tbn = new TrisBoard(0, 0, 10);
    
    tbn.board = new int[][] {{ 0,  0, -1},
                             {-1,  1,  0},
                             { 1,  0, -1}};
                             
    boolean t = false;
    for(int k=0; k<8; k++)
    {
      if(Arrays.equals(tbn.retStatex2(), a))
        t = true;
        
      tbn.rotate_board();
      
      if(k == 3)
        tbn.flip_board();
    }
    
    if(!t)
      continue;
    
    do{
      if(a[count] == 1)
        print("x ");
      else if(a[count+1] == 1)
        print("o ");
      else
        print("  ");
      
      
      count += 2;
      
      if(count % 6 == 0)
        println("\n--+---+--");
      else
        print("| ");
    }while(count != 18);
    
    a = sets.get(j)[1];
    for(int k=0; k<9; k++)
      if(a[k] == 1)
        println("best: " + k);
        
    println("\n");
  }*/
  
  
  //salvataggio simmetrie
  ArrayList<String> syms = new ArrayList();
  for(int j=0; j<sets.size(); j++)
    for(int k=0; k<18; k++)
      syms.add(String.valueOf(sets.get(j)[0][k]));
    
  saveStrings("simmetrie.txt", syms.toArray(new String[syms.size()]));
}


int index = 0;
float l = 0.6;
float max_giusti = 0;

void draw()
{
  background(0);
  
  for(int i=0; i<sets.size(); i++)
  {
    ann.train(sets.get(index)[0], sets.get(index)[1]);
    
    wave.addYVer(ann.total_error*100);
  
    index++;
    if(index == sets.size()-1)
      index = 0;
  }
  
  float c = checkGiusti();
  if(max_giusti < c)
  {
    max_giusti = c;
    print(c+"% -> ");
    save_brain();
  }

  text("Epoch: " + ann.epoch, 5, 15);
  wave.display();
}


void keyPressed()
{
  if(key == 'x')
  {
    l -= 0.01;
    println(l);
  }
  
  if(key == 'l')
    if(looping)
      noLoop();
    else
     loop();


  if(key == 'r')
  {
    println(checkGiusti());
  }
    
  if(key == 's')
  {
    save_brain();
  }
}


void save_brain()
{
  ann.annSave("tris_brainx2_"+nv+".txt");
  println("saved.");
}

float checkGiusti()
{
  int n_giusti = 0;
  for(int i=0; i<sets.size(); i++)
  {
    float[] o = ann.forward(sets.get(i)[0]);
    float max = -10;
    int i_max = 0;
    
    for(int j=0; j<o.length; j++)
      if(max < o[j])
      {
        max = o[j];
        i_max = j;
      }
      
    for(int j=0; j<sets.get(i)[1].length; j++)
      if(sets.get(i)[1][j] == 1 && j == i_max)
        n_giusti ++;
  }
  
  return((float)n_giusti * 100 / (float)sets.size());
}






float[] newFloatArray(float[] a)
{
  float[] na = new float[a.length];
  
  for(int i=0; i<a.length; i++)
    na[i] = a[i];
    
  return na;
}


boolean arrayUgualeSets(float[] a)
{
  for(int i=0; i<sets.size(); i++)
  {
    if(arrayUguale(sets.get(i)[0], a))
      return true;
  }
  
  return false;
}

boolean arrayUguale(float[] a, float[] b)
{
  if(a.length != b.length)
    return false;
    
  for(int j=0; j<a.length; j++)
    if(a[j] != b[j])
      return false;
      
  return true;
}

void print_array(float[] a)
{
  print("[");
  for(int i=0; i<a.length; i++)
    print(a[i]+", ");
  println("]");
}