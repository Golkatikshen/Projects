
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {
        ArrayList<Integer> products = new ArrayList<>();
        long sum = 0;
        
        for(int i=0; i<1000; i++)
        {
            for(int j=0; j<10000; j++)
            {
                if(MMP_C_AllDigits(i, j) && !products.contains(i*j))
                    products.add(i*j);
            }
        }
        
        for(int i=0; i<products.size(); i++)
            sum += products.get(i);
        
        Out(sum);
    }
    
    public static boolean MMP_C_AllDigits(int a, int b)
    {
        String multiplicand = String.valueOf(a);
        String multiplier = String.valueOf(b);
        String product = String.valueOf(a*b);

        String num = multiplicand + multiplier + product;

        if(num.contains("0"))
            return false;
        
        if(num.length() > 9)
            return false;
        
        for(int i=1; i<10; i++)
        {
            if(!num.contains(String.valueOf(i)))
                return false;
        }
        
        return true;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}