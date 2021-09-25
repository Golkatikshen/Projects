class Execution
{
  double[] registri;
  String program;
  int program_index;
  int parcount;
  boolean stop_exe;
  
  
  Execution(String _program)
  {
    registri = new double[1000000];
    program = _program;
    program_index = 0;
    parcount = 0;
    stop_exe = true;
  }
  
  
  
  void exe() throws Exception
  {
    String block = getBlock(program_index, program);
    //println(block);
    
    char c = block.charAt(0);
    char d = block.charAt(1);
    
    if(c == 'i')
    {
      input_type = "char";
      
      block = block.substring(1);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      
      String R = block;
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
        
      if(input_ready)
      {
        registri[Int(R)] = input.charAt(0);
        input = "";
        input_type = "";
        input_ready = false;
      }
      else
        program_index--;
    }
    else if(c == 'n')
    {
      input_type = "num";
      
      block = block.substring(1);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      
      String R = block;
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
        
      if(input_ready)
      {
        registri[Int(R)] = Double.valueOf(input);
        input = "";
        input_type = "";
        input_ready = false;
      }
      else
        program_index--;
    }
    else if(c == 'o' && d == 'n')
    {
      block = block.substring(2);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      String R = block;
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
        
      str_exe += String.valueOf(registri[Int(R)]) + "\n";
    }
    else if(c == 'o' && d == '(')
    {
      block = block.substring(2);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      String R = block;
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
        
      str_exe += String.valueOf((char)registri[Int(R)]);
    }
    else if((c == '*' || c == '/' || c == '-' || c == '%' || c == '+') && d != '>') //OPERAZIONI
    {
      block = block.substring(1);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      String[] R = block.split(",");
      for(int i=0; i<R.length; i++)
        if(isEven(Int(R[i])))
          R[i] = StrI(Int(R[i])/2);
        else
          R[i] = StrI(Int(R[i])/3);
      
      switch(c)
      {
        case '*':
          registri[Int(R[0])] = registri[Int(R[1])] + registri[Int(R[2])];
        break;
        
        case '/':
          registri[Int(R[0])] = registri[Int(R[2])] - registri[Int(R[1])];
        break;
        
        case '-':
          registri[Int(R[0])] = registri[Int(R[1])] * registri[Int(R[2])];
        break;
        
        case '%':
          registri[Int(R[0])] = registri[Int(R[1])] / registri[Int(R[2])];
        break;
        
        case '+':
          registri[Int(R[0])] = registri[Int(R[1])] % registri[Int(R[2])];
        break;
      }
    }
    else if(((c == '=') || (c == '!' && d == '=') || (c == '>') || (c == '<') || (c == '>' && d == '=') || (c == '<' && d == '=')) && d != ';') //OPERATORI DI COMPARAZIONE
    {
      if((c == '!' && d == '=') || (c == '>' && d == '=') || (c == '<' && d == '='))
        block = block.substring(2);
      else
        block = block.substring(1);
      
      if(d == '(')
        d = 32;
      String s = String.valueOf(c) + String.valueOf(d);
        
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      String[] R = block.split(",");
      for(int i=0; i<R.length; i++)
        if(isEven(Int(R[i])))
          R[i] = StrI(Int(R[i])/2);
        else
          R[i] = StrI(Int(R[i])/3);
      
      switch(s)
      {
        case "<=":
          registri[Int(R[0])] = registri[Int(R[1])] == registri[Int(R[2])] ? 1 : 0;
        break;
        
        case "< ":
          registri[Int(R[0])] = registri[Int(R[1])] != registri[Int(R[2])] ? 1 : 0;
        break;
        
        case "!=":
          registri[Int(R[0])] = registri[Int(R[1])] > registri[Int(R[2])] ? 1 : 0;
        break;
        
        case "==":
          registri[Int(R[0])] = registri[Int(R[1])] < registri[Int(R[2])] ? 1 : 0;
        break;
        
        case "> ":
          registri[Int(R[0])] = registri[Int(R[1])] >= registri[Int(R[2])] ? 1 : 0;
        break;
        
        case ">=":
          registri[Int(R[0])] = registri[Int(R[1])] <= registri[Int(R[2])] ? 1 : 0;
        break;
      }
    }
    else if(c == '-' && d == '>') //ASSEGNAZIONE MULTIPLA
    {
      block = block.substring(2);
      block = block.replace("(", "");
      block = block.replace(")", "");
      block = block.replace(";", "");
      String[] R = block.split(",");
      if(isEven(Int(R[0])))
          R[0] = StrI(Int(R[0])/2);
        else
          R[0] = StrI(Int(R[0])/3);
      
      int index_R = 1;
      int index_registri = Int(R[0]);
      while(index_R < R.length)
      {
        registri[index_registri] = Double.parseDouble(R[index_R]) / 3 * 2;
        index_R ++;
        index_registri++;
      }
    }
    else if(block.contains("=")) //ASSEGNAZIONE STANDARD
    {
      block = block.replace(";", "");
      String[] R = block.split("=");
      
      if(R[0].contains("[") && R[0].contains("]"))
      {
        R[0] = R[0].replace("[", "");
        R[0] = R[0].replace("]", "");
        if(isEven(Int(R[0])))
          R[0] = StrI(Int(R[0])/2);
        else
          R[0] = StrI(Int(R[0])/3);
          
        int Rp = (int)registri[Int(R[0])];
        if(isEven(Rp))
          Rp = Rp/2;
        else
          Rp = Rp/3;
          
        if(R[1].contains("(") && R[1].contains(")"))
        {
          R[1] = R[1].replace("(", "");
          R[1] = R[1].replace(")", "");
          registri[Rp] = (int)(Double.parseDouble(R[1]) / 3 * 2);
        }
        else
        {
          if(isEven(Int(R[1])))
            R[1] = StrI(Int(R[1])/2);
          else
            R[1] = StrI(Int(R[1])/3);
          registri[Rp] = registri[Int(R[1])];
        }
      }
      else
      {
        if(isEven(Int(R[0])))
          R[0] = StrI(Int(R[0])/2);
        else
          R[0] = StrI(Int(R[0])/3);
          
        if(R[1].contains("(") && R[1].contains(")"))
        {
          R[1] = R[1].replace("(", "");
          R[1] = R[1].replace(")", "");
          registri[Int(R[0])] = (int)(Double.parseDouble(R[1]) / 3 * 2);
        }
        else
        {
          if(isEven(Int(R[1])))
            R[1] = StrI(Int(R[1])/2);
          else
            R[1] = StrI(Int(R[1])/3);
          registri[Int(R[0])] = registri[Int(R[1])];
        }
      }
    }
    else if(c == '?' && d == '(')
    {
      block = block.substring(1);
      block = block.replace("(", "");
      block = block.replace(")", "");
      String R = block;
      
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
        
      if(registri[Int(R)] == 0 && registri[Int(R)+10] == Int(R))
      {
        String tmp_block = "";
        parcount = 1;
        program_index++;
        
        do{
          tmp_block = getBlock(program_index, program);
          
          if(tmp_block.charAt(0) == '?' && tmp_block.charAt(1) == '(')
            parcount++;
          if(tmp_block.charAt(0) == '?' && tmp_block.charAt(1) == ';')
            parcount--;
          
          program_index++;
        }while(!(tmp_block.equals("?;") && parcount == 0));
        program_index--;
      }
    }
    else if(c == ':' && d == '>')
    {
      block = block.substring(2);
      block = block.replace("(", "");
      block = block.replace(")", "");
      String R = block;
      
      if(isEven(Int(R)))
        R = StrI(Int(R)/2);
      else
        R = StrI(Int(R)/3);
      
      if(registri[Int(R)] == 0 && registri[Int(R)+10] == Int(R))
      {
        String tmp_block = "";
        parcount = 1;
        program_index++;
        
        do{
          tmp_block = getBlock(program_index, program);
          
          if(tmp_block.charAt(0) == ':' && tmp_block.charAt(1) == '>')
            parcount++;
          if(tmp_block.charAt(0) == '<' && tmp_block.charAt(1) == ';')
            parcount--;
          
          program_index++;
        }while(!(tmp_block.equals("<;") && parcount == 0));
        program_index--;
      }
    }
    else if(c == '<' && d == ';')
    {
      String tmp_block = "";
      parcount = 1;
      program_index--;
      
      do{
        tmp_block = getBlock(program_index, program);
        
        if(tmp_block.charAt(0) == ':' && tmp_block.charAt(1) == '>')
          parcount--;
        if(tmp_block.charAt(0) == '<' && tmp_block.charAt(1) == ';')
          parcount++;
        
        program_index--;
      }while(!(tmp_block.charAt(0) == ':' && parcount == 0));
    }
    else if(block.equals("dne_eht;")) //FINE ESECUZIONE
    {
      stop_exe = true;
      millis = millis() - millis;
      str_exe += "\n\n\n------- CONFUSION SYS: program terminated -------\n"+((float)millis/1000)+" - execution time in seconds.";
    }
    else if(c != '?' && d != ';')
    {
      JOptionPane.showMessageDialog(frame, "Command not known.\n"+block, "???", JOptionPane.ERROR_MESSAGE);
      stop_exe = true;
    }
    
    program_index ++;
  }
  
  
  
  
  String getBlock(int v, String program)
  {
    String block = "";
    int bcount = 0;
    
    for(int i=0; i<program.length(); i++)
    {
      if(program.charAt(i) == ';')
        if(v == bcount)
        {
          return block + ";";
        }
        else
        {
          bcount ++;
          i++;
          block = "";
        }
      
      
      if(program.charAt(i) == '?' && program.charAt(i+1) == '(')
      {
        block = "?";
        for(int j=i+1; j<program.length(); j++)
        {
          if(program.charAt(j) == ')')
          {
            block += ")";
            if(v == bcount)
              return block;
            else
            {
              bcount ++;
              i += j - i;
              i++;
              block = "";
              break;
            }
          }
          
          block += program.charAt(j);
        }
      }
      
      
      if(program.charAt(i) == ':')
      {
        block = ":";
        for(int j=i+1; j<program.length(); j++)
        {
          if(program.charAt(j) == ')')
          {
            block += ")";
            if(v == bcount)
              return block;
            else
            {
              bcount ++;
              i += j - i;
              i++;
              block = "";
              break;
            }
          }
          
          block += program.charAt(j);
        }
      }
   
   
      block += program.charAt(i);
    }
    
    return "dne_eht;";
  }
}