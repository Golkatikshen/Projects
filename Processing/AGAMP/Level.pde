class Level
{
  Menu m_ref;
  ToolBox tb;
  ArrayList<Entity> entities;
  ArrayList<EInput> inputs;
  ArrayList<EOutput> outputs;
  
  ArrayList<Connection> connections;
  Connection temp_connection;
  
  String level;
  boolean completato;
  boolean[] completati;
  int index_completati = 0;
  
  String quest;
  Button btn_quest;
  QuestTab quest_tab;
  
  Button btn_back;
  Button btn_run;
  Button btn_stop;
  Button btn_del;
  
  Slider vel_slider;
  
  int distance_point_to_line;
  
  
  Level(Menu _m_ref, String _level, String _quest, int _h_quest)
  {
    m_ref = _m_ref;
    tb = new ToolBox();
    
    entities = new ArrayList();
    inputs = new ArrayList();
    outputs = new ArrayList();
    connections = new ArrayList();
    
    completato = false;
    completati = null;
    
    level = _level;
    quest = _quest;
    quest_tab = new QuestTab(rele(Width-405, "h"), rele(0, "v"), rele(_h_quest, "v"), quest);
    
    btn_quest = new Button(Width-130, 0, 30, 30, "?", 4, -2, 255, 255, 255);
    btn_back = new Button(1152, 875, 80, 35, "BACK", 4, -3);
    btn_run = new Button(1152, 770, 80, 35, "RUN", 4, -3, 0, 255, 0);
    btn_stop = new Button(1152, 710, 80, 35, "STOP", 4, -3, 255, 255, 0);
    btn_del = new Button(1152, 597, 80, 35, "DEL ALL", 4, -2);
    
    vel_slider = new Slider(Width-45, 100, 400, "Vel Run");
    
    distance_point_to_line = (int)rele(30, "h");
  }
  
  
  void run()
  {
    update();
    
    tb.display();
    
    for(Entity e: entities)
      e.display();
      
    for(Connection c: connections)
    {
      if(pointToLine(new PVector(c.a.x, c.a.y), new PVector(c.b.x, c.b.y), new PVector(mouseX, mouseY)) <= distance_point_to_line && tb.index_element == 4 && tb.tab == 0)
        c.display(255, 0, 0);
      else
        c.display(255, 255, 255);
    }
    if(temp_connection != null)
      temp_connection.display(255, 255, 255);
      
    rectMode(CORNER);
    fill(255);
    rect(rele(Width-100, "h"), rele(0, "v"), rele(2, "h"), rele(1000, "v"));
    rect(rele(Width-100, "h"), rele(800, "v"), rele(100, "h"), rele(2, "v"));
    rect(rele(Width-100, "h"), rele(625, "v"), rele(100, "h"), rele(2, "v"));
    label(level, (int)rele(Width-49, "h"), (int)rele(20, "v"), (int)rele(78, "h"), (int)rele(35, "v"), 255, 255, 255, 0, 0, 0);
    if(completato)
    {
      textFont(alt1);
      textSize(rele(22, "v"));
      fill(0, 255, 0);
      text("COMPLETED", rele(Width-48, "h"), rele(50, "v"));
    }
    else
    {
      textFont(del);
      textSize(rele(12, "v"));
      fill(255, 255, 255);
      
      if(completati == null)
        text("to complete: 1", rele(Width-48, "h"), rele(45, "v"));
      else
      {
        int tc = 0;
        for(int i=0; i<completati.length; i++)
          if(completati[i] == false)
            tc ++;
            
        text("to complete: " + tc, rele(Width-48, "h"), rele(45, "v"));
      }
    }
    
        
    btn_del.display();
    btn_stop.display();
    btn_run.display();
    btn_back.display();
    btn_quest.display();
    
    quest_tab.display();
    
    vel_slider.display();
  }
  
  
  void update()
  {
    //controllo se c'e' qualche connessione da eliminare
    for(int i=0; i<connections.size(); i++)
      if(connections.get(i).a.e.deleted || connections.get(i).b.e.deleted)
      {
        connections.get(i).a.c = null;
        connections.get(i).b.c = null;
        connections.remove(i);
      }
        
    
    //movimento e aspetto del bottone quest
    btn_quest.y = quest_tab.y - quest_tab.y_off + quest_tab.h + btn_quest.h/2 + btn_quest.thickness;
    if(quest_tab.active)
      btn_quest.str = "^";
    else
      btn_quest.str = "?";
      
    
    //assegnazione continua dell'id alle entita'
    for(int i=0; i<entities.size(); i++)
      entities.get(i).nid = i;
      
      
    //assegnazione vel di esecuzione alle connessioni
    float vel = (vel_slider.y_off * 100 / vel_slider.len) + 1;
    vel = 100 * vel;
    
    for(Connection c: connections)
      c.vel = vel;
  }
  
  
  //MOUSE FUNCTIONS
  void lmousePressed()
  {
    if(btn_run.mouseHover())
    {
      RUN();
    }
    
    if(btn_stop.mouseHover())
    {
      for(Connection c: connections)
      {
        c.active = false;
        c.active_perc = 0;
      }
      
      if(completati != null)
        completatiSetAllFalse();
    }
    
    if(btn_del.mouseHover())
    {
      for(int i = entities.size()-1; i>=inputs.size()+outputs.size(); i--)
      {
        entities.get(i).deleted = true;
        entities.remove(i);
      }
    }
    
    if(btn_quest.mouseHover())
      quest_tab.active = !quest_tab.active;
      
    if(btn_back.mouseHover())
      m_ref.l = null;
      
    tb.tbmousePressed();
    
    if(mouseButton == LEFT && tb.index_element == 0)
    {
      for(Entity e: entities)
      {
        if(e.mouseHover())
        {
          e.grabbed = true;
          e.grab_point = PVector.sub(new PVector(mouseX, mouseY), new PVector(e.x, e.y));
          break;
        }
      }
    }
    
    if(mouseHover())
      switch(tb.tab)
      {
        case 0:
          switch(tb.index_element)
          {
            case 1:
              if(nearestAnchor(true) != null)
                temp_connection = new Connection(nearestAnchor(true));
            break;
            
            case 2:
              entities.add(new ENumVal(mouseX, mouseY, false));
            break;
            
            case 3:
              entities.add(new ENil(mouseX, mouseY, false));
            break;
            
            case 4:
              for(int i=0; i<entities.size(); i++)
                if(entities.get(i).mouseHover() && entities.get(i).deletable)
                {
                  entities.get(i).deleted = true;
                  entities.remove(i);
                  
                  if(completati != null)
                    completatiSetAllFalse();
                  break;
                }
                
              for(int i=0; i<connections.size(); i++)
                if(pointToLine(new PVector(connections.get(i).a.x, connections.get(i).a.y), new PVector(connections.get(i).b.x, connections.get(i).b.y), new PVector(mouseX, mouseY)) <= distance_point_to_line)
                {
                  connections.get(i).a.c = null;
                  connections.get(i).b.c = null;
                  connections.remove(i);
                  
                  if(completati != null)
                    completatiSetAllFalse();
                  break;
                }
            break;
          }             
        break;
        
        case 1:
          switch(tb.index_element)
          {
            case 1:
              entities.add(new ESum(mouseX, mouseY, false));
            break;
            
            case 2:
              entities.add(new EOpp(mouseX, mouseY, false));
            break;
            
            case 3:
              entities.add(new EMult(mouseX, mouseY, false));
            break;
            
            case 4:
              entities.add(new EDiv(mouseX, mouseY, false));
            break;
            
            case 5:
              entities.add(new ESqrt(mouseX, mouseY, false));
            break;
            
            case 6:
              entities.add(new EMod(mouseX, mouseY, false));
            break;
          }
        break;
        
        case 2:
          switch(tb.index_element)
          {
            case 1:
              entities.add(new ECUgu(mouseX, mouseY, false));
            break;
            
            case 2:
              entities.add(new ECMag(mouseX, mouseY, false));
            break;
            
            case 3:
              entities.add(new ECMin(mouseX, mouseY, false));
            break;
          }
        break;
      }
  }
  
  void lmouseReleased()
  {
    vel_slider.smouseReleased();
    
    
    for(Entity e: entities)
      e.grabbed = false;
      
    if(temp_connection != null)
      if(temp_connection.b != null)
        if(temp_connection.a.e.nid != temp_connection.b.e.nid && !existsConnection(temp_connection))
        {
          temp_connection.a.c = temp_connection;
          temp_connection.b.c = temp_connection;
          connections.add(temp_connection);
        }
          
    temp_connection = null;
  }
  
  void lmouseDragged()
  {
    vel_slider.smouseDragged();
    
    for(Entity e: entities)
    {
      if(e.grabbed)
      {
        e.x = mouseX - (int)e.grab_point.x;
        e.y = mouseY - (int)e.grab_point.y;
      }
    }
    
    
    if(temp_connection != null && nearestAnchor(true) != null) 
    {
      if(temp_connection.a == null)
        temp_connection.a = nearestAnchor(true);
      else if(temp_connection.a.e == nearestAnchor(true).e)
        temp_connection.a = nearestAnchor(true);
    }
    
    if(temp_connection != null && nearestAnchor(false) != null)
      temp_connection.b = nearestAnchor(false);
    
    if(temp_connection != null && nearestAnchor(false) == null && nearestAnchor(true) == null)
      temp_connection.b = null;
    
    if(temp_connection != null)
      if(temp_connection.a != null && temp_connection.b != null)
        if(temp_connection.a.e == temp_connection.b.e)
          temp_connection.b = null;
  }
  
  void lmouseWheel(int v)
  {
    tb.scroll(v);
  }
  
  
  
  void RUN()
  {
    for(Connection c: connections)
    {
      c.active = false;
      c.active_perc = 0;
    }
    
    for(EOutput eo: outputs)
    {
      eo.activated = false;
      eo.val = 0;
    }
    
    for(EInput ei: inputs)
      ei.active(ei.val);
      
    for(Entity e: entities)
      if(notInput(e))
      {
        e.val = 0;
        e.done = false;
      }
  }
  
  
  
  Anchor nearestAnchor(boolean s)
  {
    int i_sel = -1;
    int j_min = -1;
    Anchor na = null;
    
    for(int i=0; i<entities.size(); i++)
      if(entities.get(i).mouseHover())
      {
        i_sel = i;
        float min = 10000000;
        
        for(int j=0; j<entities.get(i).anchors.size(); j++)
        {
          if(((s == true && entities.get(i).anchors.get(j).start == true) || (s == false && entities.get(i).anchors.get(j).finish == true)) && entities.get(i).anchors.get(j).c == null)
          {
            float d = (entities.get(i).anchors.get(j).x - mouseX) * (entities.get(i).anchors.get(j).x - mouseX) + (entities.get(i).anchors.get(j).y - mouseY) * (entities.get(i).anchors.get(j).y - mouseY);
            if(d < min)
            {
              min = d;
              j_min = j;
            }
          }
        }
        
        break;
      }
    
    
    if(i_sel != -1 && j_min != -1)
      na = entities.get(i_sel).anchors.get(j_min);
      
    return na;
  }
  
  
  boolean existsConnection(Connection tmpc)
  {
    for(Connection c: connections)
      if(c.a.e == tmpc.a.e && c.b.e == tmpc.b.e)
        return true;

    return false;
  }
  
  
  boolean notInput(Entity e)
  {
    for(EInput ei: inputs)
      if(e == ei)
        return false;
        
    return true;
  }
  
  
  boolean outputsAttivati()
  {
    for(EOutput o: outputs)
      if(o.activated == false)
        return false;
      
    return true;
  }
  
  
  boolean allCompleted()
  {
    for(boolean b: completati)
      if(b == false)
        return false;
        
    return true;
  }
  
  
  void completatiSetAllFalse()
  {
    for(int i=0; i<completati.length; i++)
      completati[i] = false;
      
    index_completati = 0;
  }
  
  
  boolean mouseHover()
  {
    return (mouseX > 100 && mouseX < rele(Width-100, "h"));
  }
}