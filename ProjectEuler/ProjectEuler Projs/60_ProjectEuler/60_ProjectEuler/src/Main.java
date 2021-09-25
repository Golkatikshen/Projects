
import java.util.ArrayList;


public class Main 
{
    static ArrayList<Long> PRIMES = new ArrayList<>();
    
    public static void main(String args[])
    {
        Fill_PRIMES(30000);
        long p1,p2,p3,p4,p5;
        long min_sum = 9000;
        
        for(int i=0; i<PRIMES.size(); i++)
        {
            Out(i);
            p1 = PRIMES.get(i);
            for(int j=i+1; j<PRIMES.size(); j++)
            {
                p2 = PRIMES.get(j);
                if(Are_ConcatenatePrime(new long[] {p1,p2}))
                {
                    for(int k=j+1; k<PRIMES.size(); k++)
                    {
                        p3 = PRIMES.get(k);
                        if(Are_ConcatenatePrime(new long[] {p1,p2,p3}))
                        {
                            for(int h=k+1; h<PRIMES.size(); h++)
                            {
                                p4 = PRIMES.get(h);
                                if(Are_ConcatenatePrime(new long[] {p1,p2,p3,p4}))
                                {
                                    for(int g=h+1; g<PRIMES.size(); g++)
                                    {
                                        p5 = PRIMES.get(g);
                                        if(Are_ConcatenatePrime(new long[] {p1,p2,p3,p4,p5}))
                                        {
                                            long sum = p1 + p2 + p3 + p4 + p5;
                                            if(min_sum > sum)
                                            {
                                                min_sum = sum;
                                                Out(sum);
                                            }  
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    public static boolean Are_ConcatenatePrime(long[] primes)
    {
        for(int i=0; i<primes.length; i++)
        {
            for(int j=i; j<primes.length; j++)
            {
                if(!Is_ConcatenatePrime(primes[i], primes[j]) && primes[i] != primes[j])
                {
                    return false;
                }
            }
        }
        return true;
    }
    
    public static boolean Is_ConcatenatePrime(long n1, long n2)
    {
        String num1 = String.valueOf(n1);
        String num2 = String.valueOf(n2);
        
        if(!Is_Prime(Long.parseLong(num1+num2)))
            return false;
        if(!Is_Prime(Long.parseLong(num2+num1)))
            return false;
        
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
    
    public static void Fill_PRIMES(int i)
    {
        long n = 3;
        PRIMES.add(2L);
        do{
            if(Is_Prime(n))
                PRIMES.add(n);
            n +=2 ;
        }while(PRIMES.get(PRIMES.size()-1) < i);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}