class IDEInterface
{
  int N_ROWS = 5000;
  
  Button btn_new;
  Button btn_save;
  Button btn_load;
  Button btn_run;
  Slider slider;
  
  String local_file_name;
  Line[] local_code;
  int index_vis;
  int index_sel;
  boolean focus_code;
  Execution exec;
  
  
  IDEInterface()
  {
    btn_new = new Button(85, 35, 140, 40, "NEW", 4, -3, 0, 255, 0);
    btn_save = new Button(245, 35, 140, 40, "SAVE", 4, -3, 0, 255, 0);
    btn_load = new Button(405, 35, 140, 40, "LOAD", 4, -3, 0, 255, 0);
    btn_run = new Button(1220, 35, 140, 40, "RUN", 4, -3, 0, 255, 0);
    slider = new Slider(round(Width/2-30), 160, 700);
    
    local_file_name = "new.confusion";
    local_code = new Line[N_ROWS];
    for(int i=0; i<N_ROWS; i++)
    {
      local_code[i] = new Line(i);
      local_code[i].updatePuntator();
    }
    local_code[0].sel = true;
    str_exe = "";
    focus_code = true;
    
    index_vis = 0;
    index_sel = 0;
    exec = new Execution("");
    
    my_leading = height/37.5;
  }
  
  void display()
  {
    strokeWeight(1);
    btn_new.display();
    btn_save.display();
    btn_load.display();
    btn_run.display();
    slider.display();
    
    noStroke();
    fill(8);
    rect(rele(10, "h"), rele(130, "v"), rele(34, "h"), height-rele(140, "v"));
    
    stroke(0, 255, 0);
    fill(255);
    noFill();
    textAlign(LEFT);
    textSize(rele(20, "v"));
    
    if(exec.stop_exe)
      strokeWeight(3);
    else
      strokeWeight(2);
    text(local_file_name, rele(20, "h"), rele(120, "v"));
    rect(rele(10, "h"), rele(130, "v"), width/2-rele(10, "h"), height-rele(140, "v"));
    line(rele(10, "h"), rele(95, "v"), width/2, rele(95, "v"));
    line(rele(10, "h"), rele(95, "v"), rele(10, "h"), rele(130, "v"));
    fill(0, 255, 0);
    for(int i=index_vis, count = 0; i<index_vis+30; i++, count++)
      local_code[i].display(round(rele(18, "h")), round(rele(155, "v")+(count*rele(25, "v"))));
    
    fill(255);
    noFill();
    if(!exec.stop_exe)
      strokeWeight(3);
    else
      strokeWeight(2);
    text("EXECUTION", width/2+rele(30, "h"), rele(120, "v"));
    rect(width/2+rele(20, "h"), rele(130, "v"), width/2-rele(30, "h"), height-rele(140, "v"));
    line(width/2+rele(20, "h"), rele(95, "v"), width-rele(10, "h"), rele(95, "v"));
    line(width/2+rele(20, "h"), rele(95, "v"), width/2+rele(20, "h"), rele(130, "v"));
    fill(0, 255, 0);
    textLeading(my_leading);
    text(str_exe, width/2+rele(30, "h"), rele(140, "v"), width/2-rele(40, "h"), height-rele(150, "v"));
  }
  
  
  void run()
  {
    if(exec.stop_exe == false)
    {
      try {
        exec.exe();
      } catch (Exception e) {
        JOptionPane.showMessageDialog(frame, "There is something that doesn't work properly, do you feel confused?", "SUPER FATAL ERROR", JOptionPane.ERROR_MESSAGE);
        exec.stop_exe = true;
      }
    }
      
    if(exec.stop_exe == true)
    {
      btn_run.str = "RUN";
      focus_code = true;
    }

    if(textHeight(str_exe, width/2-round(rele(40, "h"))) > height-round(rele(130, "v")))
    {
      String[] ss = str_exe.split("\n");
      str_exe = "";
      for(int i=1; i<ss.length; i++)
        str_exe += ss[i]+"\n";
    }
  }
  
  
  void ideMousePressed()
  {
    if(btn_run.mouseHover())
    {
      if(exec.stop_exe == true)
      {
        str_exe = "";
        exec.program_index = 0;
        String program = "";
        for(int i=0; i<N_ROWS; i++)
          program += local_code[i].text;
        program = program.replace(" ", "");
        program = program.replace("\n", "");
        exec.program = program + " ";
        exec.stop_exe = false;
        btn_run.str = "STOP";
        focus_code = false;
        millis = millis();
      }
      else
      {
        exec.stop_exe = true;
        millis = millis() - millis;
        str_exe += "\n\n\n------- CONFUSION SYS: program terminated -------\n"+((float)millis/1000)+" - execution time in seconds.";
      }
    }
    
    if(btn_load.mouseHover())
    {
      String file_name = JOptionPane.showInputDialog(frame, "(Don't write .confusion)\nFile name:", "LOAD", JOptionPane.INFORMATION_MESSAGE);
      if(file_name != null && !file_name.equals(""))
      {
        file_name += ".confusion";
        
        File f = new File(dataPath(file_name));
        if(f.exists())
        {
          String[] ss = loadStrings(file_name);
          if(ss.length > N_ROWS)
            JOptionPane.showMessageDialog(frame, "The file has too much rows.", "UNEXPECTED!", JOptionPane.INFORMATION_MESSAGE);
          else
          {
            local_file_name = file_name;
            for(int i=0; i<ss.length; i++)
            {
              local_code[i].text = ss[i];
              local_code[i].updatePuntator();
            }
          }
        }
        else
          JOptionPane.showMessageDialog(frame, "That file doesn't exists.", "RLY", JOptionPane.INFORMATION_MESSAGE);
      }
    }
    
    if(btn_save.mouseHover())
    {
      if(local_file_name.equals("new.confusion"))
        local_file_name = "";
      else
        local_file_name = local_file_name.substring(0, local_file_name.length()-10);
        
      Object obj = JOptionPane.showInputDialog(frame, (Object)"File name:", "SAVE", JOptionPane.INFORMATION_MESSAGE, null, null, (Object)local_file_name);
      String file_name = null;
      if(obj != null)
        file_name = obj.toString();
        
      if(file_name != null)
      {
        if(!file_name.equals(""))
        {
          file_name += ".confusion";
          String[] ss = new String[N_ROWS];
          for(int i=0; i<N_ROWS; i++)
            ss[i] = local_code[i].text;
          saveStrings(dataPath(file_name), ss);
          
          local_file_name = file_name;
        }
      }
    }
    
    if(btn_new.mouseHover())
    {
      int ris = JOptionPane.showConfirmDialog(null, "Are you sure you want to create a new file?", "Be careful!", JOptionPane.YES_NO_OPTION);
      if (ris == JOptionPane.YES_OPTION) 
      {
        for(int i=0; i<N_ROWS; i++)
          local_code[i].text = "";
        index_sel = 0;
        local_file_name = "new.confusion";
      }
    }
  }
  
  
  
  void ideKeyPressed()
  {
    if(focus_code)
    {
      if(key == CODED)
      {
        if(keyCode == LEFT)
          local_code[index_sel].index_string --;
        if(keyCode == RIGHT)
          local_code[index_sel].index_string  ++;
        if(keyCode == UP)
        {
          index_sel --;
          if(index_sel < 0)
            index_sel = 0;
          local_code[index_sel].index_string = local_code[index_sel+1].index_string;
        }
        if(keyCode == DOWN)
        {
          index_sel  ++;
          if(index_sel > N_ROWS-1)
            index_sel = N_ROWS-1;
          local_code[index_sel].index_string = local_code[index_sel-1].index_string;
        }
          
        if(local_code[index_sel].index_string < 0)
          local_code[index_sel].index_string = 0;
        if(local_code[index_sel].index_string > local_code[index_sel].text.length())
          local_code[index_sel].index_string = local_code[index_sel].text.length();
          
        for(int i=0; i<N_ROWS; i++)
          if(i == index_sel)
            local_code[i].sel = true;
          else
            local_code[i].sel = false;
            
        local_code[index_sel].updatePuntator();
      }
      else
      {
        if(key == 10)
        {
          if(index_sel != N_ROWS-1)
          {
            String tmp = local_code[index_sel].text.substring(0, local_code[index_sel].index_string);
            local_code[index_sel].text = local_code[index_sel].text.substring(local_code[index_sel].index_string);
            index_sel  ++;
            
            for(int i=0; i<N_ROWS; i++)
            if(i == index_sel)
              local_code[i].sel = true;
            else
              local_code[i].sel = false;
              
            for(int i=N_ROWS-1; i>=index_sel; i--)
              local_code[i].text = local_code[i-1].text;
            local_code[index_sel-1].text = tmp;
            
            local_code[index_sel].updatePuntator();
          }
        }
        else if(key == 9)
        {
          local_code[index_sel].insert((char)32);
          local_code[index_sel].insert((char)32);
        }
        else if(key != 8)
          local_code[index_sel].insert((char) key);
        else
        {
          if(local_code[index_sel].index_string == 0 && index_sel != 0)
          {
            local_code[index_sel-1].index_string = local_code[index_sel-1].text.length();
            local_code[index_sel-1].text += local_code[index_sel].text;
            for(int i=index_sel; i<N_ROWS-1; i++)
              local_code[i].text = local_code[i+1].text;
            local_code[N_ROWS-1].text = "";
            index_sel --;
            
            for(int i=0; i<N_ROWS; i++)
              if(i == index_sel)
                local_code[i].sel = true;
              else
                local_code[i].sel = false;
                
            local_code[index_sel].updatePuntator();
          }
          else
            local_code[index_sel].cancel();
        }
      }
    }
    else
    {
      if(input_type.equals("char"))
      {
        if(key >= 32 && key <= 126)
        {
          input = (char)key+"";
          str_exe += (char)key;
          input_ready = true;
        }
      }
      
      if(input_type.equals("num"))
      {
        if(key == 10)
        {
          if(input != "")
          {
            str_exe += "\n";
            input_ready = true;
          }
        }
        else if(key != 8)
        {
          if(key >= 48 && key <= 57)
          {
            input += (char)key+"";
            str_exe += (char)key;
          }
        }
        else
        {
          input = input.substring(0, input.length()-1);
          str_exe = str_exe.substring(0, str_exe.length()-1);
        }
      }
    }
  }
  
  
  void ideMouseDragged()
  {
    slider.smouseDragged();
    index_vis = (int)map(slider.y_off, 0, rele(700, "v"), 0, N_ROWS-30);
  }
  
  void ideMouseReleased()
  {
    slider.smouseReleased();
  }
  
  void ideMouseWheel(int v)
  {
    slider.smouseWheel(v);
    index_vis = (int)map(slider.y_off, 0, rele(700, "v"), 0, N_ROWS-30);
  }
}