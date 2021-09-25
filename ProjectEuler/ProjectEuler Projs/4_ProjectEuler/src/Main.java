
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {
        ArrayList<Integer> palindromi = new ArrayList<>(0);
        
        for(int i=100; i<1000; i++)
        {
            for(int j=100; j<1000; j++)
            {
                if(Is_Palindrome(i*j))
                    palindromi.add(i*j);
            }
        }
        
        int max = palindromi.get(0); 
        for(int i=0; i<palindromi.size(); i++)
        {
            if(palindromi.get(i) > max)
                max = palindromi.get(i);
        }
        
        Out(max);
    }
    
    public static boolean Is_Palindrome(int n)
    {
        boolean palindrome = false;
        String sn = String.valueOf(n);
        
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
