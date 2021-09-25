
import java.math.BigInteger;


public class Main 
{
    public static void main(String args[])
    {
       int n = 0;
       do{
           n++;
       }while(N_Digit(N_Fibonacci(n)) != 1000);
       
       Out(n);
    }
    
    public static int N_Digit(BigInteger n)
    {
        String num = String.valueOf(n);
        
        return num.length();
    }
    
    public static BigInteger N_Fibonacci(int n)
    {
        BigInteger num = new BigInteger("1");
        
        if(n == 0)
            return (new BigInteger("0"));
        if(n == 1)
            return (new BigInteger("1"));
        if(n == 2)
            return (new BigInteger("1"));
        if(n == 3)
            return (new BigInteger("2"));
        if(n == 4)
            return (new BigInteger("3"));
        
        n -= 3;
        BigInteger numero = new BigInteger("2");
        BigInteger numero_prec = new BigInteger("1");
        BigInteger numero_temp;
        for(int i=0; i<n; i++)
        {
            numero_temp = numero;
            numero = numero.add(numero_prec);
            numero_prec = numero_temp;
        }
        
        return numero;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}