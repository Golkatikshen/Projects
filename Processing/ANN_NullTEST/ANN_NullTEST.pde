
ANNetwork nn;
float xn, yn;
int cyc;
boolean train;
float[][] outs;
int[] expect;

Wave wave;


void setup()
{
  size(1000, 750);
  textFont(createFont("Consolas", 15));
  
  xn = 580;
  yn = 300;
  
  nn = new ANNetwork(xn, yn, 3, new int[] {6, 4}, 2);
  cyc = 0;
  train = false;
  outs = new float[7][2];
  
  wave = new Wave(10, 740, width-20);
}


void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  
  outs[0][0] = nn.forward(new float[] {0, 0, 0})[0];
  outs[0][1] = nn.forward(new float[] {0, 0, 0})[1];
  
  outs[1][0] = nn.forward(new float[] {0, 1, 0})[0];
  outs[1][1] = nn.forward(new float[] {0, 1, 0})[1];
  
  outs[2][0] = nn.forward(new float[] {1, 0, 1})[0];
  outs[2][1] = nn.forward(new float[] {1, 0, 1})[1];
  
  outs[3][0] = nn.forward(new float[] {1, 1, 0})[0];
  outs[3][1] = nn.forward(new float[] {1, 1, 0})[1];
  
  outs[4][0] = nn.forward(new float[] {0, 1, 1})[0];
  outs[4][1] = nn.forward(new float[] {0, 1, 1})[1];
  
  outs[5][0] = nn.forward(new float[] {1, 0, 0})[0];
  outs[5][1] = nn.forward(new float[] {1, 0, 0})[1];
  
  outs[6][0] = nn.forward(new float[] {1, 1, 1})[0];
  outs[6][1] = nn.forward(new float[] {1, 1, 1})[1];
  
  
  text("i1  i2  i3   result", 5, 200);
  text("0   0   0    "+nfc(outs[0][0], 2)+", "+nfc(outs[0][1], 2), 5, 225);
  text("0   1   0    "+nfc(outs[1][0], 2)+", "+nfc(outs[1][1], 2), 5, 250);
  text("1   0   1    "+nfc(outs[2][0], 2)+", "+nfc(outs[2][1], 2), 5, 275);
  text("1   1   0    "+nfc(outs[3][0], 2)+", "+nfc(outs[3][1], 2), 5, 300);
  text("0   1   1    "+nfc(outs[4][0], 2)+", "+nfc(outs[4][1], 2), 5, 325);
  text("1   0   0    "+nfc(outs[5][0], 2)+", "+nfc(outs[5][1], 2), 5, 350);
  text("1   1   1    "+nfc(outs[6][0], 2)+", "+nfc(outs[6][1], 2), 5, 375);
  
  nn.display();
  wave.display();
  
  
  //attivazione disattivazione allenamento rete neurale
  if(train)
  {
    trainN();
  }
}


void keyPressed()
{
  if(key == 'l')
    nn.annLoad("nntest.txt");
  if(key == 's')
    nn.annSave("nntest.txt");


  if(key == 't')
    train = !train;
    
  
  if(key == 'c')
    nn = new ANNetwork(xn, yn, 3, new int[] {6, 4}, 2);
    
  if(key == 'v')
    nn = new ANNetwork(xn, yn, 3, new int[] {5, 3,  4}, 2);
    
  if(key == 'b')
    nn = new ANNetwork(xn, yn, 3, new int[] {2}, 2);
  
  
  if(key == 'q')
    nn.show_path = -1;
  if(key == 'w')
    nn.show_path--;
  if(key == 'e')
    nn.show_path++;
  
  nn.show_path = constrain(nn.show_path, -1, nn.connections.size()-1);
}


void trainN()
{
  int forpower = 1000;
  
  for(int i=0; i<forpower; i++)
  {
    if(cyc == 0)
      nn.train(new float[] {0, 0, 0}, new float[] {0, 0});
    else if(cyc == 1)
      nn.train(new float[] {0, 1, 0}, new float[] {0, 0});
    else if(cyc == 2)
      nn.train(new float[] {1, 0, 1}, new float[] {0, 1});
    else if(cyc == 3)
      nn.train(new float[] {1, 1, 0}, new float[] {1, 0});
    else if(cyc == 4)
      nn.train(new float[] {0, 1, 1}, new float[] {0, 0});
    else if(cyc == 5)
      nn.train(new float[] {1, 0, 0}, new float[] {0, 0});
    else
      nn.train(new float[] {1, 1, 1}, new float[] {1, 1});
      
    cyc ++;
    if(cyc > 6)
      cyc = 0;
  }
  
  wave.addYVer(abs(nn.total_error)*500);
}

float sigmoid(float n)
{
  return (1/(1+exp(-n)));
}