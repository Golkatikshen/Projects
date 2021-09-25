class Level008 extends Level
{
  Level008(Menu m_ref)
  {
    super(m_ref, "Level: 8", "The MOD (Module [%]) is a division that returns the remainder.\nSample: 3 % 2 = 1\n\nx = a % b\ny = b % a", 200);

    entities.add(new EInput(Width/2-200, 200, 5, "a", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+200, 200, 2, "b", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    
    entities.add(new EOutput(Width/2-200, 600, 1, "x", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2+200, 600, 2, "y", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
  }
  
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      if((outputs.get(0).val == outputs.get(0).expected) && (outputs.get(1).val == outputs.get(1).expected))
        completato = true;
        
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
    }
  }
}