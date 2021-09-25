class BGPoint3
{
  float x;
  float y;
  
  BGPoint3[] vicini;
  
  BGPoint3(float _x, float _y)
  {
    x = _x;
    y = _y;
    
    vicini = new BGPoint3[3];
  }
  
  void setVicini(BGPoint3[] _vicini)
  {
    int index_esc[] = new int[3];
    int index_to_sel = 0;
    double min;
    int i_min = 0;
    
    for(int index=0; index<index_esc.length; index++)
    {
      min = 2000000000000000000l;
      for(int i=0; i<_vicini.length; i++)
      {
        if(index_to_sel == 0)
        {
          if(min > d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y)))
          {
            min = d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y));
            i_min = i;
          }
        }
        
        if(index_to_sel == 1)
        {
          if(i != index_esc[0])
            if(min > d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y)))
            {
              min = d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y));
              i_min = i;
            }
        }
        
        if(index_to_sel == 2)
        {
          if(i != index_esc[0] && i != index_esc[1])
            if(min > d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y)))
            {
              min = d(new PVector(x, y), new PVector(_vicini[i].x, _vicini[i].y));
              i_min = i;
            }
        }
      }
      
      index_esc[index_to_sel] = i_min;
      println(i_min);
      index_to_sel ++;
    }
    
    vicini[0] = _vicini[index_esc[0]];
    vicini[1] = _vicini[index_esc[1]];
    vicini[2] = _vicini[index_esc[2]];
  }
  
  void display()
  {
    noStroke();
    fill(255, 0, 0);
    ellipse(x, y, 5, 5);
    
    stroke(255);
    for(int i=0; i<vicini.length; i++)
      line(x, y, vicini[i].x, vicini[i].y);
      
    /*beginShape();
    vertex(vicini[0].x, vicini[0].y);
    vertex(vicini[1].x, vicini[1].y);
    vertex(vicini[2].x, vicini[2].y);
    endShape();*/
  }
}