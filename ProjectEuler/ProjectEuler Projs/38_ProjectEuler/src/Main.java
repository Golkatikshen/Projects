
import java.util.*;


public class Main 
{
    public static void main(String args[])
    {
        ArrayList<Integer> nums = new ArrayList<>();
        long max = 0;
        
        for(int i=0; i<100000; i++)
        {
            for(int j=1; j<10; j++)
            {
                nums.clear();
                for(int k=1; k<=j; k++)
                    nums.add(k);
                
                if(Is_Pandigital_Multiples(i, nums))
                {
                    if(Concatenating_Multiples(i, nums) > max)
                        max = Concatenating_Multiples(i, nums);
                }
            }
        }
        
        Out(max);
    }
    
    public static long Concatenating_Multiples(int n, ArrayList<Integer> nums)
    {
        ArrayList<String> smultiples = new ArrayList<>();
        String multiples = "";
        
        for(int i=0; i<nums.size(); i++)
            smultiples.add(String.valueOf(n*nums.get(i)));
        
        for(int i=0; i<smultiples.size(); i++)
            multiples += smultiples.get(i);
        
        return Long.parseLong(multiples);
    }
    
    public static boolean Is_Pandigital_Multiples(int n, ArrayList<Integer> nums)
    {
        ArrayList<String> smultiples = new ArrayList<>();
        String multiples = "";
        
        for(int i=0; i<nums.size(); i++)
            smultiples.add(String.valueOf(n*nums.get(i)));
        
        for(int i=0; i<smultiples.size(); i++)
            multiples += smultiples.get(i);
        
        
        if(multiples.length() > 9)
            return false;
        
        for(int i=1; i<10; i++)
        {
            if(!multiples.contains(String.valueOf(i)))
                return false;
        }
        
        return true;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}