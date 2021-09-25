class Bacchetta
{
  String stats;
  
  Bacchetta(String _stats)
  {
    stats = _stats;
  }
  
  void display(float r)
  {
    fill(139,69,19);
    rect(0, r, -30, 4);
  }
}