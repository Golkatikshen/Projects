
public class Main 
{
    public static void main(String args[])
    {
        int somma = 0;
        int i = 1;
        
        while(NFibonacci(i) < 4000000)
        {
            if(NFibonacci(i) % 2 == 0)
                somma += NFibonacci(i);
            
            i++;
        }
        
        Out(somma);
    }
    
    public static int NFibonacci(int n)
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
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
