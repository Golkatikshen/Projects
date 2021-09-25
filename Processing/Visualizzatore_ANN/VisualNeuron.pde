class VisualNeuron
{
  float x;
  float y;
  float w;
  
  ArrayList<VisualConnection> connections;
  
  
  VisualNeuron(float x_, float y_, float w_)
  {
    connections = new ArrayList();
    
    x = x_;
    y = y_;
    w = w_;
  }

  
  void display()
  {
    strokeWeight(2);
    stroke(255);
    fill(255, 255, 0);
    ellipse(x, y, w, w);
  }
  
  VisualConnection connect(VisualNeuron n)
  {
    connections.add(new VisualConnection(this, n));
    return connections.get(connections.size()-1);
  }
}