class Player
{
  float x;
  float y;
  float r;
  float speed;
  String dir;
  String[] cmds;
  float cd_CerchioDiPalle;
  
  Player(int _x, int _y, int _r, float _speed)
  {
    x = _x;
    y = _y;
    r = _r;
    speed = _speed;
    dir = "stop";
    
    cmds = new String[10];
    for(int i=0; i<10; i++)
      cmds[i] = "";
      
    cd_CerchioDiPalle = 0;
  }
  
  boolean update(Zombie[] zombies)
  {
    //cd updates;
    if(cd_CerchioDiPalle > 0)
      cd_CerchioDiPalle -= deltaTime;
    else if(cd_CerchioDiPalle < 0)
      cd_CerchioDiPalle = 0;
    
    //check zombie collision;
    for(Zombie z: zombies)
    {
      if(z != null)
        if(((x-z.x)*(x-z.x))+((y-z.y)*(y-z.y)) < ((r/2) + (z.r/2))*((r/2) + (z.r/2)))
          return true;
    }
    
    //check direction;
    switch(dir)
    {
      case "nord":
      y -= speed * deltaTime;
      if(y-(r/2) < 0)
        y = (r/2);
      break;
      
      case "sud":
      y += speed * deltaTime;
      if(y+(r/2) > height)
        y = height - (r/2);
      break;
      
      case "est":
      x += speed * deltaTime;
      if(x+(r/2) > width)
        x = width - (r/2);
      break;
      
      case "ovest":
      x -= speed * deltaTime;
      if(x-(r/2) < 0)
        x = (r/2);
      break;
    }
    
    return false;
  }
  
  void display()
  {
    stroke(10);
    fill(255, 0, 0);
    ellipse(x, y, r, r);
  }
  
  void elaboraMessaggio(String msg, Battlefield bf)
  {
    msg = msg.toLowerCase();
    msg = msg.replace("este", "est");
    if(msg.charAt(0) == ' ')
      msg = msg.substring(1, msg.length());
    
    
    for(int i=8; i>=0; i--)
      cmds[i+1] = cmds[i];
    cmds[0] = msg;

    msg = msg.replace(" ", "");
    
    switch(msg)
    {
      case "vaiversonord":
        dir = "nord";
      break;
      
      case "vaiversosud":
        dir = "sud";
      break;
      
      case "vaiversoest":
        dir = "est";
      break;
      
      case "vaiversoovest":
        dir = "ovest";
      break;
      
      case "fermati":
        dir = "stop";
      break;
      
      case "sparaversonord":
        for(int i=0; i<bf.proiettili.length; i++)
          if(bf.proiettili[i] == null)
          {
            bf.proiettili[i] = new Proiettile(x, y, new PVector(0, -1));
            break;
          }
      break;
      
      case "sparaversosud":
        for(int i=0; i<bf.proiettili.length; i++)
          if(bf.proiettili[i] == null)
          {
            bf.proiettili[i] = new Proiettile(x, y, new PVector(0, 1));
            break;
          }
      break;
      
      case "sparaversoest":
        for(int i=0; i<bf.proiettili.length; i++)
          if(bf.proiettili[i] == null)
          {
            bf.proiettili[i] = new Proiettile(x, y, new PVector(1, 0));
            break;
          }
      break;
      
      case "sparaversoovest":
        for(int i=0; i<bf.proiettili.length; i++)
          if(bf.proiettili[i] == null)
          {
            bf.proiettili[i] = new Proiettile(x, y, new PVector(-1, 0));
            break;
          }
      break;
      
      case "usacerchiodipalle":
      case "usacerchidipalle":
      case "usacercadipalle":
        if(cd_CerchioDiPalle <= 0)
        {
          int deg = 0;
          for(int i=0; i<bf.proiettili.length; i++)
          {
            if(bf.proiettili[i] == null)
            {
              bf.proiettili[i] = new Proiettile(x, y, new PVector(cos(radians(deg)), sin(radians(deg))));
              deg += 10;
              if(deg == 360)
                break;
            }
          }
          cd_CerchioDiPalle = 10;
        }
      break;
    }
  }
}