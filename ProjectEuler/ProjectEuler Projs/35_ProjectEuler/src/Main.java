
public class Main 
{
    public static void main(String args[])
    {
        long sum = 0;

        for(int i=2; i<1000000; i++)
        {
            if(Is_Circular_Prime(i))
                sum ++;
        }
        
        Out(sum);
    }
    
    public static boolean Is_Circular_Prime(int n)
    {
        String snum = String.valueOf(n);
        
        for(int i=0; i<snum.length(); i++)
        {
            if(!Is_Prime(Integer.parseInt(snum)))
                return false;
            
            snum = RotateS(snum);
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
    
    public static String RotateS(String s)
    {
        String tmp = "";
        for(int i=1; i<s.length(); i++)
            tmp += s.charAt(i);
        tmp += s.charAt(0);
        return tmp;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}