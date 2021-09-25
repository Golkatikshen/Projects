public class Terrain
{
  PVector[] curve_points;
  TerrainThread[] tthreads;
  
  
  Terrain()
  {
    curve_points = new PVector[width/20];
    tthreads = new TerrainThread[width/20];
    generation();
  }
  
  private void generation()
  {
    //terrain main curve
    noiseSeed(0);
    float off = 0.1;
    float val = 1;
    
    for(int x=0; x<curve_points.length; x++)
    {
      float y = map(noise(val), 0, 1, 100, 700);
      val += off;
      curve_points[x] = new PVector(x*20, y);
    }
    
    //terrain blocks
    for(int i=0; i<tthreads.length; i++)
    {
      tthreads[i] = new TerrainThread(curve_points[i]);
      float y_block = curve_points[i].y;
      do{
        tthreads[i].blocks.add(new Block((int)curve_points[i].x, (int)y_block, 20, color(0, 255, 0)));
        y_block += 20;
      }while(y_block < height);
    }
  }
  
  void display()
  {
    strokeWeight(3);
    noFill();
    
    stroke(255, 0, 0);
    line(0, 400, width, 400);
    
    stroke(255);
    beginShape();
    for(int i=0; i<curve_points.length; i++)
      vertex(curve_points[i].x+10, curve_points[i].y);
    endShape();
    
    for(int i=0; i<tthreads.length; i++)
      tthreads[i].display();
  }
}