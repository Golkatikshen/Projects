
public class Main 
{
    public static void main(String args[])
    {
        long sum = 0;
        
        for(int i=0; i<1000000; i++)
        {
            if(Is_Palindrome(String.valueOf(i)) && Is_Palindrome(Dec_to_Bin(i)))
                sum += i;
        }
        
        Out(sum);
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