class Particle
{
  PVector pos;
  PVector vel;
  float r;
  
  Particle(PVector _pos, float _r)
  {
    vel = new PVector(0, 0);
    pos = _pos.copy();
    r = _r;
  }
  
  void update()
  {
    pos.add(vel);
    
    if(pos.x <= 0)
      pos.x = width-1;
    if(pos.x >= width)
      pos.x = 1;
    if(pos.y <= 0)
      pos.y = height-1;
    if(pos.y >= height)
      pos.y = 1;
  }
  
  void display()
  {
    noStroke();
    fill(0, 10);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  void follow(PVector[] flowfield)
  {
    int x = floor(pos.x / w_cells);
    int y = floor(pos.y / w_cells);
    int index = x + y * floor(width / w_cells);
    
    
    try{
      vel = flowfield[index].copy();
    } catch (ArrayIndexOutOfBoundsException e) {
      println("Err: qualcuno è fuori dai margini?!");
    }
  }
}