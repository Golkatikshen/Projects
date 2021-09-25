
import java.io.*;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        BufferedReader reader = new BufferedReader(new FileReader("nums.txt"));
        
        String[] nums = new String[100];
        int[] somma = new int[100];
                
        for(int i=0; i<100; i++)
        {
            nums[i] = reader.readLine();
            somma[i] = 0;
        }
        
        int index = 0;
        for(int i=49; i>=0; i--)
        {
            for(int j=0; j<100; j++)
            {
                somma[index] += Integer.parseInt(String.valueOf(nums[j].charAt(i)));
            }
            index++;
        }
        

        String grande_somma = "";
        String temp;
        String temp_n;
        
        for(int i=0; i<100; i++)
        {
            temp_n = "";
            temp = String.valueOf(somma[i]);
            
            grande_somma += temp.charAt(temp.length()-1);
            
            for(int j=0; j<temp.length()-1; j++)
                temp_n += temp.charAt(j);
            
            if(!temp_n.equals(""))
                somma[i+1] += Integer.parseInt(temp_n);
        }
        
        temp = grande_somma;
        grande_somma = "";
        for(int i=99; i>=0; i--)
        {
            grande_somma += temp.charAt(i);
        }
        Out(grande_somma);
        
        temp = grande_somma;
        grande_somma = "";
        boolean rounding = true;
        for(int i=0; i<100; i++)
        {
            if(temp.charAt(i) != '0' || !rounding)
            {
                grande_somma += temp.charAt(i);
                rounding = false;
            }
        }
        Out(grande_somma);
        
        String primi10 = "";
        for(int i=0; i<10; i++)
            primi10 += grande_somma.charAt(i);

        Out(primi10);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
