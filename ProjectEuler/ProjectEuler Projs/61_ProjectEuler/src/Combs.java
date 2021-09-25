
import java.util.ArrayList;
import java.util.Arrays;


public class Combs
{
    public static ArrayList<Object[]> PermutazioniSenzaRipetizioni(ArrayList<Object> objs)
    {
        ArrayList<Object[]> combs = new ArrayList<>();
        
        for(int i=0; i<objs.size(); i++)
        {
            ArrayList<Object[]> al = PSR(new ArrayList<>(Arrays.asList(objs.get(i))), i, new ArrayList(objs));
            
            for(int j=0; j<al.size(); j++)
                combs.add(al.get(j));
        }
        
        return combs;
    }
    
    private static ArrayList<Object[]> PSR(ArrayList<Object> h, int to_remove, ArrayList<Object> to_use)
    {
        ArrayList<Object[]> combs = new ArrayList<>();
        to_use.remove(to_remove);
        
        if(to_use.isEmpty())
        {
            combs.add(h.toArray());
            return combs;
        }
        
        for(int i=0; i<to_use.size(); i++)
        {
            ArrayList<Object> newh = new ArrayList<>();
            newh.addAll(h);
            newh.add(to_use.get(i));
            
            ArrayList<Object[]> al = PSR(new ArrayList(newh), i, new ArrayList(to_use));
            
            for(int j=0; j<al.size(); j++)
                combs.add(al.get(j));
        }
        
        return combs;
    }
}
