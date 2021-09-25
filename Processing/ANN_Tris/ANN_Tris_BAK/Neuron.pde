class Neuron
{
  float x;
  float y;
  int id;
  
  ArrayList<Connection> connections;
  float net;
  float out;
  float error;
  
  
  Neuron(float x_, float y_)
  {
    connections = new ArrayList();
    
    x = x_;
    y = y_;
    net = 0;
    out = 0;
    error = 0;
  }
  
  Neuron(float x_, float y_, int id_)
  {
    connections = new ArrayList();
    
    x = x_;
    y = y_;
    net = 0;
    out = 0;
    id = id_;
  }
  
  void display()
  {
    strokeWeight(2);
    stroke(255);
    fill(255, 255, 0);
    ellipse(x, y, 40, 40);
    
    /*fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    text(out, x, y);*/
  }
  
  
  void calcError()
  {
    error = 0;
    
    for(Connection c: connections)
      error += c.w * c.b.error;
  }
  
  Connection connect(Neuron n)
  {
    connections.add(new Connection(this, n));
    return connections.get(connections.size()-1);
  }
  
  void activate()
  {
    out = sigmoid(net, false);
    
    for(Connection c: connections)
      c.transmit(out);
  }
  
  void activateInput()
  {
    for(Connection c: connections)
      c.transmit(out);
  }
  
  void reset()
  {
    net = 0;
    out = 0;
    error = 0;
  }
  
  float sigmoid(float n, boolean der)
  {
    if(der == true)
      return (sigmoid(n, false) * (1 - sigmoid(n, false)));
      
    return (1/(1+exp(-n)));
  }
}