
public class Main 
{
    public static void main(String[] args)
    {
        int N = 1000000;
        int i_max = 2;
        float max = 2/U.totientEuler(2);
        
        for(int i=2; i<=N; i++)
        {
            float v = (float)i/(float)U.totientEuler(i);
            if(max < v)
            {
                max = v;
                i_max = i;
            }
        }
        
        Out(i_max);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
