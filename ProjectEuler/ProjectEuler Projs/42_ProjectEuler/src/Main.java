
import java.io.*;
import java.util.StringTokenizer;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        BufferedReader reader = new BufferedReader(new FileReader("words.txt"));
        StringTokenizer st = new StringTokenizer(reader.readLine(), "\",\"");
        int count = 0;
        
        while(st.hasMoreTokens())
        {
            if(Is_Triangle_Word(st.nextToken()))
                count ++;
        }
        
        Out(count);
    }
    
    public static boolean Is_Triangle_Word(String w)
    {
        long n = Name_Value(w);
        
        for(int i=0; N_Triangle(i)<=n; i++)
        {
            if(n == N_Triangle(i))
                return true;
        }
        
        return false;
    }
    
    public static long N_Triangle(long n)
    {
        return (n*(n+1)/2);
    }
    
    public static long Name_Value(String name)
    {
        char[] lettere = new char[] {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
        int score = 0; 
        
        for(int i=0; i<name.length(); i++)
        {
            for(int j=0; j<lettere.length; j++)
            {
                if(name.charAt(i) == lettere[j])
                    score += j+1;
            }
        }

        return score;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}