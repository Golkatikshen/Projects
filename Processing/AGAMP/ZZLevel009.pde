class Level009 extends Level
{
  Level009(Menu m_ref)
  {
    super(m_ref, "Level: 9", "Expected OUTPUT: 13", 100);

    entities.add(new EInput(Width/2-150, 200, 144, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EInput(Width/2+150, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 13, "", true));
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