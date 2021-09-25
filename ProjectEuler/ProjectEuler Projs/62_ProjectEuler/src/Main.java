
import java.util.ArrayList;


public class Main
{
    public static void main(String[] args)
    {
        ArrayList<Long> cubes = new ArrayList<>();
        ArrayList<Integer> counts = new ArrayList<>();
        int N = 10000;
        
        for(int i=0; i<=N; i++)
            cubes.add((long)Math.pow(i, 3));
        
        Out(cubes.get(N) + "\n");
        
        int count;
        for(int i=0; i<=N; i++)
        {
            count = 0;
            for(int j=i+1; j<=N; j++)
            {
                if(StesseCifre(String.valueOf(cubes.get(i)), String.valueOf(cubes.get(j))))
                {
                    count ++;
                }
            }
            
            counts.add(count);
        }
        
        for(int i=0; i<counts.size(); i++)
        {
            if(counts.get(i) == 4)
                Out(i + " - " + (long)Math.pow(i, 3));
        }
    }
    
    
    public static boolean StesseCifre(String num1, String num2)
    {
        if(num1.length() != num2.length())
            return false;
        
        for(int i=0; i<10; i++)
        {
            if(HowMany(toChar(i), num1) != HowMany(toChar(i), num2))
                return false;
        }
        
        return true;
    }
    
    public static int HowMany(char d, String num)
    {
        int c = 0;
        
        for(int i=0; i<num.length(); i++)
        {
            if(num.charAt(i) == d)
                c++;
        }
        
        return c;
    }
    
    
    public static char toChar(int n)
    {
        return (String.valueOf(n).charAt(0));
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
