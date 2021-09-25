
public class Main 
{
    public static void main(String args[])
    {
        int sum_amicable = 0;
        
        for(int i=0; i<10000; i++)
        {
            if(Is_Amicable(i))
            {
                sum_amicable += i;
            }
        }
        
        Out(sum_amicable);
    }
    
    public static boolean Is_Amicable(int n)
    {
        if(n == d(n))
            return false;
        else
            return (n == d(d(n)));
    }
    
    public static int d(int n)
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
}