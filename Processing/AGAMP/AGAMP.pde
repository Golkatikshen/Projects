import java.awt.Polygon;

Menu menu;
BGManager2 bgm2;
int bg_complexity;
//FARE QUARANTADUE LIVELLI


void settings()
{
  String[] strs = loadStrings("resolution.res");
  if(Boolean.valueOf(strs[0]))
  {
    fullScreen();
    fullscreen = true;
  }
  else
  {
    size(Integer.valueOf(strs[1]), Integer.valueOf(strs[2]));
    fullscreen = false;
  }
  
  bg_complexity = Integer.valueOf(strs[3]);
}


void setup()
{
  digits = createFont("Consolas", 30);
  texts = createFont("Leelawadee Bold", 30);
  alt1 = loadFont("DilleniaUPCBold-48.vlw");
  del = createFont("SegoeScript Bold", 30);

  bgm2 = new BGManager2();
  menu = new Menu();
}


void draw()
{
  background(0);  
  menu.display();
}



void mousePressed()
{
  menu.mmousePressed();
}

void mouseReleased()
{
  menu.mmouseReleased();
}

void mouseDragged()
{
  menu.mmouseDragged();
}

void mouseWheel(MouseEvent event)
{
  menu.mmouseWheel(event);
}