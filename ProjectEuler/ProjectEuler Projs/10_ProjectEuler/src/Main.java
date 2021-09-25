
public class Main 
{
    public static void main(String args[])
    {
        long somma = 2;
        boolean primo;
        
        for(int i=3; i<2000000; i+=2)
        {
            primo = true;
            int r = (int)Math.sqrt(i);
            for(int j=2; j<=r; j++)
            {
                if(i % j == 0)
                    primo = false;
            }
            
            if(primo)
                somma += i;
        }
        
        Out(somma);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}