
public class Main 
{
    public static void main(String args[])
    {
        boolean trovato;
        int n = 0;
        
        do{
            n+=20;
            trovato = true;
            for(int i=1; i<=20; i++)
            {
                if(n % i != 0)
                    trovato = false;
            }       
        }while(!trovato);
        
        Out(n);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}