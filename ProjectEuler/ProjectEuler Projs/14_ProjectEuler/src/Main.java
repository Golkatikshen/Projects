
public class Main 
{
    public static void main(String args[])
    {
        long n;
        long num_longerchain = 1;
        long num;
        long chainlength;
        long max_chainlength = 4;
        
        for(int i=1; i<1000000; i++)
        {
            num = i;
            n = i;
            chainlength = 0;
            
            do{
                n = Next_Collatz_Sequence(n);
                chainlength ++;
            }while(n != 1);
            
            if(max_chainlength < chainlength)
            {
                max_chainlength = chainlength;
                num_longerchain = num;
            }
        }
        
        Out(num_longerchain);
    }
    
    public static long Next_Collatz_Sequence(long n)
    {
        if(n % 2 == 0)
            return (n/2);
        else
            return (3*n + 1);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}