
import java.util.ArrayList;


public class Main
{
    static ArrayList<Integer> ints;
    static Fraction fra;
    
    public static void main(String[] args)
    {
        ints = new ArrayList();
        
        ints.add(2);
        for(int i=0; i<60; i++)
        {
            ints.add(1);
            ints.add(2*(i+1));
            ints.add(1);
        }
        
        for(int i=ints.size()-1; i>=100; i--)
            ints.remove(i);
        
        fra = new Fraction(1, ints.get(ints.size()-1));
        
        for(int i=ints.size()-2; i>=0; i--)
        {
            fra.sumVal(ints.get(i));
            fra.reciprocal();
        }
        fra.reciprocal();
        
        Out(fra.toString());
        Out(sumOfDigits(fra.num.toString()));
    } 
    
    static long sumOfDigits(String num)
    {
        long sum = 0;
        for(int i=0; i<num.length(); i++)
            sum += Integer.parseInt(String.valueOf(num.charAt(i)));
        
        return sum;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
