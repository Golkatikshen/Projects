
public class Main 
{
    public static void main(String args[])
    {
        long limit = 100000L;
        
        for(long i=0; i<limit; i++)
        {
            if(Is_Odd_Composite(i))
            {
                if(Is_Goldbach_Conjecture_False(i))
                {
                    Out(i);
                    i = limit;
                }
            }
        }
        
        Out("Nessuna altra falsità sotto il " + limit);
    }
    
    public static boolean Is_Goldbach_Conjecture_False(long n)
    {
        for(long i=2; N_Prime(i)<n; i++)
        {
            for(long j=2; Math.pow(j, 2)<n; j++)
            {
                if(n == N_Prime(i) + 2 * Math.pow(j, 2))
                    return false;
            }
        }
        
        return true;
    }
    
    public static boolean Is_Odd_Composite(long n)
    {
        if(Is_Prime(n))
            return false;
        
        
        return (n % 2 != 0);
        
        /*String snum = String.valueOf(n);
        for(int i=0; i<snum.length(); i++)
        {
            if(Integer.parseInt(String.valueOf(snum.charAt(i))) % 2 != 0)
                return false;
        }
        
        return true;
        */
    }
    
    public static long N_Prime(long n)
    {
        long prime = 0;
        long i = 0;
        long count = 0;

        do{
            if(Is_Prime(i))
            {
                prime = i;
                count++;
            }
            i++;
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
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}