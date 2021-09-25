class Bacchetta
{
  String stats;
  boolean spell_ready;
  String pell_name;
  
  Bacchetta(String _stats)
  {
    stats = _stats;
    spell_ready = true;
  }
  
  void display(float r)
  {
    if(spell_ready)
    {
      imageMode(CENTER);
      float w = random(18, 24);
      image(basic_particle, r-2, r+1, w, w);
    }
      
    rectMode(CORNER);
    fill(139,69,19);
    rect(0, r, -30, 4);
  }
  
  void castSpell()
  {
    spell_ready = !spell_ready;
  }
}