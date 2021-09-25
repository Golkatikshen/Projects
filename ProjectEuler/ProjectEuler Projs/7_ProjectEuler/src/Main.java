
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {
        ArrayList<Integer> primi = new ArrayList<>(0);
        
        int primo = 3;
        primi.add(2);
        
        while(primi.size() != 10001)
        {
            boolean b_primo = true;
            int r = (int)Math.sqrt(primo);
            for(int i=2; i<=r; i++)
            {
                if(primo % i == 0)
                    b_primo = false;
            }
            
            if(b_primo)
                primi.add(primo);
            
            primo+=2;
        }
        
        Out(primi.get(primi.size()-1));
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}