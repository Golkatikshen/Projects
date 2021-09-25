

public class Main 
{
    public static void main(String args[])
    {
        int primes = 0;
        int num_oblq = 1;
        int count_oblq = 0;
        int count = 0;
        int oblq = 2;
        int length = 1;
        float ratio = 100;
        int i = 1;
        
        do{
            if(count_oblq == oblq)
            {
                count_oblq = 0;
                count ++;
                
                if(Is_Prime(i))
                    primes ++;
                
                num_oblq ++;
            }
            
            count_oblq ++;
            
            if(count == 4)
            {
                count = 0;
                oblq += 2;
                length += 2;
                
                ratio = (float)primes / (float)num_oblq * 100f;
            }
            
            i++;
            
        }while(ratio > 10f);

        Out(length);
        Out(ratio + " %");
    }
    
    public static boolean Is_Prime(long n)
    {
        if(n == 1)
            return false;
        
        boolean prime = true;
        
        for(long i=2; i<=Math.sqrt(n); i++)
        {
            if(n % i == 0)
            {
                prime = false;
                i = n; // break;
            }
        }
        
        return prime;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    
    /*
        float ratio;
            
            long primes = 0;
            
            for(int i=0; i<N; i++)
            {
                if(Is_Prime(matrix[i][i]))
                    primes ++;
            }
            
            for(int i=N-1,j=0; j<N; i--,j++)
            {
                if(Is_Prime(matrix[j][i]))
                    primes ++;
            }
            
            ratio = (float)primes/(N*2-1)*100;
            //Out(ratio);
            
            N += 2;
            
        }while(ratio >= 10);

        N -= 2;
        Out(N);
    */
}