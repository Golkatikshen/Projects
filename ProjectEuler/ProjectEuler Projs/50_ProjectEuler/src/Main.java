
import java.util.ArrayList;


public class Main 
{
    static ArrayList<Integer> PRIMES = new ArrayList<>();
    
    public static void main(String args[])
    {
        Fill_PRIMES();
        Out("PRIMES OK \n\n");
        
        int max = 0;
        int max_n_primes = 0;
        int sum;
        int n_primes;
        
        int v = 4000;
        
        for(int i=0; PRIMES.get(i)<v; i++)
        {
            sum = PRIMES.get(i);
            n_primes = 1;
            for(int j=i+1; PRIMES.get(j)<v; j++)
            {
                sum += PRIMES.get(j);
                n_primes ++;
                
                if(Is_Prime(sum) && sum < 1000000)
                {
                    if(n_primes > max_n_primes)
                    {
                        max_n_primes = n_primes;
                        max = sum;
                    }
                }
            }
        }
        
        Out(max);
        Out(max_n_primes);
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