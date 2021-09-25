
public class Main 
{
    public static void main(String args[])
    {
        int somma_lettere = 0;
        for(int i=1; i<=1000; i++)
        {
            somma_lettere += N_Char(Number_to_Word(i));
            Out(Number_to_Word(i));
            Out(N_Char(Number_to_Word(i)) + "\n");
        }
        
        Out("La somma totale delle lettere dei numeri da 1 a 1000 in inglese è: " + somma_lettere);
    }
    
    
    
    public static int N_Char(String s)
    {
        String temp = "";
        
        for(int i=0; i<s.length(); i++)
        {
            if(s.charAt(i) != ' ' && s.charAt(i) != '-')
                temp += s.charAt(i);
        }
        
        return temp.length();
    }
    
    
    
    public static String Number_to_Word(int n)
    {
        if(n > 1000)
            return "Too Large I Can't Read You Stupid";
        
        String numero = "";
        
        String[] nums_0to9 = new String[10];
        String[] nums_10to19 = new String[10];
        String[] nums_decs = new String[10];
        
        nums_0to9[0] = "zero";
        nums_0to9[1] = "one";
        nums_0to9[2] = "two";
        nums_0to9[3] = "three";
        nums_0to9[4] = "four";
        nums_0to9[5] = "five";
        nums_0to9[6] = "six";
        nums_0to9[7] = "seven";
        nums_0to9[8] = "eight";
        nums_0to9[9] = "nine";
       
        nums_10to19[0] = "ten";
        nums_10to19[1] = "eleven";
        nums_10to19[2] = "twelve";
        nums_10to19[3] = "thirteen";
        nums_10to19[4] = "fourteen";
        nums_10to19[5] = "fifteen";
        nums_10to19[6] = "sixteen";
        nums_10to19[7] = "seventeen";
        nums_10to19[8] = "eighteeb";
        nums_10to19[9] = "nineteen";
        
        nums_decs[0] = "twenty";
        nums_decs[1] = "thirty";
        nums_decs[2] = "forty";
        nums_decs[3] = "fifty";
        nums_decs[4] = "sixty";
        nums_decs[5] = "seventy";
        nums_decs[6] = "eighty";
        nums_decs[7] = "ninety";
        nums_decs[8] = "hundred";
        nums_decs[9] = "thousand";
        
        //SOTTO IL 20
        if(n < 20)
        {
            if(n < 10)
                return nums_0to9[n];
            else
                return nums_10to19[n-10];
        }
        
        //SOTTO IL 100
        for(int i=0; i<8; i++)
        {
            if(n < (i+3)*10)
            {
                numero += (nums_decs[i]+"-");
                n -= (i+3)*10-10;
                if(n != 0)
                    numero += nums_0to9[n];
                else
                    numero = numero.replace("-", "");
                return numero;
            }
        }
        
        //SOTTO IL 1000
        for(int i=1; i<=10; i++)
        {
            if(n < i*100)
            {
                numero += (nums_0to9[i-1] + " " + nums_decs[8] + " and ");
                n -= i*100-100;
                
                if(n == 0)
                {
                    numero = numero.replace(" and ", "");
                    return numero;
                }
                
                if(n < 20)
                {
                    if(n < 10)
                        numero += nums_0to9[n];
                    else
                        numero += nums_10to19[n-10];
                    
                    return numero;
                }
                
                for(int j=0; j<8; j++)
                {
                    if(n < (j+3)*10)
                    {
                        numero += (nums_decs[j]+"-");
                        n -= (j+3)*10-10;
                        if(n != 0)
                            numero += nums_0to9[n];
                        else
                            numero = numero.replace("-", "");
                        return numero;
                    }
                }
            }
        }
        
        //1000
        numero = (nums_0to9[1] + " " + nums_decs[9]);
        
        return numero;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}