//RECORD: 92.55%  hln = {28}, learn_strength = 10


ANNetwork ann;
DrawBoard db;

int train_val;
float[] ann_outputs;
int[] ann_outputs_perc;
int ran;


void setup()
{
  size(650, 550);
  
  ann = new ANNetwork("brain.txt");
  db = new DrawBoard(15, 30, 28, 15);
  ann_outputs = new float[ann.n_outputs];
  ann_outputs_perc = new int[ann.n_outputs];
  
  ran = (int)random(0, 4);
  
  //loadAndTrainCompletly();
  test();
}

void draw()
{
  background(0);
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  db.display();
  
  if(mousePressed == true) 
  {
    for(int i=0; i<db.l; i++)
    {
      for(int j=0; j<db.l; j++)
      {
        float dist = pow((mouseX - (db.x+(j*db.w))), 2) + pow((mouseY - (db.y+(i*db.w))), 2);
        float off = pow(30, 2);
        if(dist < off)
        { 
          dist = map(dist, 0, off, 255, 0);
          if(db.pixel_val[j][i] < dist)
            db.pixel_val[j][i] = (int)dist;
        }
      }
    }
  }
  
  textSize(18);
  fill(0, 255, 0);
  textAlign(RIGHT, TOP);
  text("Train Val: " + train_val, 645, 25);
  text("Train Epoch: " + ann.epoch, 645, 50);
  textSize(20);
  for(int i=0; i<10; i++)
  {
    ann_outputs_perc[i] = (int)(ann_outputs[i]*100);
    text(i+": "+ann_outputs_perc[i]+"%", 645, 100+(22*i));
  }
  
  
  textAlign(LEFT, BOTTOM);
  textSize(35);
  if(tuttiSottoPerc(30))
    text("Boh non capisco niente", 5, 545);
  else
  {
    float max = -1;
    int i_max = -1;
    
    for(int i=0; i<10; i++)
    {
      if(ann_outputs[i] > max)
      {
        max = ann_outputs[i];
        i_max = i;
      }
    }
    
    
    String articolo = i_max == 0 ? "uno " : "un ";
    
    switch(ran)
    {
      case 0:
        text("Probabilmente è " + articolo + i_max, 5, 545);
        break;
      
      case 1:
        text("Forse è " + articolo + i_max, 5, 545);
        break;
      
      case 2:
        text("Mi sembra " + articolo + i_max, 5, 545);
        break;
      
      case 3:
        text("Potrebbe essere " + articolo + i_max, 5, 545);
        break;
    }
  }
}




void keyPressed()
{ 
  if(key == 'l')
    ann.annSave("brain_v2.txt");
    
  if(key == 'c')
    cleanBoard();
  
  if(key == 'f')
  {
    ran = (int)random(0, 4);
    db.center();
    ann_outputs = ann.forward(db.retPixels());
  }
}


boolean tuttiSottoPerc(float p)
{
  for(int i=0; i<10; i++)
    if(ann_outputs_perc[i] > p)
      return false;
      
  return true;
}


void cleanBoard()
{
  db.cleanBoard();
  
  for(int i=0; i<10; i++)
  {
    ann_outputs[i] = 0;
    ann_outputs_perc[i] = 0;
  }
}


void loadAndTrain(int learn_strength)
{
  String trains[] = loadStrings("mnist_train.csv");
  String numsplit[];
  int num_count[] = new int[] {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  
  for(int cyc=0; cyc<learn_strength; cyc++)
  {
    //println(cyc+"/"+learn_strength);
    for(int i=0; i<trains.length; i++)
    {
      println(cyc+"/"+learn_strength+" - "+i+"/"+trains.length);
      numsplit = split(trains[i], ",");
      
      num_count[Integer.valueOf(numsplit[0])]++;
      
      int index = 1;
      for(int y=0; y<28; y++)
      {
        for(int x=0; x<28; x++)
        {
          db.pixel_val[x][y] = Integer.valueOf(numsplit[index]);
          index++;
        }
      }
      
      if(db.center())
      {
        switch(Integer.valueOf(numsplit[0]))
        {
          case 0:
            ann.train(db.retPixels(), new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 1:
            ann.train(db.retPixels(), new float[] {0, 1, 0, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 2:
            ann.train(db.retPixels(), new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 3:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 4:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 1, 0, 0, 0, 0, 0}, 1);
            break;
            
           case 5:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, 1);
            break;
            
          case 6:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, 1);
            break;
            
          case 7:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 1, 0, 0}, 1);
            break;
            
          case 8:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1, 0}, 1);
            break;
            
          case 9:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 1);
            break;
        }
      }
    }
  }
    
  cleanBoard();
}


void loadAndTrainCompletly()
{
  String trains[] = loadStrings("mnist_train.csv");
  String numsplit[];
  int index, correct = 0, valid = 0;
  float cperc = 0;
  
  //conteggio dei validi
  for(int i=0; i<trains.length; i++)
  {
    numsplit = split(trains[i], ",");
            
    index = 1;
    for(int y=0; y<28; y++)
    {
      for(int x=0; x<28; x++)
      {
        db.pixel_val[x][y] = Integer.valueOf(numsplit[index]);
        index++;
      }
    }
  
    if(db.center())
      valid++;
  }
  
  println(valid);
  
  do{
    correct = 0;

    for(int i=0; i<trains.length; i++)
    {
      numsplit = split(trains[i], ",");
            
      index = 1;
      for(int y=0; y<28; y++)
      {
        for(int x=0; x<28; x++)
        {
          db.pixel_val[x][y] = Integer.valueOf(numsplit[index]);
          index++;
        }
      }
      
      
      if(db.center())
      {
        //verifica correttezza prima dell'apprendimento
        ann_outputs = ann.forward(db.retPixels());
        float max = -1;
        int i_max = -1;
        
        for(int j=0; j<10; j++)
          if(ann_outputs[j] > max)
          {
            max = ann_outputs[j];
            i_max = j;
          }
        
        if(Integer.valueOf(numsplit[0]) == i_max)
          correct ++;
        
        
        //apprendimento
        switch(Integer.valueOf(numsplit[0]))
        {
          case 0:
            ann.train(db.retPixels(), new float[] {1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 1:
            ann.train(db.retPixels(), new float[] {0, 1, 0, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 2:
            ann.train(db.retPixels(), new float[] {0, 0, 1, 0, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 3:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 1, 0, 0, 0, 0, 0, 0}, 1);
            break;
            
          case 4:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 1, 0, 0, 0, 0, 0}, 1);
            break;
            
           case 5:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, 1);
            break;
            
          case 6:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, 1);
            break;
            
          case 7:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 1, 0, 0}, 1);
            break;
            
          case 8:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1, 0}, 1);
            break;
            
          case 9:
            ann.train(db.retPixels(), new float[] {0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 1);
            break;
        }
      }
    }
    
    cleanBoard();
    cperc = (float)correct * 100 / (float)valid;
    println(cperc+"%");
    ann.annSave("brain_v2.txt");
  }while(cperc != 100);
}


void test()
{
  String tests[] = loadStrings("mnist_test.csv");
  String numsplit[];
  float correct = 0;
  
  for(int i=0; i<tests.length; i++)
  {
    numsplit = split(tests[i], ",");
            
    int index = 1;
    for(int y=0; y<28; y++)
    {
      for(int x=0; x<28; x++)
      {
        db.pixel_val[x][y] = Integer.valueOf(numsplit[index]);
        index++;
      }
    }
    
    db.center();
    ann_outputs = ann.forward(db.retPixels());
    float max = -1;
    int i_max = -1;
    
    for(int j=0; j<10; j++)
      if(ann_outputs[j] > max)
      {
        max = ann_outputs[j];
        i_max = j;
      }
    
    
    if(Integer.valueOf(numsplit[0]) == i_max)
      correct ++;
  }
  
  correct = correct * 100 / tests.length;
  println("\n\nAccuracy: "+correct+"%");
  
  cleanBoard();
}