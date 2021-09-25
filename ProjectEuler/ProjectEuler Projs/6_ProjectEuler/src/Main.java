
public class Main 
{
    public static void main(String args[])
    {
        int somma_dei_quadrati = 0;
        int quadrato_della_somma = 0;
        
        for(int i=1; i<=100; i++)
        {
            somma_dei_quadrati += Math.pow(i, 2);
            quadrato_della_somma += i;
        }
                
        quadrato_della_somma = (int)Math.pow(quadrato_della_somma, 2);
        int differenza = quadrato_della_somma - somma_dei_quadrati;
        
        Out(differenza);
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}
