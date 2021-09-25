class Level018 extends Level
{
  Level018(Menu m_ref)
  {
    super(m_ref, "Level: 18", "INPUT = N\nOUTPUT = N!\n0 < N <= 10", 100);

    completati = new boolean[] {false, false, false, false, false};

    entities.add(new EInput(Width/2, 200, 4, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));

    entities.add(new EOutput(Width/2, 600, 24, "", true));
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
        
        int r = (int)random(1, 11);
        inputs.get(0).val = r;
        outputs.get(0).expected = factorial(r);
        
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