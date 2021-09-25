
ArrayList<Float> cribio;

Solver solver;
TriangularGrid tg;
color selected_color;

int num_moves = 1;
int num_colors = 2;


void setup()
{
  size(1000, 900);
  textFont(createFont("Consolas", 15));

  tg = new TriangularGrid(250, 60, 29, 10, 32);
  selected_color = color(0, 255, 0);
}

int off = 45;
void draw()
{
  background(0);
  
  fill(255);
  text("Selected color: ", 5, 15);
  fill(selected_color);
  rect(135, 6, 10, 10);
  fill(255);
  text("Mouse Hover: "+tg.coordMouseHover(), 5, 35);
  text("Max n moves: "+num_moves, 5, 55);
  text("N colors: "+num_colors, 5, 75);
  
  text("Nums: change color", 5, 60+off);
  text("P,L: change n moves", 5, 80+off);
  text("O,K: change n colors", 5, 100+off);
  text("Drag right mouse button to paint", 5, 120+off);
  text("Click left mouse button to 'play'", 5, 140+off);
  text("F: fill with sel color", 5, 160+off);
  text("S: solve", 5, 180+off);
  
  
  tg.display();
}

void mouseDragged()
{
  if(mouseButton == RIGHT)
    tg.tgmouseDragged();
}

void mouseClicked()
{
  if(mouseButton == LEFT)
    tg.tgmouseClicked();
}

void keyPressed()
{
  if(key == 's')
  {
    solver = new Solver(tg, num_moves, num_colors, "");
    solver.solve_V2();
  }
  
  if(key == 'p')
    num_moves ++;
  if(key == 'l')
    num_moves --;
  if(num_moves == 0)
    num_moves = 1;
    
  if(key == 'o')
    num_colors ++;
  if(key == 'k')
    num_colors --;
  if(num_colors == 1)
    num_colors = 2;
  
  if(key == 'f')
    tg.colorAll(selected_color);
    
  if(key == 'c')
    tg.createLinks();
    
  if(key == 'g')
  {
    tg.createGroups();
    println(tg.groups.size());
    for(ArrayList a: tg.groups)
      println("s: "+a.size());
  }
    
  if(key >= '1' && key <= '8')
    selected_color = selectColor(key);
}

color selectColor(char k)
{
  switch(k)
  {
    case '1':
      return color(255, 0, 0);
    
    case '2':
      return color(0, 255, 0);
      
    case '3':
      return color(0, 0, 255);
      
    case '4':
      return color(255, 255, 0);
      
    case '5':
      return color(255, 0, 255);
      
    case '6':
      return color(0, 255, 255);
      
    case '7':
      return color(250, 140, 0);
      
    case '8':
      return color(0);
  }
  
  return color(255);
}

String getColorName(color cl)
{
  if(cl == color(255, 0, 0))
      return "red";
    
  if(cl ==  color(0, 255, 0))
      return "green";
      
  if(cl ==  color(0, 0, 255))
      return "blu";
      
  if(cl ==  color(255, 255, 0))
      return "yellow";
      
  if(cl ==  color(255, 0, 255))
      return "magenta";
      
  if(cl ==  color(0, 255, 255))
      return "cyan";
      
  if(cl ==  color(250, 140, 0))
      return "orange";
      
  if(cl ==  color(0))
      return "black";
  
  return "idk";
}