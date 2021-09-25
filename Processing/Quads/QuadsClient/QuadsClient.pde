import processing.net.*;
import javax.swing.*;
import java.lang.*;

Quad[][] quads;
Client client;

void setup()
{
  size(800, 600);
  //client = new Client(this, JOptionPane.showInputDialog(frame, "Inserisci l'ip del server:", "IP", JOptionPane.INFORMATION_MESSAGE), 10069);
  client = new Client(this, "127.0.0.1", 10069);
  
  int sp = 120;
  int w = 80;
  quads = new Quad[5][5];
  for(int i=0; i<5; i++)
    for(int j=0; j<5; j++)
      quads[j][i] = new Quad(20+(j*sp), 20+(i*sp), w);
  
  if(client.active())
  {
    String res;
    do{
      String s = JOptionPane.showInputDialog(frame, "Inserisci il tuo nickname:", "Nickname", JOptionPane.INFORMATION_MESSAGE);
      if(s == null || s.equals(""))
        exit();
        
      client.write("NAM;" + s);
      do{
        res = client.readString();
      }while(res == null);
    }while(res.equals("_fail"));
    
    do{
      String s;
      do{
        s = JOptionPane.showInputDialog(frame, "0: bianco\n1: rosso\n2: arancione\n3: giallo\n4: verde\n5: blu\n6: viola\nInserisci il numero corrispondente al colore che vorresti:", "Nickname", JOptionPane.INFORMATION_MESSAGE);
        if(s == null || s.equals(""))
          exit();
      }while(Integer.parseInt(s) < 0 || Integer.parseInt(s) > 6);
      
      client.write("COL;" + s);
      do{
        res = client.readString();
      }while(res == null);
      
      if(res.equals("_fail"))
        JOptionPane.showMessageDialog(frame, "Il colore è già stato preso.", "Sorry", JOptionPane.INFORMATION_MESSAGE);
    }while(res.equals("_fail"));
  }
  else
  {
    JOptionPane.showMessageDialog(frame, "Il server è down.", "Sorry", JOptionPane.INFORMATION_MESSAGE);
    exit();
  }
}

void draw()
{
  background(0);
  
  for(int i=0; i<5; i++)
    for(int j=0; j<5; j++)
      quads[j][i].display();
}