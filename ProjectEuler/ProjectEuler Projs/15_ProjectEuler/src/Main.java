
import java.math.BigInteger;



public class Main 
{
    public static void main(String args[])
    {
        int n_c = 20;
        int n = 2*n_c;
        int r = n/2;
 
        
        BigInteger result = new BigInteger(String.valueOf(Factorial(n).divide(Factorial(r).multiply(Factorial(n-r)))));
        
        Out(result);
    }
    
    
    /*OLDNESS
    /*int n = 2;
        int r = 2;
        long result;
        
        for(int i=r; i<10; i+=2)
        {
            result = (long)Math.pow(n, i);
            Out(result);
        }
        
        result = Factorial(n)/Factorial(n - r);
        Out(result);
        
        result = Factorial(n)/(Factorial(r)*Factorial(n - 1));
        Out(result);
        
        result = Factorial(n + r - 1)/(Factorial(r)*Factorial(n - 1));
        Out(result);
    
    //_---------------------------------------------------------------------
    
    int N = 2;
    ArrayList<String> paths = new ArrayList<>();
    Random random = new Random();

    while(true)
    {
        Point p = new Point(0, 0);
        String path = "";

        while(p.x != N-1 || p.y != N-1)
        {
            if(random.nextInt(2) == 0)
            {
                if(p.x + 1 == N)
                {
                    p.y ++;
                    path += 'y';
                }
                else
                {
                    p.x ++;
                    path += 'x';
                }
            }
            else
            {
                if(p.y + 1 == N)
                {
                    p.x ++;
                    path += 'x';
                }
                else
                {
                    p.y ++;
                    path += 'y';
                }
            }
        }

        if(!paths.contains(path))
        {
            paths.add(path);
            Out(paths.size());
            Out(paths.get(paths.size()-1));
        }
    }
    */
    
    public static BigInteger Factorial(int n)
    {
        BigInteger num = new BigInteger(String.valueOf(1));
        
        for(int i=n; i>0; i--)
        {
            BigInteger bigI = new BigInteger(String.valueOf(i));
            num = num.multiply(bigI);
        }
        
        return num;
    }
    
    public static long Grid_Seq(long n)
    {
        if(n < 1)
            return 0;  
  
        long grid_n = 4;
        for(long i=1; i<n; i++)
        {
            grid_n += 8+(4*(i-1));
        }
        
        return grid_n;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}