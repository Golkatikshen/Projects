
import java.util.ArrayList;
import java.util.Arrays;


public class Main 
{
    public static void main(String[] args)
    {
        ArrayList<Object[]> objs = Combs.PermutazioniSenzaRipetizioni(new ArrayList<Object>(Arrays.asList("A", "B", "C")));
        
        for(int i=0; i<objs.size(); i++)
            Out(toString(objs.get(i)));
    }
    
    public static String toString(Object[] obj)
    {
        String s = "";
        
        for(int i=0; i<obj.length; i++)
            s += obj[i];
        
        return s;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
