class Level011 extends Level
{
  Level011(Menu m_ref)
  {
    super(m_ref, "Level: 11", "The sum of numbers from 1 to 10 (inclusive)", 100);

    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 1+2+3+4+5+6+7+8+9+10, "", true));
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