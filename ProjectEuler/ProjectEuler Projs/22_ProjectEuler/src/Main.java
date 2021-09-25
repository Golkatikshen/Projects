
import java.io.*;
import java.util.*;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        ArrayList<String> nomi = new ArrayList<>(0);
        
        BufferedReader reader = new BufferedReader(new FileReader("names.txt"));
        StringTokenizer st = new StringTokenizer(reader.readLine(), "\",\"");
        
        do{
            nomi.add(st.nextToken());
        }while(st.hasMoreTokens());
        
        int N = nomi.size();
        for(int i=0; i<N-1; i++)
        {
            for(int j=i; j<N; j++)
            {
                if(nomi.get(i).compareTo(nomi.get(j)) > 0)
                {
                    String temp = nomi.get(i);
                    nomi.set(i, nomi.get(j));
                    nomi.set(j, temp);
                }
            }
        }
        
        long sum_scores = 0;
        
        for(int i=0; i<N; i++)
        {
            sum_scores += Name_Score(nomi.get(i), i+1);
        }
        
        Out(sum_scores);
    }
    
    public static long Name_Score(String name, int p)
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
        
        score *= p;
        
        return score;
    }
            
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}