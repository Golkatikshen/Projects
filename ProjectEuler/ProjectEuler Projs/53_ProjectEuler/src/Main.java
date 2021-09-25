
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        long n_values = 0;
        
        for(int n=1; n<=100; n++)
        {
            for(int r=1; r<=n; r++)
            {
                if(Combinatorics_Calculator(n, r).compareTo(new BigInteger("1000000")) == 1)
                    n_values ++;
            }
        }
        
        Out(n_values);
    }
    
    public static BigInteger Combinatorics_Calculator(int n, int r)
    {
        if(r > n)
            return (new BigInteger("0"));
        
        return (Factorial(n).divide(Factorial(r).multiply(Factorial(n-r))));
    }
    
    public static BigInteger Factorial(int n)
    {
        BigInteger num = new BigInteger("1");
        
        for(int i=n; i>0; i--)
        {
            BigInteger bigI = new BigInteger(String.valueOf(i));
            num = num.multiply(bigI);
        }
        
        return num;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}