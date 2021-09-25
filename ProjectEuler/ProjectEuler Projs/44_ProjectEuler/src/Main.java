
public class Main 
{
    public static void main(String args[])
    {
        long value = 8000;
        long D_MINZ = 10000000L;
        long remj = 0;
        long remk = 0;
        
        for(int j=8; j<value; j++)
        {
            for(int k=8; k<value; k++)
            {
                if(Is_Pentagonal(N_Pentagonal(j) + N_Pentagonal(k)) && Is_Pentagonal(N_Pentagonal(j) - N_Pentagonal(k)))
                {
                    long D = Math.abs(N_Pentagonal(j) - N_Pentagonal(k));
                    
                    if(D < D_MINZ)
                    {
                        D_MINZ = D;
                        remj = N_Pentagonal(j);
                        remk = N_Pentagonal(k);
                    }
                }
            }
        }
        
        Out(D_MINZ);
        Out(remj);
        Out(remk);
    }
    
    public static boolean Is_Pentagonal(long n)
    {
        double test = (Math.sqrt(1 + 24 * n) + 1.0) / 6.0;
        return test == ((int)test);
    }
    
    public static long N_Pentagonal(int n)
    {
        return (n*(3*n-1)/2);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}