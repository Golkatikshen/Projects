
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {     
        for(int i=1000; i<9999; i++)
        {
            if(Is_Prime(i))
            {
                Conditions_Calculations(i);
            }
        }
    }
    
    public static void Conditions_Calculations(long n)
    {
        for(long n2=n+1; n2<9999; n2++)
        {
            if(Is_Prime(n2) && Is_Permutation(n, n2))
            {
                long diff = n2 - n;
                long n3 = n2+diff;
                if(Is_Prime(n3) && Is_Permutation(n, n3))
                    Out(String.valueOf(n) + String.valueOf(n2) + String.valueOf(n3));
            }
        }
    }
    
    public static boolean Is_Permutation(long n, long p)
    {
        if(String.valueOf(n).length() != String.valueOf(p).length())
            return false;
        
        
        int[] n_each_digit = new int[10];
        int[] p_each_digit = new int[10];
        
        String snum = String.valueOf(n);
        String sp = String.valueOf(p);
        
        for(int j=0; j<snum.length(); j++)
            n_each_digit[Integer.parseInt(String.valueOf(snum.charAt(j)))] ++;

        for(int j=0; j<sp.length(); j++)
            p_each_digit[Integer.parseInt(String.valueOf(sp.charAt(j)))] ++;

        for(int i=0; i<10; i++)
        {
            if(n_each_digit[i] != p_each_digit[i])
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
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}