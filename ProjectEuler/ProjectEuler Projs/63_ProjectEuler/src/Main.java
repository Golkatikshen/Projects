
import java.math.BigInteger;


public class Main
{
    public static void main(String[] args)
    {
        BigInteger lnum;
        BigInteger num = new BigInteger("1");
        int p = 1;
        int count = 0;
        
        do{
            do{
                lnum = num.pow(p);
                num = num.add(new BigInteger("1"));
                
                if(String.valueOf(lnum).length() == p)
                {
                    count ++;
                    Out(lnum + " - " + p);
                }
                
            }while(String.valueOf(lnum).length() <= p);
            
            num = new BigInteger("1");
            p ++;
            
            Out(count);
        }while(true);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
