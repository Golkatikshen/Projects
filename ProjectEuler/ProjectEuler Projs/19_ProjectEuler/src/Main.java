
public class Main 
{
    public static int count_days = 1;
    public static int count_months = 1;
    public static int count_years = 1900;
    
    public static void main(String args[])
    {
        int sat = 0;
        
        while(count_years != 2001)
        {  
            switch(count_months)
            {
                case 1:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                
                case 2:
                    if(count_years % 400 == 0 || (count_years % 100 != 0 && count_years % 4 == 0))
                    {
                        for(int i=1; i<=29; i++)
                        {
                            if(i == 1 && count_days == 6)
                                sat++;

                            IncD();
                        }
                        IncM();
                    }
                    else
                    {
                        for(int i=1; i<=28; i++)
                        {
                            if(i == 1 && count_days == 6)
                                sat++;

                            IncD();
                        }
                        IncM();
                    }
                    break;
                    
                case 3:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 4:
                    for(int i=1; i<=30; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 5:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 6:
                    for(int i=1; i<=30; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 7:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 8:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 9:
                    for(int i=1; i<=30; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 10:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 11:
                    for(int i=1; i<=30; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
                    
                case 12:
                    for(int i=1; i<=31; i++)
                    {
                        if(i == 1 && count_days == 6)
                            sat++;
                        
                        IncD();
                    }
                    IncM();
                    break;
            }
            
            if(count_years == 1900)
                    sat = 0;
            
            if(count_months == 1)
                IncY();
        }
        
        Out(sat);
    }
    
    public static void IncD()
    {
        if(count_days < 7)
            count_days ++;
        else
            count_days = 1;
    }
    
    public static void IncM()
    {
        if(count_months < 12)
            count_months ++;
        else
            count_months = 1;
    }
    
    public static void IncY()
    {
        count_years ++;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}