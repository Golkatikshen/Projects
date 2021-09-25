
public class Main 
{
    public static void main(String[] args)
    {
        int DL = 1000000;
        //int DL = 8;
        double tre_f_sette = 3d/7d;
        long numeratore = 0;
        double n_mem = 0;
                
        for(int d=DL; d>0; d--)
        {
            if(d % 100000 == 0)
                Out(d);
            
            for(int n=d/2; n>0; n--)
            {
                if(U.MCD(n, d) == 1)
                {
                    double v = (double)n/(double)d;
                    
                    if(v < n_mem)
                        break;
                    
                    if(v < tre_f_sette && v > n_mem)
                    {
                        n_mem = v;
                        numeratore = n;
                    }
                }
            }
        }
        
        //428570
        Out(numeratore);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    public static void Exit()
    {
        System.exit(0);
    }
}
