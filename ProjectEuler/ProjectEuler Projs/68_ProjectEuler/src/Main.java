
import java.util.ArrayList;


public class Main 
{
    public static void main(String[] args)
    {
        ArrayList<String> ss = new ArrayList();
        ArrayList<Long> ll = new ArrayList();
                
        int[] i = new int[10];
        for(i[0]=1; i[0]<=i.length; i[0]++)
        {
            Out(i[0]);
            for(i[1]=1; i[1]<=i.length; i[1]++)
                for(i[2]=1; i[2]<=i.length; i[2]++)
                    for(i[3]=1; i[3]<=i.length; i[3]++)
                        for(i[4]=1; i[4]<=i.length; i[4]++)
                            for(i[5]=1; i[5]<=i.length; i[5]++)
                                for(i[6]=1; i[6]<=i.length; i[6]++)
                                    for(i[7]=1; i[7]<=i.length; i[7]++)
                                        for(i[8]=1; i[8]<=i.length; i[8]++)
                                            for(i[9]=1; i[9]<=i.length; i[9]++)
                                            {
                                                if(tuttiDiversi(i))
                                                {
                                                    if((i[0] + i[1] + i[2] == i[3] + i[2] + i[4]) && (i[0] + i[1] + i[2] == i[5] + i[4] + i[6]) && (i[0] + i[1] + i[2] == i[7] + i[6] + i[8]) && (i[0] + i[1] + i[2] == i[9] + i[8] + i[1]))
                                                    {
                                                        String s;
                                                        if(i[0] < i[3] && i[0] < i[5] && i[0] < i[7] && i[0] < i[9])
                                                            s = i[0] + "" + i[1] + "" + i[2] + "" + i[3] + "" + i[2] + "" + i[4] + "" + i[5] + "" + i[4] + "" + i[6] + "" + i[7] + "" + i[6] + "" + i[8] + "" + i[9] + "" + i[8] + "" + i[1];
                                                        else
                                                        {
                                                            if(i[3] < i[5] && i[3] < i[7] && i[3] < i[9])
                                                                s = i[3] + "" + i[2] + "" + i[4] + "" + i[5] + "" + i[4] + "" + i[6] + "" + i[7] + "" + i[6] + "" + i[8] + "" + i[9] + "" + i[8] + "" + i[1] + "" + i[0] + "" + i[1] + "" + i[2];
                                                            else
                                                            {
                                                                if(i[5] < i[7] && i[5] < i[9])
                                                                    s = i[5] + "" + i[4] + "" + i[6] + "" + i[7] + "" + i[6] + "" + i[8] + "" + i[9] + "" + i[8] + "" + i[1] + "" + i[0] + "" + i[1] + "" + i[2] + "" + i[3] + "" + i[2] + "" + i[4];
                                                                else
                                                                {
                                                                    if(i[7] < i[9])
                                                                        s = i[7] + "" + i[6] + "" + i[8] + "" + i[9] + "" + i[8] + "" + i[1] + "" + i[0] + "" + i[1] + "" + i[2] + "" + i[3] + "" + i[2] + "" + i[4] + "" + i[5] + "" + i[4] + "" + i[6];
                                                                    else
                                                                        s = i[9] + "" + i[8] + "" + i[1] + "" + i[0] + "" + i[1] + "" + i[2] + "" + i[3] + "" + i[2] + "" + i[4] + "" + i[5] + "" + i[4] + "" + i[6] + "" + i[7] + "" + i[6] + "" + i[8];
                                                                }
                                                            }
                                                        }

                                                        if(!ss.contains(s))
                                                            ss.add(s);
                                                    }
                                                }
                                            }
        }
        
        for(int h=0; h<ss.size(); h++)
            if(ss.get(h).length() == 16)
                ll.add(Long.parseLong(ss.get(h)));
        
        long max = ll.get(0);
        for(int h=0; h<ll.size(); h++)
            if(max < ll.get(h))
                max = ll.get(h);
        
        Out(max);
    }
    
    public static boolean tuttiDiversi(int[] a)
    {
        for(int i=0; i<a.length-1; i++)
            for(int j=i+1; j<a.length; j++)
                if(a[i] == a[j])
                    return false;
        
        return true;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
