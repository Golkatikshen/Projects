
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        BigInteger num = new BigInteger("2");
        num = num.pow(1000);
        
        String nums = String.valueOf(num);
        
        int somma = 0;
        for(int i=0; i<nums.length(); i++)
            somma += Integer.parseInt(String.valueOf(nums.charAt(i)));
        
        Out(somma);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}