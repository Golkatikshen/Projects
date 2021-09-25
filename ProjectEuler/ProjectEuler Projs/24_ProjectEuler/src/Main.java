
import java.math.BigInteger;
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {  
        ArrayList<Integer> nums = new ArrayList<>(0);
        for(int i=0; i<10; i++)
            nums.add(i);
        
        for(int i=1; i<1000000; i++)
        {
            nums = nextPermutation(nums);
        }
        
        Out(nums);
    }
    
    public static ArrayList<Integer> nextPermutation(ArrayList<Integer> nums)
    {
        ArrayList<Integer> perm_nums = nums;
        ArrayList<Integer> to_reverse = new ArrayList<>(0);
        
        int k;
        int i;
        int n = perm_nums.size();
        
        boolean already_max = true;
        for(k=n-2; k>=0; k--)
        {
            if(perm_nums.get(k) < perm_nums.get(k+1))
            {
                already_max = false;
                break;
            }
        }
        
        if(already_max)
            return perm_nums;
        
        for(i=n-1; i>k; i--)
        {
            if(perm_nums.get(k) < perm_nums.get(i))
                break;
        }
        
        int temp = perm_nums.get(k);
        perm_nums.set(k, perm_nums.get(i));
        perm_nums.set(i, temp);
        
        for(int j=k+1; j<n; j++)
        {
            to_reverse.add(perm_nums.get(j));
        }
        
        if(to_reverse.size() > 1)
        {
            int h = to_reverse.size()-1;
            for(int j=k+1; j<n; j++)
            {
                perm_nums.set(j, to_reverse.get(h));
                h--;
            }
        }
        
        return perm_nums;
    }
    
    public static BigInteger HowManyPermutation(int n)
    {
        int r = n;
        return (Factorial(n).divide(Factorial(n-r)));
    }
    
    public static BigInteger Factorial(int n)
    {
        BigInteger num = new BigInteger(String.valueOf(1));
        
        for(int i=n; i>0; i--)
        {
            BigInteger bigI = new BigInteger(String.valueOf(i));
            num = num.multiply(bigI);
        }
        
        return num;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}