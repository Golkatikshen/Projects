class ConfigPane
{
  float x;
  float y;
  float w;
  float x_off;
  
  boolean active;
  
  Button btn_res1;
  Button btn_res2;
  Button btn_res3;
  Button btn_res4;
  Button btn_fs;
  
  Button btn_bgc;
  
  
  ConfigPane(int _x, int _y)
  {
    x = rele(_x, "h");
    y = rele(_y, "v");
    w = rele(400, "h");
    x_off = 0;
    
    active = true;
    
    btn_res1 = new Button(x-x_off + w/2, 70, 180, 30, "800 x 600", 4, -3, 230, 140, 30);
    btn_res2 = new Button(x-x_off + w/2, 110, 180, 30, "1200 x 900", 4, -3, 230, 140, 30);
    btn_res3 = new Button(x-x_off + w/2, 150, 180, 30, "1366 x 768", 4, -3, 230, 140, 30);
    btn_res4 = new Button(x-x_off + w/2, 190, 180, 30, "3840 x 2160", 4, -3, 230, 140, 30);
    btn_fs   = new Button(x-x_off + w/2, 250, 180, 30, "FULLSCREEN", 4, -3, 230, 140, 30);
    btn_bgc = new Button(x-x_off + w/2, 325, 260, 30, "BACKGROUND COMPLEXITY: " + bg_complexity, 4, -2, 230, 140, 30);
  }
  
  void display()
  {
    if(active)
    {
      x_off -= rele(8, "v")*(60/frameRate);
      if(x_off < 0)
        x_off = 0;
    }
    else
    {
      x_off += rele(8, "v")*(60/frameRate);
      if(x_off > w)
        x_off = w;
    }
    
    rectMode(CORNER);
    
    fill(230, 140, 30);
    rect(x-x_off, y, w, rele(360, "v"));
    
    fill(0);
    rect(x+rele(4, "v")-x_off, y+rele(4, "v"), w-rele(8, "v"), rele(360, "v")-rele(8, "v"));
    
    
    textAlign(CENTER, CENTER);
    fill(230, 140, 30);
    textFont(digits);
    textSize(rele(35, "v"));
    text("Resolution", x-x_off + w/2, rele(25, "v"));
    
    btn_res1.x = x-x_off + w/2;
    if(width == 800 && height == 600 && !fullscreen)
      btn_res1.str = "-> 800 x 600";
    else
      btn_res1.str = "800 x 600";
    btn_res1.display();
      
    btn_res2.x = x-x_off + w/2;
    if(width == 1200 && height == 900 && !fullscreen)
      btn_res2.str = "-> 1200 x 900";
    else
      btn_res2.str = "1200 x 900";
    btn_res2.display();
    
    btn_res3.x = x-x_off + w/2;
    if(width == 1366 && height == 768 && !fullscreen)
      btn_res3.str = "-> 1366 x 768";
    else
      btn_res3.str = "1366 x 768";
    btn_res3.display();
    
    btn_res4.x = x-x_off + w/2;
    if(width == 3840 && height == 2160 && !fullscreen)
      btn_res4.str = "-> 3840 x 2160";
    else
      btn_res4.str = "3840 x 2160";
    btn_res4.display();
    
    btn_fs.x = x-x_off + w/2;
    if(fullscreen)
      btn_fs.str = "-> FULLSCREEN";
    else
      btn_fs.str = "FULLSCREEN";
    btn_fs.display();
    
    btn_bgc.x = x-x_off + w/2;
    btn_bgc.display();
  }
  
  
  void cpmousePressed()
  {
    if(btn_res1.mouseHover())
    {
      String[] strs = new String[] {"false", "800", "600", String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
      exit();
    }
    
    if(btn_res2.mouseHover())
    {
      String[] strs = new String[] {"false", "1200", "900", String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
      exit();
    }
    
    if(btn_res3.mouseHover())
    {
      String[] strs = new String[] {"false", "1366", "768", String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
      exit();
    }
    
    if(btn_res4.mouseHover())
    {
      String[] strs = new String[] {"false", "3840", "2160", String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
      exit();
    }
    
    if(btn_fs.mouseHover())
    {
      String[] strs = new String[] {String.valueOf(!fullscreen), String.valueOf(width), String.valueOf(height), String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
      exit();
    }
    
    if(btn_bgc.mouseHover())
    {
      bg_complexity ++;
      if(bg_complexity == 3)
       bg_complexity = 0;
       
      btn_bgc.str = "BACKGROUND COMPLEXITY: " + bg_complexity;
      
      String[] strs = new String[] {String.valueOf(fullscreen), String.valueOf(width), String.valueOf(height), String.valueOf(bg_complexity)};
      saveStrings("data/resolution.res", strs);
    }
  }
}