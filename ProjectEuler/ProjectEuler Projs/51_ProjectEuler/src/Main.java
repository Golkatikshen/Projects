
import java.util.ArrayList;


public class Main 
{
    static ArrayList<String> BINARY = new ArrayList<>();
    
    public static void main(String args[])
    {
        Fill_BINARY(10);
        long n = 1;
        
        while(Prime_Family_Calculator(n) != 8)
            n++;
        
        Out(n);
    }
    
    public static int Prime_Family_Calculator(long n)
    {
        ArrayList<String> numeri = new ArrayList<>();
        ArrayList<String> max_numeri = new ArrayList<>();
        
        String snum = String.valueOf(n);
        String temp;
        
        int prime_family;
        int max_prime_family = 0;
        
        for(int j=1; String.valueOf(Integer.parseInt(BINARY.get(j))).length()<=snum.length(); j++)
        {
            String bin = BINARY.get(j);
            do{
                bin = bin.substring(1, bin.length());
            }while(bin.length() != snum.length());
                
            if((Same_Digs(snum, bin)) && (String.valueOf(Integer.parseInt(BINARY.get(j))).contains("0") || String.valueOf(Integer.parseInt(BINARY.get(j))).length() < snum.length()))
            {
                prime_family = 0;
                numeri.clear();
                
                for(int i=0; i<10; i++)
                {
                    temp = snum;
                    for(int k=0; k<temp.length(); k++)
                    {
                        if(bin.charAt(k) == '1')
                            temp = temp.substring(0, k) + String.valueOf(i) + temp.substring(k+1, temp.length());
                    }

                    if(Is_Prime(Integer.parseInt(temp)) && String.valueOf(Integer.parseInt(temp)).length() == snum.length())
                    {
                        prime_family ++;
                        numeri.add(temp);
                    }
                }

                if(prime_family > max_prime_family)
                {
                    max_prime_family = prime_family;
                    max_numeri.clear();
                    for(int i=0; i<numeri.size(); i++)
                        max_numeri.add(numeri.get(i));
                }
            }
        }

        return max_prime_family;
    }
    
    public static boolean Same_Digs(String snum, String bin)
    {
        ArrayList<Character> digits = new ArrayList<>();
        
        for(int i=0; i<snum.length(); i++)
        {
            if(bin.charAt(i) == '1')
                digits.add(snum.charAt(i));
        }
        
        for(int i=1; i<digits.size(); i++)
        {
            if(digits.get(0).compareTo(digits.get(i)) != 0)
                return false;
        }
        
        return true;
    }
    
    public static boolean Is_Prime(long n)
    {
        boolean prime = true;
        
        for(long i=2; i<=Math.sqrt(n); i++)
        {
            if(n % i == 0)
            {
                prime = false;
                i = n; // break;
            }
        }
        
        return prime;
    }
    
    public static void Fill_BINARY(int n_digit)
    {
        int n = 0;
        do{
            String num = Dec_to_Bin(n);
            if(num.length() < n_digit)
            {
                int limit = n_digit-num.length();
                for(int i=0; i<limit; i++)
                    num = "0" + num;
            }
            BINARY.add(num);
            n ++;
        }while(Dec_to_Bin(n).length() <= n_digit);
    }
    
    public static String Dec_to_Bin(int n)
    {
        int decimale = n;
        String risultato = "";
        
        do{
		risultato = (decimale % 2) + risultato;
		decimale = decimale / 2;
	}while(decimale >= 1);
        
        return risultato;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}