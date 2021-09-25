class Level019 extends Level
{
  Level019(Menu m_ref)
  {
    super(m_ref, "Level: 19", "x = a + b - c\ny = (b / a) / 2 + x\nz = x * y + 0\n\nA,B,C > 0", 145);

    completati = new boolean[] {false, false, false, false};

    entities.add(new EInput(Width/2-200, 200, 4, "a", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2, 200, 8, "b", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+200, 200, 16, "c", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    
    entities.add(new EOutput(Width/2-200, 600, -4, "x", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, -3, "y", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2+200, 600, 12, "z", true));
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
      
      if((outputs.get(0).val == outputs.get(0).expected) && (outputs.get(1).val == outputs.get(1).expected) && (outputs.get(2).val == outputs.get(2).expected))
      {
        completati[index_completati] = true;
        
        int a = (int)random(1, 100);
        int b = (int)random(1, 100);
        int c = (int)random(1, 100);
        
        float x = a + b - c;
        float y = (b / a) / 2 + x;
        float z = x * y;
        
        inputs.get(0).val = a;
        inputs.get(1).val = b;
        inputs.get(2).val = c;
        outputs.get(0).expected = x;
        outputs.get(1).expected = y;
        outputs.get(2).expected = z;
        
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