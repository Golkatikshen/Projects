
public class Main 
{
    public static void main(String[] args)
    {
        int n_min = 87109;
        double min =  (float)n_min/(float)U.totientEuler(n_min);
        int N = (int)Math.pow(10, 7);
        
        for(int i=2; i<N; i++)
        {
            int t = U.totientEuler(i);
            if(U.isNumPermutation(String.valueOf(i), String.valueOf(t)))
            {
                double v = (double)i/(double)t;
                if(min > v)
                {
                    min = v;
                    n_min = i;
                }
            }
        }
        
        Out(n_min);
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
