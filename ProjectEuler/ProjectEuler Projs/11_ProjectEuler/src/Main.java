
import java.io.*;
import java.util.StringTokenizer;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        BufferedReader reader = new BufferedReader(new FileReader("nums.txt"));
        StringTokenizer st = new StringTokenizer(reader.readLine(), " ");
        
        final int N = 20;
        int[][] nums = new int[N][N];
        
        for(int i=0; i<N; i++)
        {
            for(int j=0; j<N; j++)
            {
                nums[j][i] = Integer.parseInt(st.nextToken());
            }
        }
        
        long max_product = 0;
        for(int i=0; i<N; i++)
        {
            for(int j=0; j<N; j++)
            {
                if(j >= 3)
                {
                    if(nums[j][i] * nums[j-1][i] * nums[j-2][i] * nums[j-3][i] > max_product)
                        max_product = nums[j][i] * nums[j-1][i] * nums[j-2][i] * nums[j-3][i];
                }
                    
                if(j <= 20-4)
                {
                    if(nums[j][i] * nums[j+1][i] * nums[j+2][i] * nums[j+3][i] > max_product)
                        max_product = nums[j][i] * nums[j+1][i] * nums[j+2][i] * nums[j+3][i];
                }
                    
                if(i >= 3)
                {
                    if(nums[j][i] * nums[j][i-1] * nums[j][i-2] * nums[j][i-3] > max_product)
                        max_product = nums[j][i] * nums[j][i-1] * nums[j][i-2] * nums[j][i-3];
                }
                    
                if(i <= 20-4)
                {
                    if(nums[j][i] * nums[j][i+1] * nums[j][i+2] * nums[j][i+3] > max_product)
                        max_product = nums[j][i] * nums[j][i+1] * nums[j][i+2] * nums[j][i+3];
                }
                    
                
                if(j >= 3 && i >= 3)
                {
                    if(nums[j][i] * nums[j-1][i-1] * nums[j-2][i-2] * nums[j-3][i-3] > max_product)
                        max_product = nums[j][i] * nums[j-1][i-1] * nums[j-2][i-2] * nums[j-3][i-3];
                }
                    
                if(j <= 20-4 && i >= 3)
                {
                    if(nums[j][i] * nums[j+1][i-1] * nums[j+2][i-2] * nums[j+3][i-3] > max_product)
                        max_product = nums[j][i] * nums[j+1][i-1] * nums[j+2][i-2] * nums[j+3][i-3];
                }
                    
                if(j >= 3 && i <= 20-4)
                {
                    if(nums[j][i] * nums[j-1][i+1] * nums[j-2][i+2] * nums[j-3][i+3] > max_product)
                        max_product = nums[j][i] * nums[j-1][i+1] * nums[j-2][i+2] * nums[j-3][i+3];
                }
                    
                if(j <= 20-4 && i <= 20-4)
                {
                    if(nums[j][i] * nums[j+1][i+1] * nums[j+2][i+2] * nums[j+3][i+3] > max_product)
                        max_product = nums[j][i] * nums[j+1][i+1] * nums[j+2][i+2] * nums[j+3][i+3];
                }
            }
        }
        
        Out(max_product);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}