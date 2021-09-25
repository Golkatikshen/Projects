//Notare numeri: 90, 104, 105, 106, 109, 119

CellularAutomaton_OneLine CA;
boolean step;
int code;

void setup()
{
  size(1200, 600);
  textFont(createFont("Consolas", 15));
  background(0);
  
  CA = new CellularAutomaton_OneLine("00000001", width, 1);
  step = false;
  
  surface.setTitle("CellularAutomatonTEST    -    Code: " + code + " / " + get8DigBin(code));
}

void draw()
{
  if(step)
  {
    println("Starting gen code " + code);
    
    CA = new CellularAutomaton_OneLine(get8DigBin(code), width, 1);
    
    while(CA.n_generation * CA.w < height)
      CA.exe();
      
    println("Done gen code " + code);
    step = false;
  }
}

void keyPressed()
{
  if(key == 'a')
    code++;
  if(key == 's')
    code--;
  
  if(code < 0)
    code = 0;
  if(code > 255)
    code = 255;
  
  surface.setTitle("CellularAutomatonTEST    -    Code: " + code + " / " + get8DigBin(code));
  
    
  if(key == 'x')
    step = true;
    
  if(key == 'c')
  {
    for(int i=0; i<CA.n_cells; i++)
    {
      if((mouseX > CA.w*i && mouseX <= CA.w*i+CA.w) && (mouseY > CA.w*CA.n_generation && mouseY <= CA.w*CA.n_generation+CA.w))
      {
        if(CA.cells.get(i).state == 0)
          CA.cells.get(i).state = 1;
        else
          CA.cells.get(i).state = 0;
      }
    }
  }
}

String get8DigBin(int n)
{
  String s = String.valueOf(binary(n));
  String ns = "";
  
  for(int i=s.length()-1; i>=s.length()-8; i--)
    ns = s.charAt(i) + ns;
    
  return ns;
}