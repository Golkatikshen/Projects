class Level015 extends Level
{
  Level015(Menu m_ref)
  {
    super(m_ref, "Level: 15", "We think of infinity as a really big number, but it’s not. It’s endlessness. Endlessness is a really strange idea in a universe that is defined by its endings.\n- John Green", 225);

    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    double inf = Double.POSITIVE_INFINITY;
    entities.add(new EOutput(Width/2, 600, (float)inf, "", true));
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