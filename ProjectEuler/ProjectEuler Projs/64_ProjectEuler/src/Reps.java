
import java.math.BigInteger;


public class Reps 
{
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
            return Repeating_Number(new BigInteger(rep_n));
        else
            return (new BigInteger(snum));
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
}
