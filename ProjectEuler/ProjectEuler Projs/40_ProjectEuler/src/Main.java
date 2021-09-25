

public class Main 
{
    public static void main(String args[])
    {
        String decimal = "";
        int i = 0;
        
        do{
            decimal += String.valueOf(i);
            i++;
        }while(decimal.length() < 1000010);
        
        Out("\n" + (d(1, decimal) * d(10, decimal) * d(100, decimal) * d(1000, decimal) * d(10000, decimal) * d(100000, decimal) * d(1000000, decimal)));
    }
    
    public static int d(int n, String s)
    {
        return (Integer.parseInt(String.valueOf(s.charAt(n))));
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}