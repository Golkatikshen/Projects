
import java.io.*;
import java.util.*;


public class Main 
{
    public static void main(String args[]) throws IOException
    {
        BufferedReader reader = new BufferedReader(new FileReader("cipher.txt"));
        StringTokenizer st = new StringTokenizer(reader.readLine(), ",");
        
        ArrayList<String> words = new ArrayList<>();
        ArrayList<Integer> ascii_cryp = new ArrayList<>();
        ArrayList<Character> chars = new ArrayList<>();
        
        while(st.hasMoreTokens())
        {
            ascii_cryp.add(Integer.parseInt(st.nextToken()));
        }
        
        /*for(int h1=97; h1<123; h1++)
        {
            for(int h2=97; h2<123; h2++)
            {
                for(int h3=97; h3<123; h3++)
                {
                    int pcount = 0;
                    int pkey;
                    chars.clear();
                    for(int i=0; i<ascii_cryp.size(); i++)
                    {
                        if(pcount == 0)
                            pkey = h1;
                        else if(pcount == 1)
                            pkey = h2;
                        else
                            pkey = h3;
                        
                        chars.add(toChar(ascii_cryp.get(i) ^ pkey));
                        
                        if(pcount < 2)
                            pcount ++;
                        else
                            pcount = 0;
                    }
                    
                    String msg = "";
                    for(int i=0; i<chars.size(); i++)
                        msg += chars.get(i);
                    
                    words.clear();
                    st = new StringTokenizer(msg, " ");
                    
                    while(st.hasMoreTokens())
                        words.add(st.nextToken());
                    
                    int index = 4;
                    if(words.size() > index)
                    {
                        if(AllLetters(words.get(index)))
                            Out(h1 + " " + h2 + " " + h3 + " -> " + words.get(index) + "\n");
                    }
                }
            }
        }*/
        
        boolean exec = true;
        if(exec)
        {
            int h1 = 103, h2 = 111, h3 = 100;
            int pcount = 0;
            int pkey;
            chars.clear();
            for(int i=0; i<ascii_cryp.size(); i++)
            {
                if(pcount == 0)
                    pkey = h1;
                else if(pcount == 1)
                    pkey = h2;
                else
                    pkey = h3;

                chars.add(toChar(ascii_cryp.get(i) ^ pkey));

                if(pcount < 2)
                    pcount ++;
                else
                    pcount = 0;
            }

            String msg = "";
            for(int i=0; i<chars.size(); i++)
                msg += chars.get(i);

            words.clear();
            st = new StringTokenizer(msg, " ");

            while(st.hasMoreTokens())
                words.add(st.nextToken());

            for(int i=0; i<words.size(); i++)
            {
                if(i % 15 == 0)
                    Out("");
                
                System.out.print(words.get(i) + " ");
            }
            
            long sum = 0;
            Out("\n\n");
            for(int i=0; i<chars.size(); i++)
            {
                System.out.print(chars.get(i));
                sum += ((int)chars.get(i));
            }
            
            Out("\n\n");
            Out(sum);
        }
    }
    
    public static boolean AllLetters(String s)
    {
        for(int i=0; i<s.length(); i++)
        {
            if(!Character.isLetter(s.charAt(i)))
                return false;
        }
        
        return true;
    }
    
    public static char XOR_char_EnryDecry(int c, int key)
    {
        String c_bin = Dec_to_Bin(c);
        String key_bin = Dec_to_Bin(key);
        String xored = "";
        
        int j=0;
        for(int i=c_bin.length()-1; i>=0; i--)
        {
            xored += (char)(c_bin.charAt(i) ^ key_bin.charAt(j));
            
            j++;
            if(j == key_bin.length())
                j = 0;
        }
        
        return ((char)Bin_to_Dec(xored));
    }
    
    public static int Bin_to_Dec(String bin)
    {
        int dec = 0;
        
        int j = 0;
        for(int i=bin.length()-1; i>=0; i--)
        {
            dec += Integer.parseInt(String.valueOf(bin.charAt(i))) * Math.pow(2, j);
            j++;
        }
        
        return dec;
    }
    
    public static String Dec_to_Bin(int n)
    {
        int decimale = n;
        String risultato = "";
        
        do{
		risultato = (decimale % 2) + risultato;
		decimale = decimale / 2;
	}while(decimale >= 1);
        
        return risultato;
    }
    
    public static char toChar(int code)
    {
        if(code < 0)
            return ((char)0);
        
        if(code > 127)
            return ((char)0);
        
        return ((char)code);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}