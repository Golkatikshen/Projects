class Level021 extends Level
{
  Level021(Menu m_ref)
  {
    super(m_ref, "Level: 21", "If there are 4 INPUTS equal to 1, the OUTPUT must be 1.\nIf there are less then 4 or more, the OUTPUT must be 0.\n\nINPUTS can be 1 or 0.", 225);

    completati = new boolean[] {false, false, false, false, false, false, false, false, false, false};

    entities.add(new EInput(Width/2-400, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2-200, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+200, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+400, 200, 0, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    
    entities.add(new EOutput(Width/2, 700, 1, "", true));
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
        
        int[] v = new int[] {(int)random(0, 3) == 0 ? 0 : 1, (int)random(0, 3) == 0 ? 0 : 1, (int)random(0, 3) == 0 ? 0 : 1, (int)random(0, 3) == 0 ? 0 : 1, (int)random(0, 3) == 0 ? 0 : 1};
        int vs = v[0] + v[1] + v[2] + v[3] + v[4];
        
        inputs.get(0).val = v[0];
        inputs.get(1).val = v[1];
        inputs.get(2).val = v[2];
        inputs.get(3).val = v[3];
        inputs.get(4).val = v[4];
        
        outputs.get(0).expected = (vs == 4 ? 1 : 0);
        
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