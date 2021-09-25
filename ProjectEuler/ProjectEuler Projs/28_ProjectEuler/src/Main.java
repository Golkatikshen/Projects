
import java.awt.Point;


public class Main 
{
    public static void main(String args[])
    {
        int N = 1001;
        int[][] matrix = new int[N][N];
        
        int n = 1;
        Point p = new Point(N/2, N/2);
        int dir = 0;
        
        int sum = -1;
        
        matrix[p.x][p.y] = n;
        while(n != N*N)
        {
            n++;
            switch(dir)
            {
                case 0: //DX
                    if(matrix[p.x+1][p.y] == 0)
                    {
                        p.x ++;
                        matrix[p.x][p.y] = n;
                        dir++;
                    }
                    else
                    {
                        p.y--;
                        matrix[p.x][p.y] = n;
                    }
                    break;
                    
                case 1: //GIU
                    if(matrix[p.x][p.y+1] == 0)
                    {
                        p.y ++;
                        matrix[p.x][p.y] = n;
                        dir++;
                    }
                    else
                    {
                        p.x++;
                        matrix[p.x][p.y] = n;
                    }
                    break;
                    
                case 2: //SX
                    if(matrix[p.x-1][p.y] == 0)
                    {
                        p.x --;
                        matrix[p.x][p.y] = n;
                        dir++;
                    }
                    else
                    {
                        p.y++;
                        matrix[p.x][p.y] = n;
                    }
                    break;
                    
                case 3: //SU
                    if(matrix[p.x][p.y-1] == 0)
                    {
                        p.y --;
                        matrix[p.x][p.y] = n;
                        dir=0;
                    }
                    else
                    {
                        p.x--;
                        matrix[p.x][p.y] = n;
                    }
                    break;
            }
        }
        
        
        for(int i=0; i<N; i++)
        {
            sum += matrix[i][i];
        }
        
        for(int i=N-1,j=0; j<N; i--,j++)
        {
            sum += matrix[j][i];
        }
        
        Out(sum);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}