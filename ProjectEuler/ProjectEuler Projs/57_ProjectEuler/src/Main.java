
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
        int count = 0;
        
        for(int i=0; i<1000; i++)
        {
            if(String.valueOf(Doubled_Plus_Prec(3, i)).length() > String.valueOf(Doubled_Plus_Prec(2, i)).length())
                count ++;
        }
        
        Out(count);
    }
    
    public static BigInteger Doubled_Plus_Prec(int start_v, int index)
    {
        BigInteger num = new BigInteger(String.valueOf(start_v));
        BigInteger prec, prec2;
        
        if(index == 0)
            return num;
        
        prec = num;
        num = num.multiply(new BigInteger("2"));
        num = num.add(new BigInteger("1"));
        
        if(index == 1)
            return num;
        
        prec2 = num;
        for(int i=2; i<=index; i++)
        {
            num = num.multiply(new BigInteger("2"));
            num = num.add(prec);
            prec = prec2;
            prec2 = num;
        }
        
        return num;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}