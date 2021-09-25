
public class Main 
{
    public static void main(String args[])
    {        
        int count = 0;
        long sum = 0;
        long n = 0;
        
        do{
            if(Is_Truncable_Prime(n))
            {
                Out(n);
                sum += n;
                count ++;
            }
            n++;
        }while(count != 11);
        
        Out("\n"+sum);
    }
    
    public static boolean Is_Truncable_Prime(long n)
    {
        if(n < 10)
            return false;
        
        String snum = String.valueOf(n);
        String temp;
        
        temp = snum;
        for(int i=0; i<snum.length(); i++)
        {
            if(!Is_Prime(Long.parseLong(temp)))
                return false;
            
            temp = Truncate(temp, "dx");
        }
        
        temp = snum;
        for(int i=0; i<snum.length(); i++)
        {
            if(!Is_Prime(Long.parseLong(temp)))
                return false;
            
            temp = Truncate(temp, "sx");
        }
        
        return true;
    }
    
    public static String Truncate(String s, String dir)
    {
        String temp = "";

        if(dir.equals("dx"))
        {
            for(int i=0; i<s.length()-1; i++)
                temp += s.charAt(i);
        }
        
        if(dir.equals("sx"))
        {
            for(int i=1; i<s.length(); i++)
                temp += s.charAt(i);
        }
        
        return temp;
    }
    
    public static boolean Is_Prime(long n)
    {
        if(n == 1)
            return false;
        
        boolean prime = true;
        
        for(long i=2; i<=Math.sqrt(n); i++)
        {
            if(n % i == 0)
            {
                prime = false;
                i = n; // break;
            }
        }
        
        return prime;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}