
import java.util.ArrayList;


public class Main 
{
    static ArrayList<Integer> PRIMES = new ArrayList<>();
    
    public static void main(String args[])
    {
        Fill_PRIMES();
        Out("PRIMES OK");
        
        int limit = 1000000;
        for(int i=0; i<limit; i++)
        {
            if(Is_N_Consecutive_Primes_Factors(i, 4, 4))
            {
                Out("\nIl numero è " + i);
                i = limit;
            }
        }
    }
    
    public static boolean Is_N_Consecutive_Primes_Factors(long n, int n_primes, int n_nums)
    {
        int count_primes;
        
        for(long i=n; i<n+n_nums; i++)
        {
            count_primes = 0;
            for(long j=0; PRIMES.get((int)j)<n; j++)
            {
                if(i % PRIMES.get((int)j) == 0)
                    count_primes++;
            }
            
            if(count_primes < n_primes)
                return false;
        }
        
        return true;
    }
    
    public static long N_Prime(long n)
    {
        long prime = 0;
        long i = 2;
        long count = 0;
        
        do{
            if(Is_Prime(i))
            {
                prime = i;
                count++;
            }
            if(i == 2)
                i++;
            else
                i+=2;
        }while(count != n);
        
        return prime;
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
    
    public static void Fill_PRIMES()
    {
        PRIMES.add(2);
        for(int i=3; i<1000000; i+=2)
        {
            if(Is_Prime(i))
                PRIMES.add(i);
        }
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}