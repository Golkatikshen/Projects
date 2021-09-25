class VisualConnection
{
  VisualNeuron a;
  VisualNeuron b;
  
  float w;
  
  
  VisualConnection(VisualNeuron a_, VisualNeuron b_)
  {
    a = a_;
    b = b_;
    w = random(-1, 1);
  }
  
  void display()
  {
    if(w < 0)
      stroke(0, 0, 255);
    else if(w > 0)
      stroke(255, 0, 0);
    else
      stroke(0, 0, 0);
    
    strokeWeight(0.4*constrain(abs(w), 0.001, 35));
    
    line(a.x, a.y, b.x, b.y);
  }
}