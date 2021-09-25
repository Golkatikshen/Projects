
public class Main 
{
    public static void main(String args[])
    {
        long n=10;
        
        while(!Is_Multiple_Permutation(n, 6))
            n++;
        
        Out(n);
    }
    
    public static boolean Is_Multiple_Permutation(long n, int np)
    {
        for(int i=2; i<=np; i++)
        {
            if(!Is_Permutation(n, n*i))
                return false;
        }
        
        return true;
    }
    
    public static boolean Is_Permutation(long n, long p)
    {
        if(String.valueOf(n).length() != String.valueOf(p).length())
            return false;
        
        int[] n_each_digit = new int[10];
        int[] p_each_digit = new int[10];
        
        String snum = String.valueOf(n);
        String sp = String.valueOf(p);
        
        for(int j=0; j<snum.length(); j++)
            n_each_digit[Integer.parseInt(String.valueOf(snum.charAt(j)))] ++;

        for(int j=0; j<sp.length(); j++)
            p_each_digit[Integer.parseInt(String.valueOf(sp.charAt(j)))] ++;

        for(int i=0; i<10; i++)
        {
            if(n_each_digit[i] != p_each_digit[i])
                return false;
        }
        
        return true;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}