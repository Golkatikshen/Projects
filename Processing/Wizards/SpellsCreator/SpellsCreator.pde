
DrawBoard db;
ANNetwork ann;
String spell_name = "strike";
ArrayList<float[]> patterns;
ArrayList<float[]> results;

void setup()
{
  size(615, 615);
  
  patterns = new ArrayList();
  results = new ArrayList();
  
  ann = new ANNetwork(0, 0, 1600, new int[] {40}, 1);
  db = new DrawBoard(15, 15, 40, 15);
}

void draw()
{
  db.display();
  
  if(mousePressed == true) 
  {
    for(int i=0; i<db.l; i++)
    {
      for(int j=0; j<db.l; j++)
      {
        float dist = pow((mouseX - (db.x+(j*db.w))), 2) + pow((mouseY - (db.y+(i*db.w))), 2);
        float off = pow(20, 2);
        if(dist < off)
        { 
          dist = map(dist, 0, off, 255, 0);
          if(db.pixel_val[j][i] < dist)
            db.pixel_val[j][i] = (int)dist;
        }
      }
    }
  }
}

void mouseReleased()
{
  db.center();
}

void keyPressed()
{
  if(key == 'l')
    ann.annSave("ann_"+spell_name+".txt");
    
  if(key == 'c')
    db.cleanBoard();
  
  if(key == 'b')
    db.fillBoard(); 
    
  if(key == '1')
  {
    println("added positive");
    patterns.add(db.retPixels());
    results.add(new float[] {1});
  }
  
  if(key == '2')
  {
    println("added negative");
    patterns.add(db.retPixels());
    results.add(new float[] {0});
  }
  
  if(key == 'f')
    println(ann.forward(db.retPixels())[0]);
    
  if(key == 't')
    trainCompletly();
}

void trainCompletly()
{
  int correct = 0;
  float correct_perc = 0;
  
  do{
    correct = 0;
    
    for(int i=0; i<patterns.size(); i++)
    {
      if(results.get(i)[0] == 1)
      {
        if(ann.forward(patterns.get(i))[0] >= 0.9)
          correct ++;
      }
      else
      {
        if(ann.forward(patterns.get(i))[0] < 0.9)
          correct ++;
      }
      
      ann.train(patterns.get(i), results.get(i));
    }
    
    correct_perc = correct * 100 / patterns.size();
    println(correct_perc);
  }while(correct_perc != 100);
}