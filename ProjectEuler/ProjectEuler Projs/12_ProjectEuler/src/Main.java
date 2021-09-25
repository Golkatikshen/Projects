
public class Main 
{
    public static void main(String args[])
    {
        boolean trovato = false;
        long n = 0;
        int max_factors = 0;
        int n_factors;
        
        do{
            n++;
            n_factors = N_Factors(N_TriangleNumber(n));
            if(n_factors > 500)
                trovato = true;
            
            if(n_factors > max_factors)
            {
                max_factors = n_factors;
                Out(max_factors + " --> " + N_TriangleNumber(n));
            }
        }while(!trovato);
        
        Out(N_TriangleNumber(n));
    }
    
    public static long N_TriangleNumber(long n)
    {
        return n*(n+1)/2;
    }
    
    public static int N_Factors(long n)
    {
        int count = 0;
        
        for(long i=1; i<=n; i++)
        {
            if(n % i == 0)
                count ++;
        }
        
        return count;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}