class Level022 extends Level
{
  Level022(Menu m_ref)
  {
    super(m_ref, "Level: 22", "If N is a Prime number,\nP = 1.\nIf N is NOT a Prime,\nP = 0.\n\n2 <= N <= 20", 175);

    completati = new boolean[] {false, false, false, false, false, false, false};

    entities.add(new EInput(Width/2, 200, 21, "N", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    
    entities.add(new EOutput(Width/2, 600, 0, "P", true));
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
        
        int r = (int)random(2, 21);

        inputs.get(0).val = r;
        outputs.get(0).expected = isPrime(r) ? 1 : 0;
        
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