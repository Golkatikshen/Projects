
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Random;


public class Main 
{
    static ArrayList<Integer> triangle = new ArrayList<>();
    static ArrayList<Integer> square = new ArrayList<>();
    static ArrayList<Integer> pentagonal = new ArrayList<>();
    static ArrayList<Integer> hexagonal = new ArrayList<>();
    static ArrayList<Integer> heptagonal = new ArrayList<>();
    static ArrayList<Integer> octagonal = new ArrayList<>();
    private static Object ArrayUtils;
    
    public static void main(String[] args)
    {
        int n = 0;
        
        do{
            if(String.valueOf(Triangle(n)).length() == 4)
                triangle.add(Triangle(n));
            n++;
        }while(String.valueOf(Triangle(n)).length() < 5);
        
        n=0;
        do{
            if(String.valueOf(Square(n)).length() == 4)
                square.add(Square(n));
            n++;
        }while(String.valueOf(Square(n)).length() < 5);
        
        n=0;
        do{
            if(String.valueOf(Pentagonal(n)).length() == 4)
                pentagonal.add(Pentagonal(n));
            n++;
        }while(String.valueOf(Pentagonal(n)).length() < 5);
        
        n=0;
        do{
            if(String.valueOf(Hexagonal(n)).length() == 4)
                hexagonal.add(Hexagonal(n));
            n++;
        }while(String.valueOf(Hexagonal(n)).length() < 5);
        
        n=0;
        do{
            if(String.valueOf(Heptagonal(n)).length() == 4)
                heptagonal.add(Heptagonal(n));
            n++;
        }while(String.valueOf(Heptagonal(n)).length() < 5);
        
        n=0;
        do{
            if(String.valueOf(Octagonal(n)).length() == 4)
                octagonal.add(Octagonal(n));
            n++;
        }while(String.valueOf(Octagonal(n)).length() < 5);
        
        long sumz = 0;
        
        ArrayList<Object[]> indexes = Combs.PermutazioniSenzaRipetizioni(new ArrayList<Object>(Arrays.asList(0, 1, 2, 3, 4, 5)));
        ArrayList<ArrayList<Integer>> sys = new ArrayList<>();
        sys.add(triangle);
        sys.add(square);
        sys.add(pentagonal);
        sys.add(hexagonal);
        sys.add(heptagonal);
        sys.add(octagonal);
        
        for(int index=0; index<indexes.size(); index++)
        {
            for(int i=0; i<sys.get((int)(indexes.get(index)[0])).size(); i++)
            {      
                for(int j=0; j<sys.get((int)(indexes.get(index)[1])).size(); j++)
                {
                    if(!String.valueOf(sys.get((int)(indexes.get(index)[0])).get(i)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[1])).get(j)).substring(0, 2)))
                        continue;
                    
                    for(int k=0; k<sys.get((int)(indexes.get(index)[2])).size(); k++)
                    {
                        if(!String.valueOf(sys.get((int)(indexes.get(index)[1])).get(j)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[2])).get(k)).substring(0, 2)))
                            continue;
                        
                        for(int h=0; h<sys.get((int)(indexes.get(index)[3])).size(); h++)
                        {
                            if(!String.valueOf(sys.get((int)(indexes.get(index)[2])).get(k)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[3])).get(h)).substring(0, 2)))
                                continue;
                            
                            for(int g=0; g<sys.get((int)(indexes.get(index)[4])).size(); g++)
                            {
                                if(!String.valueOf(sys.get((int)(indexes.get(index)[3])).get(h)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[4])).get(g)).substring(0, 2)))
                                    continue;
                                
                                for(int f=0; f<sys.get((int)(indexes.get(index)[5])).size(); f++)
                                {
                                    if(!String.valueOf(sys.get((int)(indexes.get(index)[4])).get(g)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[5])).get(f)).substring(0, 2)))
                                        continue;
                                    
                                    if(String.valueOf(sys.get((int)(indexes.get(index)[5])).get(f)).substring(2).equals(String.valueOf(sys.get((int)(indexes.get(index)[0])).get(i)).substring(0, 2)))
                                    {
                                        long sum = sys.get((int)(indexes.get(index)[0])).get(i) + sys.get((int)(indexes.get(index)[1])).get(j) + sys.get((int)(indexes.get(index)[2])).get(k) + sys.get((int)(indexes.get(index)[3])).get(h) + sys.get((int)(indexes.get(index)[4])).get(g) + sys.get((int)(indexes.get(index)[5])).get(f);
                                        Out(sys.get((int)(indexes.get(index)[0])).get(i) + " + " + sys.get((int)(indexes.get(index)[1])).get(j) + " + " + sys.get((int)(indexes.get(index)[2])).get(k) + " + " + sys.get((int)(indexes.get(index)[3])).get(h) + " + " + sys.get((int)(indexes.get(index)[4])).get(g) + " + " + sys.get((int)(indexes.get(index)[5])).get(f) + " = " + sum);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    public static boolean Conditions(int[] num)
    {
        for(int i=0; i<num.length; i++)
        {
            for(int j=0; j<num.length; j++)
            {
                if(i != j)
                {
                    if(num[i] == num[j])
                        return false;
                }
            }
        }
        
        ArrayList<Object> obj_nums = new ArrayList<>();
        for(int i=0; i<num.length; i++)
            obj_nums.add((Object)num[i]);
        
        ArrayList<Object[]> combs = Combs.PermutazioniSenzaRipetizioni(obj_nums);
        
        for(int g=0; g<combs.size(); g++)
        {
            for(int f=0; f<combs.get(g).length; f++)
                num[f] = (int)combs.get(g)[f];

            boolean nope = false;
            for(int i=0; i<num.length-1; i++)
            {
                if(!String.valueOf(num[i]).substring(2).equals(String.valueOf(num[i+1]).substring(0, 2)))
                    nope = true;
            }

            if(!nope)
            {
                if(String.valueOf(num[num.length-1]).substring(2).equals(String.valueOf(num[0]).substring(0, 2)))
                    return true;
            }
        }
        
        return false;
    }
    
    
    
    
    public static int Triangle(int n)
    {
        return (n*(n+1)/2);
    }
    
    public static int Square(int n)
    {
        return (n*n);
    }
    
    public static int Pentagonal(int n)
    {
        return (n*(3*n-1)/2);
    }
    
    public static int Hexagonal(int n)
    {
        return (n*(2*n-1));
    }
    
    public static int Heptagonal(int n)
    {
        return (n*(5*n-3)/2);
    }
    
    public static int Octagonal(int n)
    {
        return (n*(3*n-2));
    }
    
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
