
import java.io.*;
import java.util.*;


public class Main 
{
    static char[] cards_value = new char[] {'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'};
    static char[] cards_suit = new char[] {'H', 'D', 'C', 'S'};
    
    public static void main(String args[]) throws IOException
    {
        ArrayList<String[][]> hands = new ArrayList<>();      
        BufferedReader reader = new BufferedReader(new FileReader("poker.txt"));
        StringTokenizer st;
        String line = reader.readLine();  
        
        do{
            st = new StringTokenizer(line, " ");
            String[][] hand_ps = new String[2][5];
            
            for(int i=0; i<5; i++)
                hand_ps[0][i] = st.nextToken();
            for(int i=0; i<5; i++)
                hand_ps[1][i] = st.nextToken();
            
            hands.add(hand_ps);
            
            line = reader.readLine();
        }while(line != null); //hands.size() != 8);//
        
        for(int i=0; i<hands.size(); i++)
        {
            System.out.print("\nPlayer 1: ");
            for(int j=0; j<5; j++)
                System.out.print(hands.get(i)[0][j] + " ");
            
            System.out.print("   Player 2: ");
            for(int j=0; j<5; j++)
                System.out.print(hands.get(i)[1][j] + " ");
        }
        
        Out("\n\n" + hands.size() + " mani giocate.\n\n");
        
        
        int player1_wins = 0;
        for(int i=0; i<hands.size(); i++)
        {
            //Out(Check_Hands(hands.get(i)));
            if(Check_Hands(hands.get(i)) == 1)
                player1_wins ++;
        }
        
        Out("Il giocatore 1 ha vinto " + player1_wins + " mani.");
    }
    
    public static int Check_Hands(String[][] hands)
    {
        String[] p1_hand = hands[0];
        String[] p2_hand = hands[1];
        
        if(Scala_Reale(p1_hand) && !Scala_Reale(p2_hand))
            return 1;
        else if(!Scala_Reale(p1_hand) && Scala_Reale(p2_hand))
            return 2;
        
        
        if(Scala_Colore(p1_hand) && !Scala_Colore(p2_hand))
            return 1;
        else if(Scala_Colore(p1_hand) && Scala_Colore(p2_hand))
            return (Carta_Alta(p1_hand, p2_hand));
        else if(!Scala_Colore(p1_hand) && Scala_Colore(p2_hand))
            return 2;
        
        
        if(Poker(p1_hand) && !Poker(p2_hand))
            return 1;
        else if(Poker(p1_hand) && Poker(p2_hand))
        {
            if(VAL_Poker(p1_hand) > VAL_Poker(p2_hand))
                return 1;
            else if(VAL_Poker(p1_hand) < VAL_Poker(p2_hand))
                return 1;
        }
        else if(!Poker(p1_hand) && Poker(p2_hand))
            return 2;
        
        
        if(Full(p1_hand) && !Full(p2_hand))
            return 1;
        else if(Full(p1_hand) && Full(p2_hand))
        {
            if(VAL_Full(p1_hand) > VAL_Full(p2_hand))
                return 1;
            else if(VAL_Full(p1_hand) < VAL_Full(p2_hand))
                return 1;
        }
        else if(!Full(p1_hand) && Full(p2_hand))
            return 2;
        
        
        if(Colore(p1_hand) && !Colore(p2_hand))
            return 1;
        else if(Colore(p1_hand) && Colore(p2_hand))
            return (Carta_Alta(p1_hand, p2_hand));
        else if(!Colore(p1_hand) && Colore(p2_hand))
            return 2;
        
        
        if(Scala(p1_hand) && !Scala(p2_hand))
            return 1;
        else if(Scala(p1_hand) && Scala(p2_hand))
            return (Carta_Alta(p1_hand, p2_hand));
        else if(!Scala(p1_hand) && Scala(p2_hand))
            return 2;
        
        
        if(Tris(p1_hand) && !Tris(p2_hand))
            return 1;
        else if(Tris(p1_hand) && Tris(p2_hand))
        {
            if(VAL_Tris(p1_hand) > VAL_Tris(p2_hand))
                return 1;
            else if(VAL_Tris(p1_hand) < VAL_Tris(p2_hand))
                return 2;
        }
        else if(!Tris(p1_hand) && Tris(p2_hand))
            return 2;
        
        
        if(Doppia_Coppia(p1_hand) && !Doppia_Coppia(p2_hand))
            return 1;
        else if(Doppia_Coppia(p1_hand) && Doppia_Coppia(p2_hand))
        {
            if(VAL_Doppia_Coppia(p1_hand) > VAL_Doppia_Coppia(p2_hand))
                return 1;
            else if(VAL_Doppia_Coppia(p1_hand) < VAL_Doppia_Coppia(p2_hand))
                return 2;
        }
        else if(!Doppia_Coppia(p1_hand) && Doppia_Coppia(p2_hand))
            return 2;
        
        
        if(Coppia(p1_hand) && !Coppia(p2_hand))
            return 1;
        else if(Coppia(p1_hand) && Coppia(p2_hand))
        {
            if(VAL_Coppia(p1_hand) > VAL_Coppia(p2_hand))
                return 1;
            else if(VAL_Coppia(p1_hand) < VAL_Coppia(p2_hand))
                return 2;
        }
        else if(!Coppia(p1_hand) && Coppia(p2_hand))
            return 2;
        
        
        return (Carta_Alta(p1_hand, p2_hand));
    }
    
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    
    public static int VAL_Poker(String[] cards)
    {
        String values = Values(cards);
        int count;
        int return_val = 0;
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 4)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        return_val = h * 100;
                }
                
                for(int k=0; k<values.length(); k++)
                {
                    count = 0;

                    for(int j=0; j<values.length(); j++)
                    {
                        if(values.charAt(i) == values.charAt(j))
                            count ++;
                    }

                    if(count == 1)
                    {
                        for(int h=0; h<cards_value.length; h++)
                        {
                            if(values.charAt(k) == cards_value[h])
                                return (return_val += h);
                        }
                    }
                }
            }
        }
        
        return 0;
    }
    
    public static int VAL_Full(String[] cards)
    {
        String values = Values(cards);
        int count;
        int v3 = 0;
        int v2 = 0;
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 3)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        v3 = (h+1) * 100;
                }    
                
                for(int k=0; k<values.length(); k++)
                {
                    count = 0;

                    for(int j=0; j<values.length(); j++)
                    {
                        if(values.charAt(k) == values.charAt(j))
                            count ++;
                    }

                    if(count == 2)
                    {
                        for(int h=0; h<cards_value.length; h++)
                        {
                            if(values.charAt(k) == cards_value[h])
                                v2 = h;
                        }  
                        
                        return (v3 + v2);
                    }
                }
            }
        }
        
        return 0;
    }
    
    public static int VAL_Tris(String[] cards)
    {
        String values = Values(cards);
        int count;
        int return_val = 0;
        int val_mem = 0;
        int v = 0;
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 3)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        return_val = h * 10000;
                } 
                
                for(int k=0; k<values.length(); k++)
                {
                    count = 0;

                    for(int j=0; j<values.length(); j++)
                    {
                        if(values.charAt(i) == values.charAt(j))
                            count ++;
                    }

                    if(count == 1)
                    {
                        for(int h=0; h<cards_value.length; h++)
                        {
                            if(values.charAt(k) == cards_value[h])
                                val_mem = h;
                        }
                    }
                }
                
                for(int k=0; k<values.length(); k++)
                {
                    count = 0;

                    for(int j=0; j<values.length(); j++)
                    {
                        if(values.charAt(i) == values.charAt(j))
                            count ++;
                    }

                    if(count == 1)
                    {
                        for(int h=0; h<cards_value.length; h++)
                        {
                            if(values.charAt(k) == cards_value[h])
                                v = h;
                        }
                        
                        if(v != val_mem)
                        {
                            if(v > val_mem)
                            {
                                return_val += v*100;
                                return_val += val_mem;
                                return (return_val);
                            }
                            else
                            {
                                return_val += val_mem*100;
                                return_val += v;
                                return (return_val);
                            }
                        }
                    }
                }
            }
        }
        
        return 0;
    }
    
    public static int VAL_Doppia_Coppia(String[] cards)
    {
        String values = Values(cards);
        int count;
        int v = 0;
        int mem_1val = 0;
        int return_val = 0;
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 2)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                    {
                        return_val = h * 1000;
                        mem_1val = h;
                    }
                } 
            }
        }
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            
            if(count == 2)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        v = h;
                } 
                
                if(v != mem_1val)
                {
                    return_val += v * 100;
                }
            }
        }
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            
            if(count == 1)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        return (return_val + h);
                } 
            }
        }
        
        return 0;
    }
    
    public static int VAL_Coppia(String[] cards)
    {
        String values = Values(cards);
        int count;
        int vcoppia = 0;
        int v1 = 0;
        int v2 = 0;
        int v3 = 0;
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 2)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        vcoppia = h * 10000000;
                } 
            }
        }
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 1)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        v1 = h;
                } 
            }
        }
        
        for(int i=0; i<values.length(); i++)
        {
            count = 0;
            
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(i) == values.charAt(j))
                    count ++;
            }
            
            if(count == 1)
            {
                for(int h=0; h<cards_value.length; h++)
                {
                    if(values.charAt(i) == cards_value[h])
                        v2 = h;
                }
                
                if(v2 != v1)
                {
                    for(int k=0; k<values.length(); k++)
                    {
                        count = 0;

                        for(int j=0; j<values.length(); j++)
                        {
                            if(values.charAt(k) == values.charAt(j))
                                count ++;
                        }

                        if(count == 1)
                        {
                            for(int h=0; h<cards_value.length; h++)
                            {
                                if(values.charAt(k) == cards_value[h])
                                    v3 = h;
                            }
                            
                            if(v3 != v1 && v3 != v2)
                            {
                                if(v1 > v2 && v1 > v3)
                                {
                                    if(v2 > v3)
                                        return (vcoppia + v1*10000 + v2*100 + v3);
                                    else
                                        return (vcoppia + v1*10000 + v3*100 + v2);
                                }
                                
                                if(v2 > v1 && v2 > v3)
                                {
                                    if(v1 > v3)
                                        return (vcoppia + v2*10000 + v1*100 + v3);
                                    else
                                        return (vcoppia + v2*10000 + v3*100 + v1);
                                }
                                
                                if(v3 > v2 && v3 > v1)
                                {
                                    if(v2 > v1)
                                        return (vcoppia + v3*10000 + v2*100 + v1);
                                    else
                                        return (vcoppia + v3*10000 + v1*100 + v2);
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return 0;
    }
    
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    
    public static int Carta_Alta(String[] p1h, String[] p2h)
    {
        ArrayList<Integer> p1_hv = new ArrayList<>();
        ArrayList<Integer> p2_hv = new ArrayList<>();
        
        for(int i=0; i<p1h.length; i++)
        {
            for(int j=0; j<cards_value.length; j++)
            {
                if(p1h[i].charAt(0) == cards_value[j])
                    p1_hv.add(j);
                
                if(p2h[i].charAt(0) == cards_value[j])
                    p2_hv.add(j);
            }  
        }
        
        p1_hv = ALI_Sort(p1_hv);
        p2_hv = ALI_Sort(p2_hv);
        
        for(int i=0; i<p1_hv.size(); i++)
        {
            if(p1_hv.get(i) > p2_hv.get(i))
                return 1;
            else if(p1_hv.get(i) < p2_hv.get(i))
                return 2;
        }
        
        return 0;
    }
    
    public static boolean Coppia(String[] cards)
    {
        String values = Values(cards);
        int[] n_carte = N_Cards(values);
        
        for(int i=0; i<cards_value.length; i++)
        {
            if(n_carte[i] == 2)
                return true;
        }
        
        return false;
    }
    
    public static boolean Doppia_Coppia(String[] cards)
    {
        String values = Values(cards);
        int[] n_carte = N_Cards(values);
        int count = 0;
        
        for(int i=0; i<cards_value.length; i++)
        {
            if(n_carte[i] == 2)
                count ++;
        }
        
        return (count >= 2);
    }
    
    public static boolean Tris(String[] cards)
    {
        String values = Values(cards);
        int[] n_carte = N_Cards(values);
        
        for(int i=0; i<cards_value.length; i++)
        {
            if(n_carte[i] == 3)
                return true;
        }
        
        return false;
    }
    
    public static boolean Scala(String[] cards)
    {
        String values = Values(cards);
        int min_v = MIN_VAL_Card(cards);
        
        if(min_v > cards_value.length-5)
            return false;
         
        for(int i=min_v; i<min_v + 5; i++)
        {
            if(!values.contains(String.valueOf(cards_value[i])))
                return false;
        }
        
        return true;
    }
    
    public static boolean Colore(String[] cards)
    {
        for(int i=0; i<cards.length; i++)
        {
            if(cards[0].charAt(1) != cards[i].charAt(1))
                return false;
        }
        
        return true;
    }
    
    public static boolean Full(String[] cards)
    {
        return (Coppia(cards) && Tris(cards));
    }
    
    public static boolean Poker(String[] cards)
    {
        String values = Values(cards);
        int[] n_carte = N_Cards(values);
        
        for(int i=0; i<cards_value.length; i++)
        {
            if(n_carte[i] == 4)
                return true;
        }
        
        return false;
    }
    
    public static boolean Scala_Colore(String[] cards)
    {
        return (Scala(cards) && Colore(cards));
    }
    
    public static boolean Scala_Reale(String[] cards)
    {
        if(Colore(cards))
        {
            String values = Values(cards);
            
            for(int i=8; i<cards_value.length; i++)
            {
                if(!values.contains(String.valueOf(cards_value[i])))
                    return false;
            }
            
            return true;
        }
        
        return false;
    }
    
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
    
    public static int[] N_Cards(String values)
    {
        int[] n_carte = new int[cards_value.length];
        
        for(int i=0; i<cards_value.length; i++)
        {
            for(int j=0; j<values.length(); j++)
            {
                if(values.charAt(j) == cards_value[i])
                    n_carte[i] ++;
            }
        }
        
        return n_carte;
    }
    
    public static String Values(String[] cards)
    {
        String values = "";
        
        for(int i=0; i<cards.length; i++)
            values += cards[i].charAt(0);
        
        return values;
    }
   
    public static int MAX_VAL_Card(String[] cards)
    {
        int[] values = new int[5];
        int v_max = 0;
        
        for(int i=0; i<cards.length; i++)
        {
            for(int j=0; j<cards_value.length; j++)
            {
                if(cards[i].charAt(0) == cards_value[j])
                    values[i] = j;
            }
        }
        
        for(int i=0; i<values.length; i++)
        {
            if(values[i] > v_max)
                v_max = values[i];
        }
        
        return v_max;
    }
    
    public static int MIN_VAL_Card(String[] cards)
    {
        int[] values = new int[5];
        int v_min = 15;
        
        for(int i=0; i<cards.length; i++)
        {
            for(int j=0; j<cards_value.length; j++)
            {
                if(cards[i].charAt(0) == cards_value[j])
                    values[i] = j;
            }
        }
        
        for(int i=0; i<values.length; i++)
        {
            if(values[i] < v_min)
                v_min = values[i];
        }
        
        return v_min;
    }
    
    public static ArrayList<Integer> ALI_Sort(ArrayList<Integer> a)
    {
        for(int i=0; i<a.size()-1; i++)
        {
            for(int j=i; j<a.size(); j++)
            {
                if(a.get(i) < a.get(j))
                {
                    int tmp = a.get(i);
                    a.set(i, a.get(j));
                    a.set(j, tmp);
                }
            }
        }
        
        return a;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
}