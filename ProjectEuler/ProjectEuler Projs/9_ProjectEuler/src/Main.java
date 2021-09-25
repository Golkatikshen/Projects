
import java.util.ArrayList;
import java.util.StringTokenizer;


public class Main 
{
    public static void main(String args[])
    {
        ArrayList<String> somma_u_mille = new ArrayList<>(0);
        long triplet_product = 0;
        
        for(int i=1; i<1000; i++)
        {
            for(int j=1; j<1000; j++)
            {
                for(int k=1; k<1000; k++)
                {
                    if(i + j + k == 1000)
                        somma_u_mille.add(i + "," + j + "," + k);
                }
            }
        }
        
        StringTokenizer st;
        int a = 0;
        int b = 0;
        int c = 0;
        for(int i=0; i<somma_u_mille.size(); i++)
        {
            st = new StringTokenizer(somma_u_mille.get(i), ",");
            
            a = Integer.parseInt(st.nextToken());
            b = Integer.parseInt(st.nextToken());
            c = Integer.parseInt(st.nextToken());
            
            if(Math.pow(a, 2) + Math.pow(b, 2) == Math.pow(c, 2))
            {
                triplet_product = a * b * c;
                i = somma_u_mille.size();
            }
        }
        
        Out(a + "^2 + " + b + "^2 = " + c + "^2");
        Out(triplet_product);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}