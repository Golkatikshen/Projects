class Level014 extends Level
{
  Level014(Menu m_ref)
  {
    super(m_ref, "Level: 14", "If the INPUT is not 0 the OUTPUT must be 1. If the INPUT is 0 the OUTPUT must be 0.", 120);

    completati = new boolean[] {false, false, false, false, false, false};

    entities.add(new EInput(Width/2, 200, 13, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 1, "", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
  }
   
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
      
      if(outputs.get(0).val == outputs.get(0).expected)
      {
        completati[index_completati] = true;
        
        int r = (int)random(0, 2);
        if(r == 0)
        {
          inputs.get(0).val = 0;
          outputs.get(0).expected = 0;
        }
        else
        {
          r = (int)random(0, 2) == 0 ? (int)random(-100, 0) : (int)random(1, 101);
          inputs.get(0).val = r;
          outputs.get(0).expected = 1;
        }
        
        index_completati ++;
      }
      else
         completatiSetAllFalse();
         
      
      if(index_completati == completati.length)
      {
        if(allCompleted())
        {
          completato = true;
          completatiSetAllFalse();
        }
        else
          completatiSetAllFalse();
      }
      else
        RUN();
    }
  }
}