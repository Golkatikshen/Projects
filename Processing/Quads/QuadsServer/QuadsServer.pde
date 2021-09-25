import processing.net.*;

Quad[][] quads;
Server server;
ArrayList<Player> players;
Button btn_start;


void setup()
{
  size(800, 600);
  
  server = new Server(this, 10069);
  players = new ArrayList();
  btn_start = new Button(700, 550, 120, 40, "START", 8, -3, 100, 100, 100);
  
  int s = 120;
  int w = 80;
  quads = new Quad[5][5];
  for(int i=0; i<5; i++)
    for(int j=0; j<5; j++)
      quads[j][i] = new Quad(20+(j*s), 20+(i*s), w);
}

void draw()
{
  background(0);
  btn_start.display();
  
  for(int i=0; i<5; i++)
    for(int j=0; j<5; j++)
      quads[j][i].display();
      
  for(int i=0; i<players.size(); i++)
  {
    fill(getColor(players.get(i).c));
    text(players.get(i).name, 720, 40+(40*i));
  }
      
  //NETWORKING
  Client thisClient = server.available();
  if(thisClient != null)
  {
    String s = thisClient.readString();
    if (s != null)
    {
      String[] ss = s.split(";");
      switch(ss[0])
      {
        case "COL":
          for(int i=0; i<players.size(); i++)
            if(players.get(i).ip.equals(thisClient.ip()))
              if(colorAvaiable(Integer.parseInt(ss[1])))
              {
                players.get(i).c = Integer.parseInt(ss[1]);
                thisClient.write("_ok");
              }
              else
                thisClient.write("_fail");
        break;
        
        case "NAM":
          for(int i=0; i<players.size(); i++)
            if(players.get(i).ip.equals(thisClient.ip()))
              if(nameAvaiable(ss[1]))
              {
                players.get(i).name = ss[1];
                thisClient.write("_ok");
                println(ss[1] + " si è connesso!");
              }
              else
                thisClient.write("_fail");
        break;
      }
    }
  }
}

void serverEvent(Server se, Client cl)
{
  players.add(new Player(cl));
}

void disconnectEvent(Client cl) {
  for(int i=0; i<players.size(); i++)
    if(players.get(i).ip.equals(cl.ip()))
    {
      println(players.get(i).name + " si è disconnesso...");
      players.remove(i);
    }
}


boolean nameAvaiable(String name)
{
  for(int i=0; i<players.size(); i++)
    if(players.get(i).name.equals(name))
      return false;
      
  return true;
}

boolean colorAvaiable(int c)
{
  for(int i=0; i<players.size(); i++)
    if(players.get(i).c == c)
      return false;
      
  return true;
}