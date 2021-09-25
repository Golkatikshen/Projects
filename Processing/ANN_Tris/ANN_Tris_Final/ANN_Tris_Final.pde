
TrisBoard tb;
ANNetwork ann;
int turno;
int vinte_u, vinte_rna, pareggio;


ArrayList<float[]> simmetrie;
InvButton[] buttons;


void setup()
{
  size(500, 500);
  textFont(createFont("Consolas", 30));
  
  ann = new ANNetwork("tris_brainx2_24.txt");
  tb = new TrisBoard(width/2, height/2+50, 250);
  simmetrie = new ArrayList();
  buttons = new InvButton[9];
  for(int i=0; i<3; i++)
    for(int j=0; j<3; j++)
      buttons[i*3+j] = new InvButton(width/2-85+(85*j), height/2-35+(85*i), 85, 85);
  
  turno = (int)random(0, 2);
  
  
  //caricamento simmetrie
  String[] syms = loadStrings("simmetrie.txt");
  int index_sym = 0;
  
  do{
    simmetrie.add(new float[18]);
    for(int i=0; i<18; i++)
    {
      simmetrie.get(simmetrie.size()-1)[i] = Float.valueOf(syms[index_sym]);
      index_sym++;
    }
  }while(index_sym != syms.length);
  
  
  
  //visualizza il numero di neuroni
  println("N neuroni: "+ann.n_neurons);
}


void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(20);
  textAlign(LEFT);
  
  if(turno == 0)
    text("Turno: RNA", 5, 20);
  else
    text("Turno: Umano", 5, 20);
    
  textAlign(RIGHT);
  text("Vinte Umano: " + vinte_u, 485, 20);
  text("Vinte RNA: " + vinte_rna, 485, 45);
  text("Pareggio: " + pareggio, 485, 70);
  
  textAlign(LEFT);
  textSize(13);
  text("Q per far giocare la RNA", 5, 38);
  
  
  tb.display();
  
  
  //check fine partita
  if(tb.VictoryOrDraw() == 1)
    vinte_rna ++;
    
  if(tb.VictoryOrDraw() == -1)
    vinte_u ++;
    
  if(tb.VictoryOrDraw() == 0 && tb.full())
    pareggio ++;
  
  if(tb.VictoryOrDraw() == 1 || tb.VictoryOrDraw() == -1 || (tb.VictoryOrDraw() == 0 && tb.full()))
  {
    tb.reset();
    turno = (int)random(0, 2);
  }
  
  for(int i=0; i<9; i++)
    buttons[i].display();
}



void mouseClicked()
{
  for(int i=0; i<9; i++)
    if(buttons[i].mouseHover() && tb.movable(i) && turno == 1)
    {
      tb.move(i, -1);
      turno = 1 - turno;
    }
}



void keyPressed()
{
  if(key == 'q')
  {
    if(turno == 0)
    {
      playANN();
      turno = 1 - turno;
    }
  }
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
  //hack simmetria
  boolean flipped = false;
  int deg = 0;
  boolean t = false;
  for(int j=0; j<8; j++)
  {
    for(int i=0; i<simmetrie.size(); i++)
    {
      if(arrayUguale(tb.retStatex2(), simmetrie.get(i)))
      {
        t = true;
        break;
      }
    }
      
    if(t)
      break;
      
    tb.rotate_board();
    deg += 90;
    if(deg == 360)
     deg = 0;
    
    if(j == 3)
    {
      tb.flip_board();
      flipped = true;
    }
  }
  
  
  //mossa migliore
  float max = -10;
  int i_max = 0;
  
  float[] outputs = ann.forward(tb.retStatex2());
  
  int r;
  do{
    r = (int)random(0, 9);
  }while(!tb.movable(r));
  i_max = r;
                      
  
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
  
  tb.move(i_max, 1);
  
  
  //cancella hack simmetria
  deg /= 90;
  
  for(int i=0; i<deg; i++)
    for(int j=0; j<3; j++)
      tb.rotate_board();
      
  if(flipped)
    tb.flip_board();
}




boolean arrayUgualeSets(float[] a)
{
  for(int i=0; i<simmetrie.size(); i++)
  {
    if(arrayUguale(simmetrie.get(i), a))
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