class Level016 extends Level
{
  Level016(Menu m_ref)
  {
    super(m_ref, "Level: 16", "I do not care how: OUTPUT must be PI (3.14)\n\n(Do not worry about decimals, I will approximate it for you).", 175);

    entities.add(new EInput(Width/2, 200, 1, "", true));
    inputs.add((EInput)entities.get(entities.size()-1));
    entities.add(new EOutput(Width/2, 600, 3.14, "", true));
    outputs.add((EOutput)entities.get(entities.size()-1));
  }
  
  void run()
  {
    super.run();
    
    //fine run livello
    if(outputsAttivati())
    {
      if(Float.valueOf(nfc(outputs.get(0).val, 2)) == outputs.get(0).expected)
        completato = true;
      
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
    }
  }
}