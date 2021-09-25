class DrawBoard
{
  float x;
  float y;
  int l;
  int w;
  int[][] pixel_val;
  
  DrawBoard(float x_, float y_, int l_, int w_)
  {
    x = x_;
    y = y_;
    l = l_;
    w = w_;

    pixel_val = new int[l][l];
  }
  
  void display()
  {
    stroke(255);
    for(int i=0; i<l; i++)
      for(int j=0; j<l; j++)
      {
        rectMode(CENTER);
        fill(map(pixel_val[j][i], 0, 255, 255, 0));
        rect(x+(j*w), y+(i*w), w, w);
      }
  }
  
  float[] retPixels()
  {
    float[] inputs = new float[l*l];
    int index = 0;
    
    for(int i=0; i<l; i++)
      for(int j=0; j<l; j++)
      {
        inputs[index] = map(pixel_val[j][i], 0, 255, 0, 1);
        index ++;
      }
      
    return inputs;
  }
  
  boolean center()
  {
    int count = 0;
    float xpm = 0;
    float ypm = 0;
    
    for(int i=0; i<l; i++)
      for(int j=0; j<l; j++)
        if(pixel_val[j][i] > 0)
        {
          xpm += j;
          ypm += i;
          count ++;
        }
    
    xpm /= count;
    ypm /= count;
    
    
    int[][] mem_pixel_val = new int[l][l];
    float xtv = l/2 - xpm;
    float ytv = l/2 - ypm;
    
    try
    {
      for(int i=0; i<l; i++)
        for(int j=0; j<l; j++)
          if(pixel_val[j][i] > 0)
          {
            mem_pixel_val[(int)(j+xtv)][(int)(i+ytv)] = pixel_val[j][i];
          } 
    }
    catch(Exception e)
    {
      return false;
    }
    
    pixel_val = mem_pixel_val;
    return true;
  }
  
  void cleanBoard()
  {
    for(int i=0; i<db.l; i++)
      for(int j=0; j<db.l; j++)
        pixel_val[j][i] = 0;
  }
  
  void fillBoard()
  {
    for(int i=0; i<db.l; i++)
      for(int j=0; j<db.l; j++)
        pixel_val[j][i] = 255;
  }
}