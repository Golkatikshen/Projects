import peasy.*;


PeasyCam cam;
Planet planet;

void setup()
{
  size(1200, 800, P3D);
  textFont(createFont("Consolas", 20));
  
  cam = new PeasyCam(this, 250);
  //cam.setMinimumDistance(180);
  cam.setMaximumDistance(1500);
  planet = new Planet();  
  
  noStroke();
}

void draw()
{
  background(0);
  
  cam.beginHUD();
  fill(255);
  textAlign(LEFT);
  text("FPS: " + (int)frameRate, 5, 20);
  text("Vertex: " + planet.ver.size(), 5, 40);
  text("Faces: " + planet.faces.size(), 5, 60);
  text("Nuvole, Stelle, Satelliti, Anelli", 5, 90);
  cam.endHUD();
  
  lights();
  planet.display();
}

void keyPressed()
{
  if(key == 'x')
    planet.TerrainGeneration();
    
  if(key == 'n')
    planet = new Planet();
}