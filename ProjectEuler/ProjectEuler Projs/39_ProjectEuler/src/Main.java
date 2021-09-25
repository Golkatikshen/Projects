
public class Main 
{
    public static void main(String args[])
    {
        int p;
        int n;
        int max = 0;
        int max_p = 0;
        
        for(p=0; p<=1000; p++)
        {
            n = 0;
            for(int i=1; i<=p; i++)
            {
                for(int j=1; j<=p;j++)
                {
                    for(int k=1; k<=p; k++)
                    {
                        if(i + j + k == p)
                        {
                            if(Is_Right_Angle_Triangle(i, j, k))
                                n++;
                        }
                    }   
                }
            }
            
            if(n > max)
            {
                max = n;
                max_p = p;
            }
        }
        
        Out(max_p);
    }
    
    public static boolean Is_Right_Angle_Triangle(int a, int b, int c)
    {
        
        double beta = Math.toDegrees(Math.asin((double)b/a));
        double gamma = Math.toDegrees(Math.asin((double)c/a));       
        
        if(beta == 0 || gamma == 0)
            return false;
        
        return (beta + gamma + 90 == 180);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}