class ANNetwork
{
  float x;
  float y;
  float eta;
  
  int n_neurons;
  int n_inputs;
  int[] n_per_hidden;
  int n_outputs;
  
  Neuron[] input_neurons;
  Neuron[][] hidden_neurons;
  Neuron[] output_neurons;
  ArrayList<Connection> connections;
  
  ArrayList<float[][]> q_learn_sets;
  
  int show_path;
  float total_error;
  int epoch;
  
  
  ANNetwork(float x_, float y_, int n_inputs_, int[] n_per_hidden_, int n_outputs_)
  {
    initialize(x_, y_, n_inputs_, n_per_hidden_, n_outputs_);
  }
  
  ANNetwork(String name)
  {
    annLoad(name);
  }
  
  void initialize(float x_, float y_, int n_inputs_, int[] n_per_hidden_, int n_outputs_)
  {
    //inizializzazione
    x = x_;
    y = y_;
    eta = 0.5;
    show_path = -1;
    epoch = 0;
    
    n_neurons = 0;
    n_inputs = n_inputs_;
    n_per_hidden = n_per_hidden_;
    n_outputs = n_outputs_;
    
    input_neurons = new Neuron[n_inputs];
    hidden_neurons = new Neuron[n_per_hidden.length][];
    output_neurons = new Neuron[n_outputs];
    connections = new ArrayList();
    
    q_learn_sets = new ArrayList();
    
    
    //generazione neuroni
    int yoff = 100;
    int xoff = 140;
    float[] ssx = retSpaces(n_per_hidden.length + 2, xoff);
    int i_ssx = 0;
    
    //-generazioni neuroni di input
    float[] ss = retSpaces(n_inputs, yoff);
    for(int i=0; i<n_inputs; i++)
    {
      input_neurons[i] = new Neuron(0+x+ssx[i_ssx], 0+y+ss[i], i);
      n_neurons++;
    }
    i_ssx++;
    
    //-generazioni neuroni nascosti
    for(int i=0; i<n_per_hidden.length; i++)
    {
      hidden_neurons[i] = new Neuron[n_per_hidden[i]];
      ss = retSpaces(n_per_hidden[i], yoff);
      for(int j=0; j<n_per_hidden[i]; j++)
      {
        hidden_neurons[i][j] = new Neuron(0+x+ssx[i_ssx], 0+y+ss[j], i);
        n_neurons++;
      }
      i_ssx++;
    }
    
    //-generazione neuroni di output
    ss = retSpaces(n_outputs, yoff);
    for(int i=0; i<n_outputs; i++)
    {
      output_neurons[i] = new Neuron(0+x+ssx[i_ssx], 0+y+ss[i], i);
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
  }
  
  
  
  //display grafico degli elementi
  void display()
  {
    float aw = 0;
    for(Connection c: connections)
    {
      c.display();
      aw += c.w;
    }
    aw /= connections.size();
    
    
    if(show_path >= 0)
      recDisplayConnection(connections.get(show_path));

    for(Neuron n: input_neurons)
      n.display();
    for(Neuron[] hn: hidden_neurons)
      for(Neuron n: hn)
        n.display();
    for(Neuron n: output_neurons)
      n.display();
    
    
    fill(0, 255, 0);
    textSize(12);
    textAlign(LEFT);
    text("Weight Media: " + aw, 5, 32);
    text("Numero Neuroni: " + n_neurons, 5, 47);
    text("Numero Livelli Nascosti: " + hidden_neurons.length, 5, 62);
    text("Numero Connessioni: " + connections.size(), 5, 77);
    text("Epoch: " + epoch, 5, 92);
    text("Last Error: " + total_error, 5, 107);
  }
  
  
  //funzione ricorsiva di utility che mostra i percorsi delle connessioni
  void recDisplayConnection(Connection c)
  {
    strokeWeight(2);
    stroke(0, 255, 0);
    line(c.a.x, c.a.y-5, c.b.x, c.b.y-5);
    
    if(c.b.connections.size() != 0)
    {
      for(Connection cc: c.b.connections)
        recDisplayConnection(cc);
    }
    else
      c.b.display();
  }
  
  //funzione di utility che mi permette di assegnare ai neuroni una posizione ordinata
  float[] retSpaces(int n, int off)
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
  
  //funzione di utility che mi restituisce il falore in funzione sigmoidea o la sua derivata
  float sigmoid(float n, boolean der)
  {
    if(der == true)
      return (sigmoid(n, false) * (1 - sigmoid(n, false)));
      
    return (1/(1+exp(-n)));
  }
  
  
  
  //funzione che fa computare alla rete neurale degli input (tanti quanti sono i neuroni di input) restituendo in fine degli output (tanti quanti sono i neuroni di output)
  float[] forward(float[] inputs)
  {
    float[] outp = new float[n_outputs];
    
    if(inputs.length != n_inputs)
      return outp;
      
    
    for(Neuron n: input_neurons)
      n.reset();
    for(Neuron[] hn: hidden_neurons)
      for(Neuron n: hn)
        n.reset();
    for(Neuron n: output_neurons)
      n.reset();
    
    
    for(int i=0; i<n_inputs; i++)
    {
      input_neurons[i].out = inputs[i];
      input_neurons[i].activateInput();
    }
    
    for(int i=0; i<n_per_hidden.length; i++)
      for(int j=0; j<n_per_hidden[i]; j++)
          hidden_neurons[i][j].activate();
    
    for(int i=0; i<n_outputs; i++)
      output_neurons[i].activate();
      
     
    for(int i=0; i<n_outputs; i++)
      outp[i] = output_neurons[i].out;
      
    return outp;
  }
  
  
  //funzione per allenare la rete neurale (per allenare si intende un "calcolo" che modifica il valore delle connessioni)
  void train(float[] inputs, float[] target)
  {
    //-controllo compatibilità parametri con il numero di neuroni in input e output
    if(target.length != n_outputs || inputs.length != n_inputs)
      return;
    
    //-elaborazione dei dati da parte della rete
    forward(inputs);
    
    //-calcolo errore per ogni neurone + calcolo errore totale
    for(int i=0; i<n_outputs; i++)
      output_neurons[i].error = target[i] - output_neurons[i].out;
      
    for(int i=n_per_hidden.length-1; i>=0; i--)
        for(int j=0; j<n_per_hidden[i]; j++)
          hidden_neurons[i][j].calcError();
    
    total_error = 0;
    for(Neuron n: output_neurons)
      total_error += n.error;
    
    //-generando i nuovi valori delle connessioni tramite derivazione
    for(Connection c: connections)
      c.w = c.w + eta * c.b.error * c.b.sigmoid(c.b.net, true) * c.a.out;
      
    epoch++;
  }
  
  void train(float[] inputs, float[] target, int rip)
  {
    for(int r=0; r<rip; r++)
    {
      //-controllo compatibilità parametri con il numero di neuroni in input e output
      if(target.length != n_outputs || inputs.length != n_inputs)
        return;
      
      //-elaborazione dei dati da parte della rete
      forward(inputs);
      
      //-calcolo errore per ogni neurone + calcolo errore totale
      for(int i=0; i<n_outputs; i++)
        output_neurons[i].error = target[i] - output_neurons[i].out;
        
      for(int i=n_per_hidden.length-1; i>=0; i--)
          for(int j=0; j<n_per_hidden[i]; j++)
            hidden_neurons[i][j].calcError();
      
      total_error = 0;
      for(Neuron n: output_neurons)
        total_error += n.error;
      
      //-generando i nuovi valori delle connessioni tramite derivazione
      for(Connection c: connections)
        c.w = c.w + eta * c.b.error * c.b.sigmoid(c.b.net, true) * c.a.out;
        
      epoch++;
    }
  }
  
  
  //funzioni di controllo dell'algoritmo Q-Learning
  void dataLearn(float[] inputs, float[] targets)
  {  
    q_learn_sets.add(new float[2][]);
    q_learn_sets.get(q_learn_sets.size()-1)[0] = inputs;
    q_learn_sets.get(q_learn_sets.size()-1)[1] = targets;
  }
  
  void dataLearnTrain()
  {    
    boolean again = true;
    
    while(again)
    {
      again = false;
      
      for(int i=0; i<q_learn_sets.size(); i++)
      {
        train(q_learn_sets.get(i)[0], q_learn_sets.get(i)[1]);
        if(total_error > 0.05 || total_error < -0.05)
          again = true;
      }
    }
      
    q_learn_sets.clear();
  }
  
  
  //funzioni di salvataggio e caricamente di una rna salvata in un file
  void annSave(String name)
  {
    ArrayList<String> strings = new ArrayList();
    
    strings.add(String.valueOf(x));
    strings.add(String.valueOf(y));
    strings.add(String.valueOf(n_inputs));
    strings.add(String.valueOf(n_per_hidden.length));
    for(int i=0; i<n_per_hidden.length; i++)
      strings.add(String.valueOf(n_per_hidden[i]));
    strings.add(String.valueOf(n_outputs));
    
    for(int i=0; i<connections.size(); i++)
      strings.add(String.valueOf(connections.get(i).w));
      
    saveStrings(name, strings.toArray(new String[strings.size()]));
  }
  
  void annLoad(String name)
  {
    String[] strings = loadStrings(name);

    x = Float.valueOf(strings[0]);
    y = Float.valueOf(strings[1]);

    n_inputs = Integer.valueOf(strings[2]);
    n_per_hidden = new int[Integer.valueOf(strings[3])];

    for(int i=0; i<n_per_hidden.length; i++)
      n_per_hidden[i] = Integer.valueOf(strings[i+4]); 
    n_outputs = Integer.valueOf(strings[n_per_hidden.length+4]);
    

    initialize(x, y, n_inputs, n_per_hidden, n_outputs);

    for(int i=0; i<connections.size(); i++)
      connections.get(i).w = Float.valueOf(strings[i+n_per_hidden.length+5]);
  }
}