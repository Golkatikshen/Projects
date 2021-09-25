class Menu
{
  MenuLevels menu_levels;
  ArrayList<Level> levels;
  Level l;

  Button btn_levels;
  Button btn_readme;
  Button btn_exit;
  Button btn_back;
  Button btn_conf;
  
  ConfigPane configp;
  int screen;
  
  String version;

  Menu()
  {
    version = "Alpha 0.01";
    
    menu_levels = new MenuLevels((int)Width/2, 140);
    levels = new ArrayList();
    loadLevels();
    l = null;
    
    configp = new ConfigPane(Width, 0);
    
    btn_levels = new Button(Width/2, Height/2-60, 450, 100, "LEVELS", 10, -8);
    btn_readme = new Button(Width/2, Height/2-60+140, 450, 100, "README", 10, -8);
    btn_exit = new Button(Width/2, Height/2-60+280, 450, 100, "EXIT", 10, -8);
    btn_back = new Button(130, Height-42, 225, 50, "BACK", 6, -4);
    btn_conf = new Button(Width-60, 24, 100, 25, "CONF", 6, -3, 230, 140, 30);
  }
  
  void display()
  { 
    bgm2.display();
    
    /*fill(0, 255, 0);
    textSize(12);
    textAlign(LEFT);
    text("FPS: " + (int)frameRate, 5, 15);*/
  
    if(l != null)
    {
      l.run();
      
      for(int i=0; i<menu_levels.elements.size(); i++)
        if(l == levels.get(i) && l.completato)
          menu_levels.elements.get(i).completed = true;
    }
    else
      switch(screen)
      {
        case 0:
          textAlign(CENTER, CENTER);
          textFont(digits);
          textSize(rele(80, "v"));
          String titl = "A Game about\nMath and Programming";
          fill(255, 0 ,0);
          text(titl, rele(Width/2-2, "h"), rele(130-2, "v"));
          fill(255);
          text(titl, rele(Width/2, "h"), rele(130, "v"));
          
          
          textAlign(LEFT, BOTTOM);
          textSize(rele(10, "v"));
          fill(255);
          text("by Alessandro Morina", rele(5, "h"), rele(Height-5, "v"));
          
          textAlign(RIGHT, BOTTOM);
          fill(255);
          text("Version: " + version, rele(Width-5, "h"), rele(Height-5, "v"));
          
          
          btn_levels.display();
          btn_readme.display();
          btn_exit.display();
          
          configp.display();
          btn_conf.x = configp.x - configp.x_off - btn_conf.w + rele(40 , "h");
          if(!configp.active)
            btn_conf.str = ">";
          else
            btn_conf.str = "CONF";
          btn_conf.display();
        break;
        
        case 1:
          menu_levels.display();
          btn_back.display();
        break;
        
        case 2:
          text_readme();
          btn_back.display();
        break;
      }
  }
  
  
  
  void mmousePressed()
  {
    if(l != null)
      l.lmousePressed();
    else
    {
      if(screen == 0)
      {
        if(btn_levels.mouseHover())
          screen = 1;
        
        if(btn_readme.mouseHover())
          screen = 2;
          
        if(btn_exit.mouseHover())
          exit();
          
        if(btn_conf.mouseHover())
          configp.active = !configp.active;
        configp.cpmousePressed();
      }
      
      if(screen == 1)
        for(int i=0; i<menu_levels.elements.size(); i++)
          if(menu_levels.elements.get(i).btn_start.mouseHover())
            l = levels.get(i);
      
      if(btn_back.mouseHover())
        screen = 0;
    }
  }
  
  
  void mmouseReleased()
  {
    if(l != null)
      l.lmouseReleased();
      
    if(screen == 1)
      menu_levels.mlmouseReleased();
  }
  
  
  void mmouseDragged()
  {
    if(l != null)
      l.lmouseDragged();
      
    if(screen == 1)
      menu_levels.mlmouseDragged();
  }
  
  
  void mmouseWheel(MouseEvent event)
  {
    int e = event.getCount();
    e *= -1;
    
    
    if(screen == 1)
      menu_levels.scroll(e);
    
    if(l != null)
      l.lmouseWheel(e);
  }
  
  
  
  
  void text_readme()
  {
    String rdm = "Hi, I am the developer.\n\nI am glad you are playing my game, although I do not consider it a game, it is a visual programming language editor.\n\nThere are some levels out there who could pass for basic programming problems but that will not be so easy to solve because there are no logical operators and limited comparison operators.\n\nTime is the key.\n\nNow some important rules and facts about the editor:\n"+
                 "- ENTITY: is everything in the editor that can be connected by a LINK.\n"+
                 "- LINK: is used to transmit data from Entity to Entity (the Link must charge some time, when it has done, the data is transmitted).\n"+
                 "- NUM: is an Entity that stores the last values transmitted.\n"+
                 "- NIL: is an Entity that transmits a value that reset some entities (MULT, DIV, MOD).\n"+
                 "- OPP, SQRT: these entities apply a rule at the data transmitted.\n"+
                 "- SUM, MULT, DIV, MOD: these entities apply a rule between the data they have inside and the data transmitted.\n"+
                 "- =, >, <: are the most basic comparison operators, the comparison always refers to zero.\n"+
                 "- If you try to calculate Indeterminate Form, will be created a NaN (Not a Number) value.\n"+
                 "- Every time you make a Level Run for the [n]th time that is not the first one, the values of the [n-1]th time will be deleted.\n"+
                 "- Some levels have to Run for a while to be completed (not more than 10 times, if it doesn't complete, it means that the OUTPUTS are wrong).\n\n"+
                 "I suggest you to experiment a lot with the editor to understand as good as possible the mechanics.\nHave fun.";
    
    rectMode(CORNER);
    textAlign(TOP, LEFT);
    
    fill(255);
    textFont(digits);
    textSize(rele(20, "h"));
    text(rdm, 15, 15, width-30, height-rele(150, "v"));
  }
  
  
  
  
  void loadLevels()
  {
    levels.add(new Level001(this));
    levels.add(new Level002(this));
    levels.add(new Level003(this));
    levels.add(new Level004(this));
    levels.add(new Level005(this));
    levels.add(new Level006(this));
    levels.add(new Level007(this));
    levels.add(new Level008(this));
    levels.add(new Level009(this));
    levels.add(new Level010(this));
    levels.add(new Level011(this));
    levels.add(new Level012(this));
    levels.add(new Level013(this));
    levels.add(new Level014(this));
    levels.add(new Level015(this));
    levels.add(new Level016(this));
    levels.add(new Level017(this));
    levels.add(new Level018(this));
    levels.add(new Level019(this));
    levels.add(new Level020(this));
    levels.add(new Level021(this));
    levels.add(new Level022(this));
  }
}