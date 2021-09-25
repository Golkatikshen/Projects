
import java.math.BigInteger;


public class Fraction 
{
    public BigInteger num;
    public BigInteger dem;
    
    Fraction(long _num, long _dem)
    {
        num = new BigInteger(String.valueOf(_num));
        dem = new BigInteger(String.valueOf(_dem));
    }
    
    public void sumVal(long v)
    {
        num = num.add(dem.multiply(new BigInteger(String.valueOf(v))));
    }
    
    public void reciprocal()
    {
        BigInteger tmp = num;
        num = dem;
        dem = tmp;
    }
    
    @Override
    public String toString()
    {
        return(num+"/"+dem);
    }
}
