class Level001 extends Level
{   
  Level001(Menu m_ref)
  {
    super(m_ref, "Level: 1", "The value at the output must be the same as the input one.", 100);
   
    
    entities.add(new EInput(Width/2, 200, 42, "", true));
    inputs.add((EInput)entities.get(0));
    entities.add(new EOutput(Width/2, 600, 42, "", true));
    outputs.add((EOutput)entities.get(1));
  }
  
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      if(outputs.get(0).val == outputs.get(0).expected)
        completato = true;
      
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
    }
  }
}


/*
class Level001 extends Level
{   
  Level001(Menu m_ref)
  {
    super(m_ref, "Level: 1", "The value at the output must be the same as the input one.", 100);
   
    entities.add(new EInput(Width/2, 200, 42, "", true));
    inputs.add((EInput)entities.get(0));
    entities.add(new EOutput(Width/2, 600, 42, "", true));
    outputs.add((EOutput)entities.get(1));
  }
  
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati() && !completato)
    {
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
      
      if(outputs.get(0).val == outputs.get(0).expected)
      {
        completati[index] = true;
        
        int r = (int)random(0, 100);
        inputs.get(0).val = r;
        outputs.get(0).expected = r;
        
        index ++;
      }
      
      if(index == 3)
      {
        if(allCompleted())
          completato = true;
        else
          completatiSetAllFalse();
      }
      else
        RUN();
    }
  }
}
*/