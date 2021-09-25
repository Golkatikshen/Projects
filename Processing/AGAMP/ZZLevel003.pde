class Level003 extends Level
{
  Level003(Menu m_ref)
  {
    super(m_ref, "Level: 3", "Try to use a MATH Entity.\nExpected OUTPUT: 3", 100);

    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 3, "", true));
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