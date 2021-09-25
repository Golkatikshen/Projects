//tris_brainx2_24.txt
//brain.txt


VisualRNA vrna;


void setup()
{
  size(1200, 850);
  textFont(createFont("Consolas", 30));
  
  vrna = new VisualRNA("tris_brainx2_24.txt");
  vrna.adjust();
}

void draw()
{
  background(0);

  vrna.display();
}


void keyPressed()
{
  if(key == 'w')
    vrna.addOff(0, -15);
    
  if(key == 's')
    vrna.addOff(0, 15);
    
  if(key == 'a')
    vrna.addOff(-15, 0);
    
  if(key == 'd')
    vrna.addOff(15, 0);
    
    
  if(key == 'i')
    vrna.reinitialize(1, 0);
    
  if(key == 'k')
    vrna.reinitialize(-1, 0);
    
  if(key == 'o')
    vrna.reinitialize(0, 1);
    
  if(key == 'l')
    vrna.reinitialize(0, -1);
    
    
  if(key == 'n')
    vrna.changeNeuronsSize(-1);
    
  if(key == 'm')
    vrna.changeNeuronsSize(1);
}