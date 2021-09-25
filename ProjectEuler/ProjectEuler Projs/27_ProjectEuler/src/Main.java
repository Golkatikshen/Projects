
public class Main 
{
    public static void main(String args[])
    {     
        long max_n = 0;
        long max_product = 0;
        long n = 0;
        
        for(int a=-1000; a<1000; a++)
        {
            for(int b=-1000; b<1000; b++)
            {
                while(Is_Prime(Quadratic(n, a, b)))
                {
                    n++;
                }
                
                if(n > max_n)
                {
                    max_n = n;
                    max_product = a*b;
                }
                
                n = 0;
            }
        }
        
        Out(max_product);
    }
    
    public static boolean Is_Prime(long n)
    {
        boolean prime = true;
        
        for(long i=2; i<Math.sqrt(n); i++)
        {
            if(n % i == 0)
            {
                prime = false;
                i = n; // break;
            }
        }
        
        return prime;
    }
    
    public static long Quadratic(long n, long a, long b)
    {
        return Math.abs((n*n) + (a*n) + b);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}