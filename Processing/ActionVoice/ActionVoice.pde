import javax.swing.*;
import java.lang.*;
import muthesius.net.*;
import org.webbitserver.*;

WebSocketP5 socket;

Battlefield bf;
int previousTime, currentTime;
double deltaTime;
float tempo = 0;


void setup() 
{
  size(1000, 850);
  textFont(createFont("Consolas", 25));
  bf = new Battlefield(50);
  socket = new WebSocketP5(this,8080);
}

void draw()
{
  background(255);
  
  fill(0);
  textAlign(LEFT);
  textSize(15);
  text("FPS: " + (int)frameRate, 5, 20);
  text("Time Survived: " + (int)tempo, 5, 36);
  text("Zombies Killed: " + bf.z_kill, 5, 52);
  text("<dev> n zombies: " + bf.nZombies(), 5, 68);
  
  
  displaySkillz();
  
  
  //delta time;
  previousTime = currentTime;
  currentTime = millis();
  deltaTime = (currentTime - previousTime) * 0.001d;
  
  //tempo agg;
  if(bf.connected)
    tempo += deltaTime;
  
  //display;
  if(bf.connected)
    bf.update();
  bf.display();
}

void stop()
{
  socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg)
{
  println("a: " + msg);
  bf.player.elaboraMessaggio(msg, bf);
}

void websocketOnOpen(WebSocketConnection con)
{
  bf.connected = true;
  println("A client joined");
}

void websocketOnClosed(WebSocketConnection con)
{
  println("A client left");
}


void displaySkillz()
{
  if(bf.player.cd_CerchioDiPalle > 0)
  {
    fill(255, 0, 0);
    text("Cerchio di Palle: CD " + (int)bf.player.cd_CerchioDiPalle, 5, height-10);
  }
  else
  {
    fill(0, 0, 255);
    text("Cerchio di Palle: Ready!", 5, height-10);
  }
}