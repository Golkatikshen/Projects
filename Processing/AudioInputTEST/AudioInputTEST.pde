import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput in;

Curve curve;

void setup()
{
  size(512, 512);
  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw()
{
  background(0);
  stroke(255);
  
  text(in.bufferSize(), 10, 15);
  
  for(int i=0; i<in.bufferSize()-1; i++)
  {
    ellipse(256, 256, in.right.get(i)*200, in.left.get(i)*200);
    print(in.right.get(i) + " - ");
  }
  println("------------");
}

/*
import ddf.minim.*;

Minim minim;
AudioInput in;
color white;

void setup()
{
  size(512, 200, P2D);
  white = color(255);
  colorMode(HSB,100);
  minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
  background(0);
}

void draw()
{
  background(0);
  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke((1+in.left.get(i))*50,100,100);
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    stroke(white);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  super.stop();
}*/