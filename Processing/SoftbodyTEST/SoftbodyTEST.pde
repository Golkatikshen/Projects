import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

Box2DProcessing box2d;

ArrayList<BSoftbody> bsbs;
Surface s;

void setup()
{
  size(700, 600);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  bsbs = new ArrayList();
  s = new Surface();
  
                    //     X,   Y,  N, R,  L ;
  bsbs.add(new BSoftbody(350, 100, 30, 1.5, 35));
  
  noLoop();
}


void draw()
{
  background(0, 0);
  
  fill(0, 255, 0);
  textSize(12);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 15);
  
  
  box2d.step();
  s.display();
  
  for(BSoftbody bsb: bsbs)
    bsb.display();
}


void mouseClicked()
{
  bsbs.add(new BSoftbody(mouseX, mouseY, 30, 1.5, 35));
  bsbs.get(bsbs.size()-1).showSkeleton = bsbs.get(0).showSkeleton;
  bsbs.get(bsbs.size()-1).showJoints = bsbs.get(0).showJoints;
  bsbs.get(bsbs.size()-1).showCells = bsbs.get(0).showCells;
}


boolean isLooping = false;
void keyPressed()
{
  if(key == 'c')
  {
    if(isLooping == false)
      loop();
    else
      noLoop();
    isLooping = !isLooping;
  }
    
    
  if(key == 's')
  {
    for(BSoftbody bsb: bsbs)
      bsb.showSkeleton = !bsb.showSkeleton;
  }
  
  if(key == 'd')
  {
    for(BSoftbody bsb: bsbs)
      bsb.showJoints = !bsb.showJoints;
  }
  
  if(key == 'f')
  {
    for(BSoftbody bsb: bsbs)
      bsb.showCells = !bsb.showCells;
  }
}