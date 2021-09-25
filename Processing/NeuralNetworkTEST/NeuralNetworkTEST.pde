
ANNetwork nn;
float xn, yn;
int cyc;
boolean train;
int train_index;
float[] outs;
int[] expect;

Wave wave;


void setup()
{
  size(1000, 750);
  textFont(createFont("Consolas", 15));
  
  xn = 580;
  yn = 300;
  
  nn = new ANNetwork(xn, yn, 6, new int[] {6, 6, 6, 6}, 6);
  cyc = 0;
  train = false;
  train_index = 1;
  outs = new float[4];
  
  wave = new Wave(10, 740, width-20);
}


void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate + " ti: " + train_index , 5, 15);
  
  String logic_gate = "";
  switch(train_index)
  {
    case 1:
      logic_gate = "OR";
      expect = new int[] {0, 1, 1, 1};
      break;
      
    case 2:
      logic_gate = "AND";
      expect = new int[] {0, 0, 0, 1};
      break;
      
    case 3:
      logic_gate = "XOR";
      expect = new int[] {0, 1, 1, 0};
      break;
      
    case 4:
      logic_gate = "NOR";
      expect = new int[] {1, 0, 0, 0};
      break;
      
    case 5:
      logic_gate = "NAND";
      expect = new int[] {1, 1, 1, 0};
      break;
      
    case 6:
      logic_gate = "NXOR";
      expect = new int[] {1, 0, 0, 1};
      break;
  }
  
  outs[0] = nn.forward(new float[] {0, 0})[0];
  outs[1] = nn.forward(new float[] {0, 1})[0];
  outs[2] = nn.forward(new float[] {1, 0})[0];
  outs[3] = nn.forward(new float[] {1, 1})[0];
  
  text("Logic Gate: " + logic_gate, 5, 175);
  text("i1  i2  expect - result", 5, 200);
  text("0   0     "+expect[0]+"      "+outs[0], 5, 225);
  text("0   1     "+expect[1]+"      "+outs[1], 5, 250);
  text("1   0     "+expect[2]+"      "+outs[2], 5, 275);
  text("1   1     "+expect[3]+"      "+outs[3], 5, 300);
  
  nn.display();
  wave.display();
  
  
  //attivazione disattivazione allenamento rete neurale
  if(train)
  {
    trainSets(train_index);
  }
}


void keyPressed()
{
  if(key == 'l')
    nn.annLoad("nntest.txt");
  if(key == 's')
    nn.annSave("nntest.txt");
    
  
  switch(key)
  {
    case '1':
      train_index = 1;
      break;
    
    case '2':
      train_index = 2;
      break;
    
    case '3':
      train_index = 3;
      break;
    
    case '4':
      train_index = 4;
      break;
    
    case '5':
      train_index = 5;
      break;
    
    case '6':
      train_index = 6;
      break;
  }
  
  if(key == 't')
    train = !train;
  
  if(key == 'x')
  {
    int r = (int)random(1, 5);
    if(r == 1)
      nn = new ANNetwork(xn, yn, (int)random(1, 6), new int[] {(int)random(1, 6)}, (int)random(1, 6));
    else if(r == 2)
      nn = new ANNetwork(xn, yn, (int)random(1, 6), new int[] {(int)random(1, 6), (int)random(1, 6)}, (int)random(1, 6));
    else if(r == 3)
      nn = new ANNetwork(xn, yn, (int)random(1, 6), new int[] {(int)random(1, 6), (int)random(1, 6), (int)random(1, 6)}, (int)random(1, 6));
    else
      nn = new ANNetwork(xn, yn, (int)random(1, 6), new int[] {(int)random(1, 6), (int)random(1, 6), (int)random(1, 6), (int)random(1, 6)}, (int)random(1, 6));
  }
  
  if(key == 'c')
    nn = new ANNetwork(xn, yn, 2, new int[] {5}, 1);
    
  if(key == 'v')
    nn = new ANNetwork(xn, yn, 2, new int[] {5, 3,  4}, 1);
    
  if(key == 'b')
    nn = new ANNetwork(xn, yn, 2, new int[] {2}, 2);
  
  
  if(key == 'q')
    nn.show_path = -1;
  if(key == 'w')
    nn.show_path--;
  if(key == 'e')
    nn.show_path++;
  
  nn.show_path = constrain(nn.show_path, -1, nn.connections.size()-1);
}


void trainSets(int n)
{
  int forpower = 1000;
  
  switch(n)
  {
    //logic gate OR
    case 1:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {0});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {1});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {1});
        else
          nn.train(new float[] {1, 1}, new float[] {1});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
    
    //logic gate AND
    case 2:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {0});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {0});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {0});
        else
          nn.train(new float[] {1, 1}, new float[] {1});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
    
    //logic gate XOR
    case 3:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {0});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {1});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {1});
        else
          nn.train(new float[] {1, 1}, new float[] {0});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
    
    //logic gate NOR
    case 4:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {1});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {0});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {0});
        else
          nn.train(new float[] {1, 1}, new float[] {0});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
    
    //logic gate NAND
    case 5:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {1});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {1});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {1});
        else
          nn.train(new float[] {1, 1}, new float[] {0});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
    
    //logic gate NXOR
    case 6:
      for(int i=0; i<forpower; i++)
      {
        if(cyc == 0)
          nn.train(new float[] {0, 0}, new float[] {1});
        else if(cyc == 1)
          nn.train(new float[] {0, 1}, new float[] {0});
        else if(cyc == 2)
          nn.train(new float[] {1, 0}, new float[] {0});
        else
          nn.train(new float[] {1, 1}, new float[] {1});
      }
      
    cyc ++;
    if(cyc > 3)
      cyc = 0;
    break;
  }
  
  wave.addYVer(abs(nn.total_error)*500);
}

float sigmoid(float n)
{
  return (1/(1+exp(-n)));
}