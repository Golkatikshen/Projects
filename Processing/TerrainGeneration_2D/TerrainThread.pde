public class TerrainThread extends Thread
{
  public ArrayList<Block> blocks;
  PVector reference_point;
  
  TerrainThread(PVector _reference_point)
  {
    blocks = new ArrayList();
    reference_point = _reference_point;
  }
  
  void display()
  {
    for(int i=0; i<blocks.size(); i++)
      blocks.get(i).display();
  }
}