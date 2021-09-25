import muthesius.net.*;
import org.webbitserver.*;

WebSocketP5 socket;

boolean onR, onG, onB, provocazione, insulto;
int a = 0;

void setup() 
{
  size(900, 450);
  textFont(createFont("Consolas", 25));
  socket = new WebSocketP5(this, 8080);
}

void draw()
{
  background(0);
  
  stroke(255, 0, 0);
  if(onR)
    fill(255, 0, 0);
  else
    noFill();
  rect(100, 100, 200, 200);
  
  stroke(0, 255, 0);
  if(onG)
    fill(0, 255, 0);
  else
    noFill();
  rect(350, 100, 200, 200);
  
  stroke(0, 0, 255);
  if(onB)
    fill(0, 0, 255);
  else
    noFill();
  rect(600, 100, 200, 200);
  
  fill(255);
  if(insulto)
    text("Ma vaffanculo va!", 10, 425);
  else if(provocazione)
    text("Non vedi che ci sono solo i colori rosso, verde e blu? Coglione!", 10, 425);

  text(a, 5, 20);
  a = (a < 200) ? a+1 : 0;
}

void stop()
{
  socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg)
{
  println(msg);
  
  msg = msg.replace(" ", "");
  if(msg.equals("accenditutti"))
  {
    onR = true;
    onG = true;
    onB = true;
  }
  else if(msg.equals("spegnitutti"))
  {
    onR = false;
    onG = false;
    onB = false;
  }
  else if(msg.equals("accendiilrosso"))
    onR = true;
  else if(msg.equals("accendiilverde"))
    onG = true;
  else if(msg.equals("accendiilblu"))
    onB = true; 
  else if(msg.equals("spegniilrosso"))
    onR = false;
  else if(msg.equals("spegniilverde"))
    onG = false;
  else if(msg.equals("spegniilblu"))
    onB = false;
  else if(msg.substring(0, 8).equals("spegniil") || msg.substring(0, 9).equals("accendiil"))
    provocazione = true;
  else if(provocazione && (msg.equals("simastaicalmo") || msg.equals("sìmastaicalmo")))
    insulto = true;
}

void websocketOnOpen(WebSocketConnection con)
{
  println("A client joined");
}

void websocketOnClosed(WebSocketConnection con)
{
  println("A client left");
}