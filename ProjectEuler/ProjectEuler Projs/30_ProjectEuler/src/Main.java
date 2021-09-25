
public class Main 
{
    public static void main(String args[])
    {
        long sum = 0;
        
        for(int n=2; n<1000000; n++)
        {
            if(Sum_Of_Digits_Pow(n, 5))
                sum += n;
        }
        
        Out(sum);
    }
    
    public static boolean Sum_Of_Digits_Pow(int n, int p)
    {
        String snum = String.valueOf(n);
        int num = 0;
        
        for(int i=0; i<snum.length(); i++)
        {
            num += Math.pow(Integer.parseInt(String.valueOf(snum.charAt(i))), p);
        }
        
        return (num == n);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}