import javax.swing.*;
import java.lang.*;

IDEInterface ide;


void settings()
{
  String[] ss = loadStrings("res.txt");
  size(Integer.parseInt(ss[0]), Integer.parseInt(ss[1]));
}

void setup()
{
  textFont(createFont("Consolas", 20));
  
  surface.setTitle("Confusion   -   Alessandro Morina");
  
  ide = new IDEInterface();
  
}

void draw()
{
  background(0);
  
  ide.display();
  ide.run();
  
}


void keyPressed()
{
  ide.ideKeyPressed();
}

void mousePressed()
{
  ide.ideMousePressed();
}

void mouseReleased()
{
  ide.ideMouseReleased();
}

void mouseDragged()
{
  ide.ideMouseDragged();
}

void mouseWheel(MouseEvent event)
{
  int e = event.getCount();
  ide.ideMouseWheel(e);
}