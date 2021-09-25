
import java.io.*;
import java.util.*;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        int[][] NUM_MATRIX = new int [15][15];
        
        BufferedReader reader = new BufferedReader(new FileReader("nums.txt"));
        StringTokenizer st;
        
        for(int i=0; i<15; i++)
        {
            int count = 0;
            st = new StringTokenizer(reader.readLine());
            do{
                NUM_MATRIX[count][i] = Integer.parseInt(st.nextToken());
                count ++;
            }while(st.hasMoreTokens());
        }
        
        int max_sum = 0;
        Random random = new Random();
        while(true)
        {
            int sum = 75;
            int count = 0;
            int y = 0;
            int x = 0;
            do{
                y++;
                switch(random.nextInt(2))
                {
                    case 0:
                        sum += NUM_MATRIX[x][y];
                        break;
                    case 1:
                        x++;
                        sum += NUM_MATRIX[x][y];
                        break;
                }
                count++;  
            }while(count < 14);
            
            if(sum > max_sum)
            {
                max_sum = sum;
                Out(max_sum);
            }
        }
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}