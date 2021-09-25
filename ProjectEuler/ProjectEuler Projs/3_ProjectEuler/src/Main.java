
public class Main 
{
    public static void main(String args[])
    {
        long n = 600851475143L;
        long n_primo = (long)Math.sqrt(n)+1;
        boolean primo_trovato = false;
        
        while(!primo_trovato && n_primo > 1)
        {
            n_primo --;
            
            primo_trovato = true;
            long r = (int)Math.sqrt(n_primo);
            for(long i=2; i<=r; i++)
            {
                if(n_primo % i == 0)
                {
                    primo_trovato = false;
                    i = r + 1;
                }
            }
            
            if(primo_trovato)
            {
                if(n % n_primo != 0)
                    primo_trovato = false; 
            }
        }
        
        Out(n_primo);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}