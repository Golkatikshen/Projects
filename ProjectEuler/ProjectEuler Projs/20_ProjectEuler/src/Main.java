
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        BigInteger num = Factorial(100);
        
        String nums = String.valueOf(num);
        
        int sum = 0;
        for(int i=0; i<nums.length(); i++)
        {
            sum += Integer.parseInt(String.valueOf(nums.charAt(i)));
        }
        
        Out(num);
        Out("Numero di cifre: " + nums.length());
        Out("Somma delle cifre: " + sum);
    }
    
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
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}