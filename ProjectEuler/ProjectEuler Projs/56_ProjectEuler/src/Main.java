
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        long max_sum = 0;
        long sum;
        
        for(int a=0; a<100; a++)
        {
            for(int b=0; b<100; b++)
            {
                BigInteger num = new BigInteger(String.valueOf(a));
                num = num.pow(b);
                
                sum = Digit_Sum(num);
                if(sum > max_sum)
                    max_sum = sum;
            }
        }
        
        Out(max_sum);
    }
    
    public static long Digit_Sum(BigInteger num)
    {
        String snum = String.valueOf(num);
        long sum = 0;
        
        for(int i=0; i<snum.length(); i++)
            sum += Integer.parseInt(String.valueOf(snum.charAt(i)));
        
        return sum;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}