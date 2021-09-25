
Button b;


void setup()
{
  size(400, 400);
  textFont(createFont("Consolas", 15));
  
  b = new Button(width/2, height/2, 200, 30, "Clicca qui per boh", 8);
}

void draw()
{
  background(0);
  
  b.display();
}


void mouseClicked()
{
  if(b.mouseHover())
    println("cliccato");
}