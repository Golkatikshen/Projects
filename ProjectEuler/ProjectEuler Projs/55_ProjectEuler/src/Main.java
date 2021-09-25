
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        int count = 0;
        
        for(int i=0; i<10000; i++)
        {
            if(Is_Lychrel_Number(i))
                count ++;
        }
        
        Out(count);
    }
    
    public static boolean Is_Lychrel_Number(long n)
    {
        BigInteger num = new BigInteger(String.valueOf(n));
        
        for(int i=0; i<50; i++)
        {
            num = num.add(Reverse(num));
            if(Is_Palindrome(String.valueOf(num)))
                return false;
        }
        return true;
    }
    
    public static BigInteger Reverse(BigInteger n)
    {
        BigInteger num;
        String tmp = String.valueOf(n);
        String snum = "";
        
        for(int i=tmp.length()-1; i>=0; i--)
            snum += tmp.charAt(i);
        
        num = new BigInteger(snum);
        return num;
    }
    
    public static boolean Is_Palindrome(String n)
    {
        boolean palindrome = false;
        String sn = n;
        
        if(sn.length() % 2 == 0)
        {
            int nc = sn.length() / 2;
            
            String part1 = "";
            String part2 = "";
            
            for(int i=0; i<sn.length(); i++)
            {
                if(i < nc)
                    part1 += sn.charAt(i);
                else
                    part2 += sn.charAt(i);
            }
            
            String temp = part2;
            part2 = "";
            for(int i=temp.length()-1; i>=0; i--)
                part2 += temp.charAt(i);
            
            if(part1.equals(part2))
                palindrome = true;
        }
        else
        {
            int nc = (int)(sn.length() / 2);
            
            String part1 = "";
            String part2 = "";
            
            for(int i=0; i<sn.length(); i++)
            {
                if(i < nc)
                    part1 += sn.charAt(i);
                else
                    part2 += sn.charAt(i);
            }
            
            String temp = part2;
            part2 = "";
            for(int i=temp.length()-1; i>0; i--)
                part2 += temp.charAt(i);
            
            if(part1.equals(part2))
                palindrome = true;
        }
        
        return palindrome;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}