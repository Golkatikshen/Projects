
public class Main 
{
    public static void main(String args[])
    {
        long value = 100000L;
        for(long i=2; i<value; i++)
        {
            if(Is_Pentagonal(N_Triangle(i)) && Is_Hexagonal(N_Triangle(i)))
                Out(N_Triangle(i));
        }
        
        Out("Nessun altro sotto il " + value);
    }
    
    public static boolean Is_Pentagonal(long n)
    {
        double test = (Math.sqrt(1 + 24 * n) + 1.0) / 6.0;
        return test == ((int)test);
    }
    
     public static boolean Is_Hexagonal(long n)
    {
        double test = (Math.sqrt(1 + 8 * n) + 1.0) / 4.0;
        return test == ((int)test);
    }
    
    public static long N_Triangle(long n)
    {
        return (n*(n+1)/2);
    }
    
    public static long N_Pentagonal(long n)
    {
        return (n*(3*n-1)/2);
    }
    
    public static long N_Hexagonal(long n)
    {
        return (n*(2*n-1));
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}