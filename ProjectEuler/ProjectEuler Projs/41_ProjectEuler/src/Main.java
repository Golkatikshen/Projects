
public class Main 
{
    public static void main(String args[])
    {
        long max = 0;
        
        for(long i=2143; i<1000000000; i+=2)
        {
            if(Is_Both(i))
            {
                if(i > max)
                    max = i;
            }
        }
        
        Out(max);
    }
    
    public static boolean Is_Both(long n)
    {
        return (Is_Pandigital(n) && Is_Prime(n));
    }
    
    public static boolean Is_Pandigital(long n)
    {
        String num = String.valueOf(n);
        
        for(int i=1; i<=num.length(); i++)
        {
            if(!num.contains(String.valueOf(i)))
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