import javax.swing.*;
import java.lang.*;

// 0 = pen; 1 = ruler; 2 = compass;

int selected;
int strokeSize;
color lineColor;
String[] tool_name;
ArrayList<CompassLine> compass_lines;
ArrayList<RulerLine> ruler_lines;
ArrayList<PenLine> pen_lines;
CompassLine tmp_compass_line;
RulerLine tmp_ruler_line;
PenLine tmp_pen_line;

int xc = 5, yc = 150, wc = 3, alpha = 100;
float last_aperture;

String local_file_name;


void setup()
{
  size(1500, 900);
  textFont(createFont("Consolas", 15));
  colorMode(HSB, 100);
  noFill();
  compass_lines = new ArrayList();
  ruler_lines = new ArrayList();
  pen_lines = new ArrayList();
  tool_name = new String[] {"Pen", "Ruler", "Compass"};
  
  selected = 2;
  strokeSize = 3;
  lineColor = color(3, 32, 100);
  local_file_name = "new.gking";
  refreshTitle();
}


void draw()
{
  background(0);
  text("[1,2,3] - "+tool_name[selected], 5, 15);
  text("Stroke Size:"+strokeSize, 5, 35);
  text("Z: rem last pen ("+pen_lines.size()+")", 5, 55);
  text("X: rem last ruler ("+ruler_lines.size()+")", 5, 70);
  text("C: rem last compass ("+compass_lines.size()+")", 5, 85);
  text("F: set last aperture", 5, 100);
  text("J: swap ruler vertex", 5, 115);
  text("[P,L] - Save, Load", 5, 130);
  text("[-N,M+] - alpha: "+alpha, 5, 160);
  
  if(tmp_compass_line != null)
    tmp_compass_line.display();
  if(tmp_pen_line != null)
    tmp_pen_line.display();
  if(tmp_ruler_line != null)
    tmp_ruler_line.display();
    
  for(PenLine pl: pen_lines)
    pl.display();
    
  for(CompassLine cl: compass_lines)
    cl.display();
    
  for(RulerLine rl: ruler_lines)
    rl.display();
    
  
  for (int i = 0; i < 100; i++) 
  {
    for (int j = 0; j < 100; j++) 
    {
      stroke(i, j, alpha);
      strokeWeight(1);
      point(i+5, j+170);
    }
  }
  
  stroke(0);
  strokeWeight(1);
  ellipse(xc, yc, wc, wc);
  lineColor = color(xc-5, yc-170, alpha);
}


int off = 3;
void keyPressed()
{
  key = Character.toLowerCase(key);
  
  if(key == 'p')
  {
    if(local_file_name.equals("new.gking"))
      local_file_name = "";
    else
      local_file_name = local_file_name.substring(0, local_file_name.length()-6);
      
    Object obj = JOptionPane.showInputDialog(frame, (Object)"File name:", "SAVE", JOptionPane.INFORMATION_MESSAGE, null, null, (Object)local_file_name);
    String file_name = null;
    if(obj != null)
      file_name = obj.toString();
      
    if(file_name != null)
    {
      if(!file_name.equals(""))
      {
        boolean overwrite = true;
        File f = new File(dataPath(file_name+".gking"));
        if(f.exists())
        {
          if (JOptionPane.showConfirmDialog(null, "That file already exists, do you want to overwrite it?", "DAMN IT", JOptionPane.YES_NO_OPTION) == JOptionPane.NO_OPTION) 
            overwrite = false;
        }
        
        if(overwrite)
        {
          file_name += ".gking";
          String[] ss = new String[pen_lines.size() + ruler_lines.size() + compass_lines.size() + 3];
          ss[0] = String.valueOf(pen_lines.size());
          ss[1] = String.valueOf(ruler_lines.size());
          ss[2] = String.valueOf(compass_lines.size());
          int oi = 3;
          
          for(int i=0; i<pen_lines.size(); i++)
            ss[i+oi] = sHSB(pen_lines.get(i).c)+" "+pen_lines.get(i).s+" "+arrayPVecToString(pen_lines.get(i).points);
          oi += pen_lines.size();
          
          for(int i=0; i<ruler_lines.size(); i++)
            ss[i+oi] = sHSB(ruler_lines.get(i).c)+" "+ruler_lines.get(i).s+" "+ruler_lines.get(i).x1+" "+ruler_lines.get(i).y1+" "+ruler_lines.get(i).x2+" "+ruler_lines.get(i).y2;
          oi += ruler_lines.size();
          
          for(int i=0; i<compass_lines.size(); i++)
            ss[i+oi] = sHSB(compass_lines.get(i).c)+" "+tS(compass_lines.get(i).s)+" "+compass_lines.get(i).x+" "+compass_lines.get(i).y+" "+compass_lines.get(i).w+" "+arrayPVecToString(compass_lines.get(i).points);
          
          saveStrings(dataPath(file_name), ss);
          
          local_file_name = file_name;
          refreshTitle();
        }
      }
    }
  }
  if(key == 'l')
  {
    if(pen_lines.size() + ruler_lines.size() + compass_lines.size() > 0)
      JOptionPane.showMessageDialog(frame, "Warning: if you load a file, the actual one will be overwritten!", "CARE PLZ", JOptionPane.INFORMATION_MESSAGE);
    
    String file_name = JOptionPane.showInputDialog(frame, "(Don't write .gking)\nFile name:", "LOAD", JOptionPane.INFORMATION_MESSAGE);
    if(file_name != null && !file_name.equals(""))
    {
      file_name += ".gking";
      File f = new File(dataPath(file_name));
      if(f.exists())
      {
        pen_lines.clear();
        ruler_lines.clear();
        compass_lines.clear();
        tmp_pen_line = null;
        tmp_ruler_line = null;
        tmp_compass_line = null;
        
        try
        {
          String[] ss = loadStrings(file_name);
          int iP = Integer.parseInt(ss[0]);
          int iR = Integer.parseInt(ss[1]);
          int iC = Integer.parseInt(ss[2]);
          int oi = 3;
          
          for(int i=0; i<iP; i++)
          {
            //ss[i+oi] = sHSB(pen_lines.get(i).c)+" "+pen_lines.get(i).s+" "+arrayPVecToString(pen_lines.get(i).points);
            String[] pen_infos = ss[i+oi].split(" ");
            String[] ecolor = pen_infos[0].split(",");
            String[] points = pen_infos[2].split(";");
            String[] coords = points[0].split(",");
            pen_lines.add(new PenLine(tF(coords[0]), tF(coords[1]), tF(pen_infos[1]), color(tF(ecolor[0]), tF(ecolor[1]), tF(ecolor[2]))));
            for(int j=1; j<points.length; j++)
            {
              coords = points[j].split(",");
              pen_lines.get(i).points.add(new PVector(tF(coords[0]), tF(coords[1])));
            }
          }
          oi += iP;
          
          for(int i=0; i<iR; i++)
          {
            //ss[i+oi] = sHSB(ruler_lines.get(i).c)+" "+ruler_lines.get(i).s+" "+ruler_lines.get(i).x1+" "+ruler_lines.get(i).y1+" "+ruler_lines.get(i).x2+" "+ruler_lines.get(i).y2;
            String[] ruler_infos = ss[i+oi].split(" ");
            String[] ecolor = ruler_infos[0].split(",");
            ruler_lines.add(new RulerLine(tF(ruler_infos[2]), tF(ruler_infos[3]), tF(ruler_infos[1]), color(tF(ecolor[0]), tF(ecolor[1]), tF(ecolor[2]))));
            ruler_lines.get(i).x2 = tF(ruler_infos[4]);
            ruler_lines.get(i).y2 = tF(ruler_infos[5]);
          }
          oi += iR;
          
          for(int i=0; i<iC; i++)
          {
            //ss[i+oi] = sHSB(compass_lines.get(i).c)+" "+tS(compass_lines.get(i).s)+" "+compass_lines.get(i).x+" "+compass_lines.get(i).y+" "+compass_lines.get(i).w+" "+arrayPVecToString(compass_lines.get(i).points);
            String[] compass_infos = ss[i+oi].split(" ");
            String[] ecolor = compass_infos[0].split(",");
            String[] points = compass_infos[5].split(";");
            String[] coords;
            compass_lines.add(new CompassLine(tF(compass_infos[2]), tF(compass_infos[3]), tF(compass_infos[1]), color(tF(ecolor[0]), tF(ecolor[1]), tF(ecolor[2]))));
            compass_lines.get(i).w = tF(compass_infos[4]);
            for(int j=0; j<points.length; j++)
            {
              coords = points[j].split(",");
              compass_lines.get(i).points.add(new PVector(tF(coords[0]), tF(coords[1])));
            }
          }
        
          local_file_name = file_name;
          refreshTitle();
        } 
        catch (Exception e)
        {
          JOptionPane.showMessageDialog(frame, "File CORRUPTED! (or something gone wrong, sry)", "NOOO!!", JOptionPane.INFORMATION_MESSAGE);
        }
      }
      else
        JOptionPane.showMessageDialog(frame, "That file doesn't exists.", "RLY", JOptionPane.INFORMATION_MESSAGE);
    }
  }
  
  if(key == 'm')
    alpha += 5;
  if(key == 'n')
    alpha -= 5;
  if(alpha < 0)
    alpha = 0;
  if(alpha > 100)
    alpha = 100;
    
  
  if(key == 'f' && tmp_compass_line != null && !tmp_compass_line.pointed)
  {
    tmp_compass_line.w = last_aperture;
    tmp_compass_line.aperture_set = true;
  }
  if(key == 'j' && tmp_ruler_line != null)
  {
    tmp_ruler_line.x1 = tmp_ruler_line.x2;
    tmp_ruler_line.y1 = tmp_ruler_line.y2;
  }
  
  if(key == 'w')
    yc -= off;
  if(key == 'a')
    xc -= off;
  if(key == 's')
    yc += off;
  if(key == 'd')
    xc += off;
  if(xc < 5)
    xc = 5;
  if(yc < 170)
    yc = 170;
  if(xc > 104)
    xc = 104;
  if(yc > 269)
    yc = 269;
  
  if(tmp_pen_line == null && tmp_ruler_line == null && tmp_compass_line == null)
  {
    if(key == '1')
      selected = 0;
    if(key == '2')
      selected = 1;
    if(key == '3')
      selected = 2;
  }
    
  if(key == 'z' && pen_lines.size() != 0)
    pen_lines.remove(pen_lines.size()-1);
  if(key == 'x' && ruler_lines.size() != 0)
    ruler_lines.remove(ruler_lines.size()-1);
  if(key == 'c' && compass_lines.size() != 0)
    compass_lines.remove(compass_lines.size()-1);
}

void mouseReleased()
{
  if(selected == 0 && tmp_pen_line != null)
  {
    pen_lines.add(tmp_pen_line);
    tmp_pen_line = null;
  }
  
  if(selected == 1 && tmp_ruler_line != null)
  {
    ruler_lines.add(tmp_ruler_line);
    tmp_ruler_line = null;
  }
  
  if(selected == 2  && tmp_compass_line != null && tmp_compass_line.pointed)
  {
    compass_lines.add(tmp_compass_line);
    tmp_compass_line = null;
  }
}

void mousePressed()
{
  if(mouseButton == RIGHT)
  {
    if(selected == 0)
      tmp_pen_line = null;
      
    if(selected == 1)
      tmp_ruler_line = null;
      
    if(selected == 2)
      tmp_compass_line = null;
  }
  
  if(mouseButton == LEFT)
  {
    if(selected == 0)
      if(tmp_pen_line == null)
        tmp_pen_line = new PenLine(mouseX, mouseY, strokeSize, lineColor);
        
    if(selected == 1)
      if(tmp_ruler_line == null)
        tmp_ruler_line = new RulerLine(mouseX, mouseY, strokeSize, lineColor);
      
    if(selected == 2)
    {
      if(tmp_compass_line == null)
        tmp_compass_line = new CompassLine(mouseX, mouseY, strokeSize, lineColor);
      else
      {
        float tx = tmp_compass_line.x;
        float ty = tmp_compass_line.y;
        
        tmp_compass_line.pointed = true;
        if(!tmp_compass_line.aperture_set)
        {
          tmp_compass_line.w = sqrt((tx-mouseX)*(tx-mouseX)+(ty-mouseY)*(ty-mouseY));
          last_aperture = tmp_compass_line.w;
          tmp_compass_line.points.add(new PVector(mouseX, mouseY));
        }
      }
    }
  }
}

void mouseDragged()
{
  if(selected == 0)
  {
    if(tmp_pen_line != null)
    {
      tmp_pen_line.points.add(new PVector(mouseX, mouseY));
    }
  }
  
  if(selected == 1)
  {
    if(tmp_ruler_line != null)
    {
      tmp_ruler_line.x2 = mouseX;
      tmp_ruler_line.y2 = mouseY;
    }
  }
    
  if(selected == 2)
  {
    if(tmp_compass_line != null)
    {
      if(tmp_compass_line.pointed)
      {  
        float w = tmp_compass_line.w;
        float tx = tmp_compass_line.x;
        float ty = tmp_compass_line.y;
          
        PVector point = new PVector(mouseX, mouseY);
        point = point.sub(new PVector(tx, ty));
        point = point.normalize();
        point = point.mult(w);
        tmp_compass_line.points.add(point.add(new PVector(tx, ty)));
      }
    }
  }
}

void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  strokeSize += (-1)*e;
  
  if(strokeSize < 1)
    strokeSize = 1;
}


//FUNZIONI UTILITY
float tF(String s)
{
  return Float.parseFloat(s);
}

void refreshTitle()
{
  surface.setTitle("Geomety King - by Alessandro Morina  |  " + local_file_name);
}

String arrayPVecToString(ArrayList<PVector> vecs)
{
  String str = "";
  for(int i=0; i<vecs.size(); i++)
    str += String.valueOf(vecs.get(i).x)+","+String.valueOf(vecs.get(i).y)+";";
  str = str.substring(0, str.length()-1);
  return str;
}

String tS(Object obj)
{
  return String.valueOf(obj);
}

String sHSB(color col)
{
  return (String.valueOf(hue(col))+","+String.valueOf(saturation(col))+","+String.valueOf(brightness(col)));
}

float angleBetween2Points(PVector centerPt, PVector targetPt)
{
    double theta = Math.atan2(targetPt.y - centerPt.y, targetPt.x - centerPt.x);

    theta += Math.PI/2.0;

    double angle = Math.toDegrees(theta);

    if (angle < 0) {
        angle += 360;
    }

    return radians((float)angle);
}