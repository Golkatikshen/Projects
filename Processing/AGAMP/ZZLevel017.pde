class Level017 extends Level
{
  Level017(Menu m_ref)
  {
    super(m_ref, "Level: 17", "Expected OUTPUT: 35th Fibonacci's Sequence element.\n\nWhere:\n   n: 0, 1, 2, 3, 4, 5, 6\nF(n): 0, 1, 1, 2, 3, 5, 8", 205);

    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    
    entities.add(new EOutput(Width/2, 600, 9227465, "", true));
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