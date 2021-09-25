
import java.math.BigInteger;

public class MBI 
{
    BigInteger val;
    
    MBI(int v)
    {
        val = new BigInteger(String.valueOf(v));
    }
    MBI(float v)
    {
        val = new BigInteger(String.valueOf(v));
    }
    MBI(long v)
    {
        val = new BigInteger(String.valueOf(v));
    }
    MBI(double v)
    {
        val = new BigInteger(String.valueOf(v));
    }
    
    
    public void sum(int v)
    {
        val = val.add(new BigInteger(String.valueOf(v)));
    }
    public void sum(float v)
    {
        val = val.add(new BigInteger(String.valueOf(v)));
    }
    public void sum(long v)
    {
        val = val.add(new BigInteger(String.valueOf(v)));
    }
    public void sum(double v)
    {
        val = val.add(new BigInteger(String.valueOf(v)));
    }
    public void sum(MBI v)
    {
        val = val.add(v.val);
    }
}
