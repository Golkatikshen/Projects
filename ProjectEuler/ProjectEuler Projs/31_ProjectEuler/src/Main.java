
import java.io.*;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        int count = 0;
        int S2 = 200;
        
        PrintWriter pw = new PrintWriter(new FileWriter("coins_sum.txt"));
        
        for(int i=0; i<=S2/1; i++) 
        {
            for(int j=0; j<=S2/2; j++)
            {
                for(int k=0; k<=S2/5; k++)
                {
                    for(int h=0; h<=S2/10; h++)
                    {
                        for(int g=0; g<=S2/20; g++)
                        {
                            for(int f=0; f<=S2/50; f++)
                            {
                                for(int p=0; p<=S2/100; p++)
                                {
                                    for(int u=0; u<=S2/200; u++)
                                    {
                                        if(((i*1) + (j*2) + (k*5) + (h*10) + (g*20) + (f*50) + (p*100) + (u*200)) == 200)
                                        {
                                            count ++;
                                            pw.println(u + "x2£ + " + p + "x1£ + " + f + "x50p + " + g + "x20p + " + h + "x10p + " + k + "x5p + " + j + "x2p + " + i + "x1p");
                                            pw.flush();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        Out(count);
        pw.close();
    }
    
    /*public static void sum_up(ArrayList<Integer> numbers, int target)
    {
        sum_up_recursive(numbers, target, new ArrayList<Integer>());
    }
    
    public static void sum_up_recursive(ArrayList<Integer> numbers, int target, ArrayList<Integer> partial)
    {
        int s = 0;
        
        for(int i=0; i<partial.size(); i++)
            s += partial.get(i);
        
        if(s == target)
        {
            count ++;
            System.out.println("sum(" + Arrays.toString(partial.toArray()) + ") = " + target);
        }
        
        if(s >= target)
            return;
        
        for(int i=0; i<numbers.size(); i++)
        {
            ArrayList<Integer> remaining = new ArrayList<>(0);
            int n = numbers.get(i);
            
            for(int j=i+1; j<numbers.size(); j++)
                remaining.add(numbers.get(j));
            
            ArrayList<Integer> partial_rec = new ArrayList<>(partial);
            partial_rec.add(n);
            
            sum_up_recursive(remaining, target, partial_rec);
        }
    }*/
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}