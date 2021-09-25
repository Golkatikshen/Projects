
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;

public class U 
{
    //FUNZIONI UTILITY BASE
    public static boolean isPrime(long n)
    {
        long r = (int)Math.sqrt(n);
        
        for(int i=2; i<=r; i++)
        {
            if(n % i == 0)
                return false;
        }
        
        return true;
    }
    
    public static int maxIndexInArray(ArrayList v)
    {
        BigInteger max = (BigInteger)v.get(0);
        int index = 0;
        for(int i=0; i<v.size(); i++)
            if(max.compareTo((BigInteger)v.get(i)) == -1)
            {   
                max = (BigInteger)v.get(i);
                index = i;
            }
        
        return index;
    }
    
    public static boolean isSquare(BigInteger n)
    {
        BigInteger x = n.divide(new BigInteger("2"));
        ArrayList<BigInteger> seen = new ArrayList();
        seen.add(new BigInteger(x.toString()));
        
        while(!x.multiply(x).equals(n))
        {
            x = x.add(n.divide(x));
            x = x.divide(new BigInteger("2"));
            if(seen.contains(x))
             return false;
            else
             seen.add(new BigInteger(x.toString()));
        }
        
        return true;
    }

    public static boolean isSquare(long n)
    {
        return (Math.sqrt(n) % 1 == 0);
    }
    
    public static BigInteger sqrtBI(BigInteger x) 
    {
        BigInteger div = BigInteger.ZERO.setBit(x.bitLength()/2);
        BigInteger div2 = div;
        for(;;) 
        {
            BigInteger y = div.add(x.divide(div)).shiftRight(1);
            if (y.equals(div) || y.equals(div2))
                return y;
            div2 = div;
            div = y;
        }
    }
    
    public static BigDecimal sqrtBD(BigDecimal in, int scale)
    {
        BigDecimal sqrt = new BigDecimal(1);
        sqrt.setScale(scale + 3, RoundingMode.FLOOR);
        BigDecimal store = new BigDecimal(in.toString());
        boolean first = true;
        
        do{
            if (!first)
                store = new BigDecimal(sqrt.toString());
            else 
                first = false;
            
            store.setScale(scale + 3, RoundingMode.FLOOR);
            sqrt = in.divide(store, scale + 3, RoundingMode.FLOOR).add(store).divide(BigDecimal.valueOf(2), scale + 3, RoundingMode.FLOOR);
        }while (!store.equals(sqrt));
        
        return sqrt.setScale(scale, RoundingMode.FLOOR);
    }
    
    static long sumOfDigits(String num)
    {
        long sum = 0;
        for(int i=0; i<num.length(); i++)
            sum += Integer.parseInt(String.valueOf(num.charAt(i)));
        
        return sum;
    }
    
    public static long nFibonacci(int n)
    {
        if(n <= 3)
            return n;
        
        n -= 2;
        int numero = 2;
        int numero_prec = 1;
        int numero_temp;
        for(int i=0; i<n; i++)
        {
            numero_temp = numero;
            numero = numero + numero_prec;
            numero_prec = numero_temp;
        }
        
        return numero;
    }
    
    public static boolean isPalindrome(int n)
    {
        boolean palindrome = false;
        String sn = String.valueOf(n);
        
        if(sn.length() % 2 == 0)
        {
            int nc = sn.length() / 2;
            
            String part1 = "";
            String part2 = "";
            
            for(int i=0; i<sn.length(); i++)
            {
                if(i < nc)
                    part1 += sn.charAt(i);
                else
                    part2 += sn.charAt(i);
            }
            
            String temp = part2;
            part2 = "";
            for(int i=temp.length()-1; i>=0; i--)
                part2 += temp.charAt(i);
            
            if(part1.equals(part2))
                palindrome = true;
        }
        else
        {
            int nc = (int)(sn.length() / 2);
            
            String part1 = "";
            String part2 = "";
            
            for(int i=0; i<sn.length(); i++)
            {
                if(i < nc)
                    part1 += sn.charAt(i);
                else
                    part2 += sn.charAt(i);
            }
            
            String temp = part2;
            part2 = "";
            for(int i=temp.length()-1; i>0; i--)
                part2 += temp.charAt(i);
            
            if(part1.equals(part2))
                palindrome = true;
        }
        
        return palindrome;
    }
    
    
    
    //MATEMATICA COMBINATORIA
    public static ArrayList<Object[]> permutazioniSenzaRipetizioni(ArrayList<Object> objs)
    {
        ArrayList<Object[]> combs = new ArrayList<>();
        
        for(int i=0; i<objs.size(); i++)
        {
            ArrayList<Object[]> al = PSR(new ArrayList<>(Arrays.asList(objs.get(i))), i, new ArrayList(objs));
            
            for(int j=0; j<al.size(); j++)
                combs.add(al.get(j));
        }
        
        return combs;
    }
    
    private static ArrayList<Object[]> PSR(ArrayList<Object> h, int to_remove, ArrayList<Object> to_use)
    {
        ArrayList<Object[]> combs = new ArrayList<>();
        to_use.remove(to_remove);
        
        if(to_use.isEmpty())
        {
            combs.add(h.toArray());
            return combs;
        }
        
        for(int i=0; i<to_use.size(); i++)
        {
            ArrayList<Object> newh = new ArrayList<>();
            newh.addAll(h);
            newh.add(to_use.get(i));
            
            ArrayList<Object[]> al = PSR(new ArrayList(newh), i, new ArrayList(to_use));
            
            for(int j=0; j<al.size(); j++)
                combs.add(al.get(j));
        }
        
        return combs;
    }
    
    
    
    //RIPETIZIONI NEI NUMERI
    public static BigInteger repeatingNumber(BigInteger n)
    {
        String rep_n = "";
        String snum = String.valueOf(n);
        boolean rep = false;
        
        for(int i=0; i<snum.length(); i++)
        {
            for(int j=snum.length()-2; j>i; j--)
            {
                if(contains2(snum.substring(i), snum.substring(i, j)))
                {
                    rep = true;
                    rep_n = snum.substring(i, j);
                    i=snum.length();
                    j=i;
                }
            }
        }
        
        if(rep)
            return roudingRep(new BigInteger(rep_n));
        else
            return (new BigInteger(snum));
    }
    
    public static boolean contains2(String str, String s)
    {
        if(s.length() >= str.length())
            return false;

        int count = 0;
        for(int i=0; i<str.length(); )
        {
            if(str.length() < i + s.length())
                break;
            
            if(str.substring(i, i + s.length()).equals(s))
            {
                i+=s.length();
                count ++;
            }
            else
            {
                if(count != 0)
                    break;
                else
                    i++;
            }
        }
        
        return (count >= 2);
    }
    
    public static BigInteger roudingRep(BigInteger n)
    {
        String num = String.valueOf(n);
        String tr;
        
        for(int i=0; i<num.length(); i++)
        {
            tr = "";
            for(int j=0; j<i+1; j++)
                tr += num.charAt(j);
            
            if(tr.length()+tr.length() > num.length())
                break;
            
            if(num.substring(tr.length(), tr.length()+tr.length()).equals(tr))
                return (new BigInteger(tr));
        }
        
        return (new BigInteger(num));
    }
    
    
    
    //CONTINUED FRACTIONS
    public static Long[] continuedFraction(Double v, int max_n)
    {
        ArrayList<Long> cfn = new ArrayList();
        String[] splitter = v.toString().split("\\.");
        int count = 0;
        
        long n = Long.parseLong(splitter[0] + splitter[1]);
        long d = 1;
        for(int i=0; i<splitter[1].length(); i++)
            d *= 10;
        
        while(n % d != 0 && count < max_n)
        {
            cfn.add(n / d);
            long tmp = n % d;
            n = d;
            d = tmp;
            count ++;
        }
        cfn.add(n / d);
        
        Long[] ints = new Long[cfn.size()];
        ints = cfn.toArray(ints);
        return ints;
    }
    
    public static Long[] continuedFractionBD(BigDecimal v, int max_n)
    {
        ArrayList<Long> cfn = new ArrayList();
        String[] splitter = v.toString().split("\\.");
        int count = 0;
        
        BigInteger n = new BigInteger(splitter[0] + splitter[1]);
        BigInteger d = new BigInteger("1");
        for(int i=0; i<splitter[1].length(); i++)
            d = d.multiply(new BigInteger("10"));
        
        while(!n.mod(d).equals(new BigInteger("0")) && count < max_n)
        {
            cfn.add(Long.parseLong(n.divide(d).toString()));
            BigInteger tmp = n.mod(d);
            n = d;
            d = tmp;
            count ++;
        }
        
        Long[] ints = new Long[cfn.size()];
        ints = cfn.toArray(ints);
        return ints;
    }
}

