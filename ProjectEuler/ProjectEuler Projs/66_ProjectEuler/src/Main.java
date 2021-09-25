
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;


public class Main
{
    public static void main(String[] args)
    {
        ArrayList<BigInteger> xs = new ArrayList();
        ArrayList<Integer> ds = new ArrayList();
        Fraction fra;
        Long[] ints;
        
        int N = 1000;
        for(int D=2; D<=N; D++)
        {
            if(!U.isSquare(D))
            {
                ints = U.continuedFractionBD(U.sqrtBD(new BigDecimal(String.valueOf(D)), 100), 100);
                BigInteger x, y, f1, f2;     
                int index = 0;
                
                do{
                    fra = new Fraction(1, ints[index+1]);

                    for(int i=index; i>=0; i--)
                    {
                        fra.sumVal(ints[i]);
                        fra.reciprocal();
                    }
                    fra.reciprocal();
                    String[] ss = fra.toString().split("/");
                    x = new BigInteger(ss[0]);
                    y = new BigInteger(ss[1]);
                    
                    index ++;
                    
                    f1 = x.pow(2);
                    f2 = y.pow(2);
                    f2 = f2.multiply(new BigInteger(String.valueOf(D)));
                    f1 = f1.subtract(f2);
                    
                }while(!f1.equals(new BigInteger("1")));
                
                xs.add(x);
                ds.add(D);
            }
        }
        
        int max_i = U.maxIndexInArray(xs);
        Out("D: " + ds.get(max_i));
        Out("Val: " + xs.get(max_i));
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    /*
    for(long y=2; y<=Long.MAX_VALUE; y++)
                {
                    BigInteger x = new BigInteger(String.valueOf(y));
                    x = x.pow(2);
                    x = x.multiply(new BigInteger(String.valueOf(D)));
                    x = x.add(new BigInteger(String.valueOf(1)));
                    
                    if(U.isSquare(x))
                    {
                        x = U.sqrtBI(x);
                        xs.add(x);
                        ds.add(D);
                        break;
                    }
                }
    */
}