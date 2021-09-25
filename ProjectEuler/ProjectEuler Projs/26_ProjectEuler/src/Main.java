
import java.math.*;


public class Main 
{
    public static void main(String args[])
    {
        BigInteger f_unit = new BigInteger("10");     
        f_unit = f_unit.pow(1000);

        int n_max_r = 0;
        int i_max_r = 0;
        for(int i=1; i<1000; i++)
        {
            BigInteger n = f_unit.divide(new BigInteger(String.valueOf(i)));

            if(N_Digits(Repeating_Number(n)) > n_max_r)
            {
                n_max_r = N_Digits(Repeating_Number(n));
                i_max_r = i;
            }
            
            Out(i + ": " + N_Digits(Repeating_Number(n)));
        }
        
        BigInteger n = f_unit.divide(new BigInteger(String.valueOf(i_max_r)));
        Out(i_max_r);
        Out(N_Digits(Repeating_Number(n)));
        Out(Repeating_Number(n));
        Out(n);
    }
    
    
    public static int N_Digits(BigInteger n)
    {
        String snum = String.valueOf(n);
        return snum.length();
    }
    
    public static BigInteger Repeating_Number(BigInteger n)
    {
        String rep_n = "";
        String snum = String.valueOf(n);
        boolean rep = false;
        
        for(int i=0; i<snum.length(); i++)
        {
            for(int j=snum.length()-2; j>i; j--)
            {
                if(contains2(snum.substring(i), snum.substring(i, j)))
                {
                    rep = true;
                    rep_n = snum.substring(i, j);
                    i=snum.length();
                    j=i;
                }
            }
        }
        
        if(rep)
            return RoudingRep(new BigInteger(rep_n));
        else
            return (new BigInteger(snum));
    }
    
    public static BigInteger RoudingRep(BigInteger n)
    {
        String num = String.valueOf(n);
        String tr;
        
        for(int i=0; i<num.length(); i++)
        {
            tr = "";
            for(int j=0; j<i+1; j++)
                tr += num.charAt(j);
            
            if(tr.length()+tr.length() > num.length())
                break;
            
            if(num.substring(tr.length(), tr.length()+tr.length()).equals(tr))
                return (new BigInteger(tr));
        }
        
        return (new BigInteger(num));
    }
    
    public static boolean contains2(String str, String s)
    {
        if(s.length() >= str.length())
            return false;

        int count = 0;
        for(int i=0; i<str.length(); )
        {
            if(str.length() < i + s.length())
                break;
            
            if(str.substring(i, i + s.length()).equals(s))
            {
                i+=s.length();
                count ++;
            }
            else
            {
                if(count != 0)
                    break;
                else
                    i++;
            }
        }
        
        return (count >= 2);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    /*
    for(int i=0; i<10; i++)
            rep_c += snum.charAt(i);
        
        rep_n = rep_c;
        
        for(int i=10; i<snum.length()-10; i++)
        {
            if(snum.charAt(i) != rep_c.charAt(0) || snum.charAt(i+1) != rep_c.charAt(1) || snum.charAt(i+2) != rep_c.charAt(2) || snum.charAt(i+3) != rep_c.charAt(3) || snum.charAt(i+4) != rep_c.charAt(4) || snum.charAt(i+5) != rep_c.charAt(5) || snum.charAt(i+6) != rep_c.charAt(6) || snum.charAt(i+7) != rep_c.charAt(7) || snum.charAt(i+8) != rep_c.charAt(8) || snum.charAt(i+9) != rep_c.charAt(9))
                rep_n += snum.charAt(i);
            else
                break;
        }
        
        if(rep_n.length() > 3)
        {
            for(int i=0; i<10; i++)
            {
                if(rep_n.charAt(rep_n.length()-1) == String.valueOf(i).charAt(0) && rep_n.charAt(rep_n.length()-2) == String.valueOf(i).charAt(0) && rep_n.charAt(rep_n.length()-3) == String.valueOf(i).charAt(0))
                {
                    for(int j=rep_n.length()-1; j>0; j--)
                    {
                        if(rep_n.charAt(j) == String.valueOf(i).charAt(0))
                            rep_n = rep_n.substring(0, rep_n.length()-1);
                        else
                            break;
                    }
                    break;
                }
            }
        }
    */
}