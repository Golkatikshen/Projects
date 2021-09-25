class Cell
{
  int state;
  ArrayList<Cell> vicini;
  
  Cell(int state_)
  {
    state = state_;
    vicini = new ArrayList();
  }
  
  public void changeState(int newState)
  {
    state = newState;
  }
}