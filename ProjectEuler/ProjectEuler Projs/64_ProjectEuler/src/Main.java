
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashSet;


public class Main
{
    public static void main(String[] args)
    {
        HashSet square = new HashSet();
        
        for(int i=0; i<=10000; i++)
            square.add(i*i);
        
        int count = 0;
        /*for(int i=2; i<=13; i++)
        {
            if(!square.contains(i) && SRPeriodLength(i) % 2 == 1)
            {
                Out(i);
                count ++;
            }
        }*/
        
        //Out("\n"+count);
        
        Out(ggg(23, 4));
    }
    
    public static int SRPeriodLength(int n)
    {
        int num = (int)Math.sqrt(n);
        
        double sr = Math.sqrt(n);
        int td = num;
        
        ArrayList<Integer> nums_period = new ArrayList<>();
        for(int i=0; i<10; i++)
        {
            nums_period.add((int)(1/(sr-td)));
            
            double nsr = 1/(sr-td);
            int ntd = (int)(1/(sr-td));
            
            sr = nsr;
            td = ntd;
        }
        
        String str = "";
        for(int i=0; i<nums_period.size(); i++)
            str += nums_period.get(i);
        
        String numz = String.valueOf(Reps.Repeating_Number(new BigInteger(str)));
        
        return numz.length();
    }

    
    public static double ggg(int n, int a)
    {
        return (a+((n-a*a)/(a+Math.sqrt(n))));
    }
    
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
