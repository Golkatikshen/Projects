
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        BigInteger power = new BigInteger("0");
        int target = 1000;
        
        for(int i=1; i<=target; i++)
        {
            BigInteger p = new BigInteger(String.valueOf(i));
            power = power.add(p.pow(i));
        }
        
        String spower = String.valueOf(power);
        String snum = "";
        for(int i=10; i>0; i--)
            snum +=  spower.charAt(spower.length()-i);
        
        Out(snum);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}