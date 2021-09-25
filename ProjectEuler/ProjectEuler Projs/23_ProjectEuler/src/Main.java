
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {       
        long sum = 0;
        ArrayList<Integer> abundants = new ArrayList<>(0);
        ArrayList<String> numeri = new ArrayList<>(0);
        ArrayList<Integer> non_abundants_sum = new ArrayList<>(0);
        
        for(int i=0; i<=20161; i++)
        {
            numeri.add(String.valueOf(i));
            
            if(Is_Abundant(i))
                abundants.add(i);
        }
        Out(abundants.size());
        
        for(int i=0; i<abundants.size(); i++)
        {
            for(int j=i; j<abundants.size(); j++)
            {
                numeri.remove(String.valueOf(abundants.get(i) + abundants.get(j)));
            }
        }
        
        for(int i=0; i<numeri.size(); i++)
        {
            sum += Integer.parseInt(numeri.get(i));
        }
        Out(sum);
    }
    
    public static boolean Is_Abundant(int n)
    {
        return (n < Divisor_Sum(n));
    }
    
    public static int Divisor_Sum(int n)
    {
        int sum = 0;
        
        for(int i=1; i<n; i++)
        {
            if(n % i == 0)
                sum += i;
        }
        
        return sum;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    
    /*
      for(int i=0; i<abundants.size(); i++)
        { 
            for(int j=i; j<abundants.size(); j++)
            {
                if(abundants.get(i) + abundants.get(j) > 28123)
                    break;
                
                abundants_sum.add(abundants.get(i)+abundants.get(j));
            }
            
            if(abundants_sum.get(abundants_sum.size()-1) > 28123)
                    break;
        }
        Out(abundants_sum.size());
        
        ArrayList<Integer> noncopy = new ArrayList<>(0);
        for(int i=0; i<abundants_sum.size(); i++)
        {
            if(!noncopy.contains(abundants_sum.get(i)))
                noncopy.add(abundants_sum.get(i));
        }
        abundants_sum = noncopy;
        Out(abundants_sum.size());
        
        Out("");
        for(int i=0; i<abundants_sum.size(); i++)
            Out(abundants_sum.get(i));
        Out("");
        
        for(int n=0; n<=28123; n++)
        {           
            if(!abundants_sum.contains(n))
                sum += n;
        }
        Out(sum);
    */
}