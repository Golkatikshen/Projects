class Level013 extends Level
{
  Level013(Menu m_ref)
  {
    super(m_ref, "Level: 13", "OUTPUTS must be the nth (refer to TAGS) element of the 5th row of the Pascal's Triangle.", 120);

    entities.add(new EInput(Width/2, 100, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2-300, 700, 1, "1st", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2-150, 700, 4, "2nd", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 700, 6, "3rd", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2+150, 700, 4, "4th", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2+300, 700, 1, "5th", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
  }
   
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      if((outputs.get(0).val == outputs.get(0).expected) && (outputs.get(1).val == outputs.get(1).expected) && (outputs.get(2).val == outputs.get(2).expected) && (outputs.get(3).val == outputs.get(3).expected) && (outputs.get(4).val == outputs.get(4).expected))
        completato = true;
        
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
    }
  }
}