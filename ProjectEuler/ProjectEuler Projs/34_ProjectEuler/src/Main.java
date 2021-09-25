
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        BigInteger sum = new BigInteger("0");
        
        for(int n=0; n<1000000; n++)
        {
            if(Eq_Sum_Fac_Digit(n))
                sum = sum.add(new BigInteger(String.valueOf(n)));
        }
        
        Out(sum);
    }
    
    public static boolean Eq_Sum_Fac_Digit(int n)
    {
        if(n == 1 || n == 2)
            return false;
        
        String snum = String.valueOf(n);
        BigInteger sum = new BigInteger("0");
        
        for(int i=0; i<snum.length(); i++)
            sum = sum.add(Factorial(Integer.parseInt(String.valueOf(snum.charAt(i)))));
        
        return (sum.equals(new BigInteger(String.valueOf(n))));
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