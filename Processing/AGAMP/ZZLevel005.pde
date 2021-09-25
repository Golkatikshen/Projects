class Level005 extends Level
{
  Level005(Menu m_ref)
  {
    super(m_ref, "Level: 5", "Expected OUTPUT: 12\n(You don't say?)", 100);

    entities.add(new EInput(Width/2-150, 200, 3, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+150, 200, 4, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 12, "", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
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