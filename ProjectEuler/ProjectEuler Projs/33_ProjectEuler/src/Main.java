
import java.util.ArrayList;


public class Main 
{
    static int prodotto_numeratori = 1;
    static int prodotto_denominatori = 1;
        
    public static void main(String args[])
    {
        ArrayList<Integer> numeratori = new ArrayList<>();
        ArrayList<Integer> denominatori = new ArrayList<>();
        
        for(int i=10; i<100; i++)
        {
            for(int j=10; j<100; j++)
            {
                if(Is_Curious(i, j))
                {
                    numeratori.add(i);
                    denominatori.add(j);
                }
            }
        }
        
        
        for(int i=0; i<numeratori.size(); i++)
        {
            prodotto_numeratori *= numeratori.get(i);
            prodotto_denominatori *= denominatori.get(i);
        }
        
        Out(prodotto_numeratori + "/" + prodotto_denominatori);
        MinimiTermini();       
        Out(prodotto_numeratori + "/" + prodotto_denominatori);
    }
    
    public static void MinimiTermini()
    {
        int massimo = Math.max(prodotto_numeratori, prodotto_denominatori);

        for(int i=massimo; i>1; i--)
        {
            if(prodotto_numeratori % i == 0 && prodotto_denominatori % i == 0)
            {
                prodotto_numeratori /= i;
                prodotto_denominatori /= i;
                i = 0;
            }
        }
    }
    
    public static boolean Is_Curious(int N, int D)
    {
        String sn = String.valueOf(N);
        String sd = String.valueOf(D);

        if(N >= D)
            return false;
        if(sn.contains(String.valueOf(sd.charAt(0))) && sn.contains(String.valueOf(sd.charAt(1))))
            return false;
        if(sn.charAt(0) == sn.charAt(1) || sd.charAt(0) == sd.charAt(1))
            return false;
        if(N % 10 == 0 || D % 10 == 0)
            return false;
        
        boolean entrambi = false;
        for(int i=0; i<10; i++)
        {
            if(sn.contains(String.valueOf(i)) && sd.contains(String.valueOf(i)))
                entrambi = true;
        }
        if(!entrambi)
            return false;
        
        float r1 = (float)N/D;
        float r2;
        
        for(int i=0; i<10; i++)
        {
            if(sn.contains(String.valueOf(i)) && sd.contains(String.valueOf(i)))
            {
                sn = sn.replace(String.valueOf(i), "");
                sd = sd.replace(String.valueOf(i), "");
            }
        }
        
        r2 = (float)Integer.parseInt(sn)/Integer.parseInt(sd);

        return (r1 == r2);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}