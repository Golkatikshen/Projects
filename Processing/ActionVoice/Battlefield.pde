class Battlefield
{
  int w;
  boolean connected;
  float timer_spawn, off_timer;
  int z_kill;
  
  Player player;
  Zombie[] zombies;
  
  Proiettile[] proiettili;
  
  
  Battlefield(int _w)
  {
    w = _w;
    connected = false;
    timer_spawn = 0;
    off_timer = 6;
    z_kill = 0;
    
    player = new Player(width/2, height/2, w, 50);
    zombies = new Zombie[100];
    proiettili = new Proiettile[40];
  }
  
  void update()
  {
    //update zombie spawn
    timer_spawn -= deltaTime;
    if(timer_spawn <= 0)
    {
      timer_spawn = off_timer;
      off_timer -= 0.1;
      for(int i=0; i<zombies.length; i++)
      {
        if(zombies[i] == null)
        {
          zombies[i] = new Zombie();
          break;
        }
      }
    }
    
    //update objects
    if(player.update(zombies))
    {
      JOptionPane.showMessageDialog(frame, "Score: " + ((10 * (int)tempo)+(30 * z_kill)), "SKILLED!", JOptionPane.INFORMATION_MESSAGE);
      player = new Player(width/2, height/2, w, 50);
      
      for(int i=0; i<zombies.length; i++)
        zombies[i] = null;
        
      tempo = 0;
      timer_spawn = 0;
      off_timer = 6;
      z_kill = 0;
    }
    
    for(int i=0; i<zombies.length; i++)
    {
      if(zombies[i] != null)
      {
        if(!zombies[i].dead)
          zombies[i].update(player);
        else
        {
          z_kill ++;
          zombies[i] = null;
        }
      }
    }
  }
  
  void display()
  {
    /*stroke(128);
    for(int i=1; i<width/w; i++)
    {
      line(i*w, 0, i*w, height);
      line(0, i*w, width, i*w);
    }*/
    
    fill(100);
    textAlign(RIGHT);
    textSize(15);
    for(int i=0; i<10; i++)
      text(player.cmds[i], width-10, 20+(20*i));
    
    
    
    for(int i=0; i<proiettili.length; i++)
      if(proiettili[i] != null)
        if(proiettili[i].run(zombies))
          proiettili[i] = null;
          
    
    player.display();
    
    for(Zombie z: zombies)
    {
      if(z != null)
        z.display();
    } 
  }
  
  int nZombies()
  {
    int c = 0;
    for(int i=0; i<zombies.length; i++)
      if(zombies[i] != null)
        c++;
        
    return c;
  }
}