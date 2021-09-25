class Level006 extends Level
{
  Level006(Menu m_ref)
  {
    super(m_ref, "Level: 6", "y = (x^2)+(x^3)", 100);

    entities.add(new EInput(Width/2, 200, 8, "x", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 576, "y", true));
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