class Level020 extends Level
{
  Level020(Menu m_ref)
  {
    super(m_ref, "Level: 20", "INPUT = 0 -> OUTPUT = 0\nINPUT = even -> OUTPUT = 1\nINPUT = odd -> OUTPUT = -1\n", 120);

    completati = new boolean[] {false, false, false, false, false, false, false, false, false, false};

    entities.add(new EInput(Width/2, 200, 15, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, -1, "", true));
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
        
        if(index_completati == 0)
        {
          inputs.get(0).val = 0;
          outputs.get(0).expected = 0;
        }
        else if(index_completati == 1)
        {
          inputs.get(0).val = 2;
          outputs.get(0).expected = 1;
        }
        else if(index_completati == 2)
        {
          inputs.get(0).val = 7;
          outputs.get(0).expected = -1;
        }
        else
        {
          int r = (int)random(0, 3);
          if(r == 0)
          {
            inputs.get(0).val = 0;
            outputs.get(0).expected = 0;
          }
          else
          {
            r = (int)random(0, 2) == 0 ? (int)random(-100, -1) : (int)random(1, 101);
            inputs.get(0).val = r;
            if(r % 2 == 0)
              outputs.get(0).expected = 1;
            else
              outputs.get(0).expected = -1;
          }
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