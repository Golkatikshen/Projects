class VisualRNA
{
  float x;
  float y;
  float xoff;
  float yoff;

  int n_neurons;
  int n_inputs;
  int n_per_hidden[];
  int n_outputs;
  float n_w;
  
  VisualNeuron[] input_neurons;
  VisualNeuron[][] hidden_neurons;
  VisualNeuron[] output_neurons;
  ArrayList<VisualConnection> connections;
  ArrayList<VisualNeuron> neurons;
  
  
  VisualRNA(String name)
  {
    n_w = 60;
    annLoad(name);
  }
  
  void display()
  {
    for(VisualConnection c: connections)
      c.display();
    for(VisualNeuron n: input_neurons)
      n.display();
    for(VisualNeuron[] hn: hidden_neurons)
      for(VisualNeuron n: hn)
        n.display();
    for(VisualNeuron n: output_neurons)
      n.display();
  }
  
  
  void adjust()
  {
    int max = 0;
    int i_max_hn = 0;
    
    for(int i=0; i<n_per_hidden.length; i++)
    {
      if(n_per_hidden[i] > max)
      {
        max = n_per_hidden[i];
        i_max_hn = i;
      }
    }
    
    if(n_inputs > n_per_hidden[i_max_hn])
    {
      if(n_inputs > n_outputs)
      {
        setNeuronsSize((height/n_inputs)-5);
        do{
          reinitialize(0, 1);
        }while(input_neurons[0].y - input_neurons[0].w > 0);
        reinitialize(0, -1);
      }
      else
      {
        setNeuronsSize((height/n_outputs)-5);
        do{
          reinitialize(0, 1);
        }while(output_neurons[0].y - output_neurons[0].w > 0);
        reinitialize(0, -1);
      }
    }
    else
    {
      if(n_per_hidden[i_max_hn] > n_outputs)
      {
        setNeuronsSize((height/n_per_hidden[i_max_hn])-5);
        do{
          reinitialize(0, 1);
        }while(hidden_neurons[i_max_hn][0].y - hidden_neurons[i_max_hn][0].w > 0);
        reinitialize(0, -1);
      }
      else
      {
        setNeuronsSize((height/n_outputs)-5);
        do{
          reinitialize(0, 1);
        }while(output_neurons[0].y - output_neurons[0].w > 0);
        reinitialize(0, -1);
      }
    }
    
    do{
      reinitialize(1, 0);
    }while(input_neurons[0].x - input_neurons[0].w > 0);
    reinitialize(-10, 0);
  }
  
  
  void reinitialize(int _xoff, int _yoff)
  {
    xoff += _xoff;
    yoff += _yoff;
    
    initialize(x, y, n_inputs, n_per_hidden, n_outputs, xoff, yoff);
  }
  
  
  void initialize(float x_, float y_, int n_inputs_, int[] n_per_hidden_, int n_outputs_, float _xoff, float _yoff)
  {
    //inizializzazione
    x = x_;
    y = y_;
    
    n_neurons = 0;
    n_inputs = n_inputs_;
    n_per_hidden = n_per_hidden_;
    n_outputs = n_outputs_;
    
    input_neurons = new VisualNeuron[n_inputs];
    hidden_neurons = new VisualNeuron[n_per_hidden.length][];
    output_neurons = new VisualNeuron[n_outputs];
    connections = new ArrayList();
    neurons = new ArrayList();
        
    
    //generazione neuroni
    xoff = _xoff;
    yoff = _yoff;
    float[] ssx = retSpaces(n_per_hidden.length + 2, xoff);
    int i_ssx = 0;
    
    //-generazioni neuroni di input
    float[] ss = retSpaces(n_inputs, yoff);
    for(int i=0; i<n_inputs; i++)
    {
      input_neurons[i] = new VisualNeuron(0+x+ssx[i_ssx], 0+y+ss[i], i);
      n_neurons++;
    }
    i_ssx++;
    
    //-generazioni neuroni nascosti
    for(int i=0; i<n_per_hidden.length; i++)
    {
      hidden_neurons[i] = new VisualNeuron[n_per_hidden[i]];
      ss = retSpaces(n_per_hidden[i], yoff);
      for(int j=0; j<n_per_hidden[i]; j++)
      {
        hidden_neurons[i][j] = new VisualNeuron(0+x+ssx[i_ssx], 0+y+ss[j], i);
        n_neurons++;
      }
      i_ssx++;
    }
    
    //-generazione neuroni di output
    ss = retSpaces(n_outputs, yoff);
    for(int i=0; i<n_outputs; i++)
    {
      output_neurons[i] = new VisualNeuron(0+x+ssx[i_ssx], 0+y+ss[i], i);
      n_neurons++;
    }
    
    
    //generazione connessioni
    for(int i=0; i<n_inputs; i++)
    {
      for(int j=0; j<hidden_neurons[0].length; j++)
        connections.add(input_neurons[i].connect(hidden_neurons[0][j]));
    }
    
    for(int i=0; i<n_per_hidden.length; i++)
    {
      if(i+1 == n_per_hidden.length)
      {
        for(int j=0; j<n_per_hidden[i]; j++)
          for(int k=0; k<output_neurons.length; k++)
            connections.add(hidden_neurons[i][j].connect(output_neurons[k]));
      }
      else
      {
        for(int j=0; j<n_per_hidden[i]; j++)
          for(int k=0; k<n_per_hidden[i+1]; k++)
            connections.add(hidden_neurons[i][j].connect(hidden_neurons[i+1][k]));
      }
    }
    
    
    for(VisualNeuron n: input_neurons)
      neurons.add(n);
    for(VisualNeuron[] hn: hidden_neurons)
      for(VisualNeuron n: hn)
        neurons.add(n);
    for(VisualNeuron n: output_neurons)
      neurons.add(n);
      
      
    for(VisualNeuron n: neurons)
     n.w = n_w;
  }
  
  
  
  void changeNeuronsSize(int siz)
  {
    n_w = neurons.get(0).w += siz;
    for(VisualNeuron n: neurons)
      n.w = n_w;
  }
  
  void setNeuronsSize(int siz)
  {
    n_w = siz;
    for(VisualNeuron n: neurons)
      n.w = n_w;
  }
  
  void addOff(int xof, int yof)
  {
    for(VisualNeuron n: neurons)
    {
      n.x += xof;
      n.y += yof;
    }
  }
  
  
  
  
  //funzione di utility che mi permette di assegnare ai neuroni una posizione ordinata
  float[] retSpaces(int n, float off)
  {
    float[] ss = new float[n];
    
    n--;
    float s = off * n;
    s /= 2;
    s = -s;
    
    for(int i=0; i<n+1; i++)
    {
      ss[i] = s + off * i;
    }
    
    return ss;
  }
  
  
  
  void annLoad(String name)
  {
    String[] strings = loadStrings(name);

    x = Float.valueOf(strings[0]);
    y = Float.valueOf(strings[1]);
    x = width/2;
    y = height/2;

    n_inputs = Integer.valueOf(strings[2]);
    n_per_hidden = new int[Integer.valueOf(strings[3])];

    for(int i=0; i<n_per_hidden.length; i++)
      n_per_hidden[i] = Integer.valueOf(strings[i+4]); 
    n_outputs = Integer.valueOf(strings[n_per_hidden.length+4]);
    

    initialize(x, y, n_inputs, n_per_hidden, n_outputs, 10, 10);
  }
}