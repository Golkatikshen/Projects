class Level002 extends Level
{
  Level002(Menu m_ref)
  {
    super(m_ref, "Level: 2", "Same as level 1 but take care about the Entity TAG.", 100);

    entities.add(new EInput(350, 200, 1, "A", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(700, 600, 1, "A", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
    entities.add(new EInput(600, 200, 2, "B", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(450, 600, 2, "B", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
  }
  
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      if(outputs.get(0).val == outputs.get(0).expected && outputs.get(1).val == outputs.get(1).expected)
        completato = true;
      
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
    }
  }
}