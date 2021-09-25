
import java.io.BufferedReader;
import java.io.FileReader;

public class Main 
{
    static int[][] triangle;
            
    public static void main(String[] args) throws Exception
    {
        FileReader f = new FileReader("triangle.txt");
        BufferedReader file = new BufferedReader(f);
        
        triangle = new int[100][];
        for(int i=0; i<100; i++)
            triangle[i] = new int[i+1];
        
        for(int i=0; i<100; i++)
        {
            String s = file.readLine();
            String[] ss = s.split(" ");
            for(int j=0; j<i+1; j++)
                triangle[i][j] = Integer.parseInt(ss[j]);
        }
        
        
        long sum = 0;
        int index_prec = 0;
        int sight_range = 17;
        
        for(int i=0; i<99; i++)
        {
            sum += triangle[i][index_prec];
            if(see(triangle[i+1][index_prec], i+1, index_prec, sight_range) < see(triangle[i+1][index_prec+1], i+1, index_prec+1, sight_range))
                index_prec++;
        }
        sum += triangle[99][index_prec];
        
        Out("Res: " + sum);
    }

    public static int see(int sum, int ir, int ic, int deep)
    {
        if(deep == 0 || (deep >= 1 && ir == 99))
            return sum;
        else
        {
            if(see(sum + triangle[ir+1][ic], ir+1, ic, deep-1) > see(sum + triangle[ir+1][ic+1], ir+1, ic+1, deep-1))
                return see(sum + triangle[ir+1][ic], ir+1, ic, deep-1);
            else
                return see(sum + triangle[ir+1][ic+1], ir+1, ic+1, deep-1);
        }
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
