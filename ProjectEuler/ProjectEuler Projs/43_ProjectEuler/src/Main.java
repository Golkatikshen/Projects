
import java.util.ArrayList;


public class Main 
{
    public static void main(String args[])
    {
        long sum = 0;
        
        ArrayList<Long> nums = new ArrayList<>();
        ArrayList<Long> mem = new ArrayList<>();
        for(long i=0; i<10; i++)
        {
            nums.add(i);
            mem.add(0L);
        }
                
        for(int i=1; i<100000000; i++)
        {
            nums = nextPermutation(nums);

            if(!Equals(nums, mem))
            {
                String snum = "";
                for(int j=0; j<10; j++)
                    snum += String.valueOf(nums.get(j));

                long num = Long.parseLong(snum);
                if(Is_Pandigital(num))
                {
                    if(Is_SubString_Primes_Divisible(num))
                            sum += num;
                }
                
                for(int j=0; j<nums.size(); j++)
                    mem.set(j, nums.get(j));
            }
        }

        Out(sum);
    }
    
    public static boolean Equals(ArrayList<Long> a, ArrayList<Long> b)
    {
        if(a.size() != b.size())
            return false;
        
        for(int i=0; i<a.size(); i++)
        {
            if(!a.get(i).equals(b.get(i)))
                return false;
        }
        
        return true;
    }
    
    public static ArrayList<Long> nextPermutation(ArrayList<Long> nums)
    {
        ArrayList<Long> perm_nums = nums;
        ArrayList<Long> to_reverse = new ArrayList<>(0);
        
        int k;
        int i;
        int n = perm_nums.size();
        
        boolean already_max = true;
        for(k=n-2; k>=0; k--)
        {
            if(perm_nums.get(k) < perm_nums.get(k+1))
            {
                already_max = false;
                break;
            }
        }
        
        if(already_max)
            return perm_nums;
        
        for(i=n-1; i>k; i--)
        {
            if(perm_nums.get(k) < perm_nums.get(i))
                break;
        }
        
        long temp = perm_nums.get(k);
        perm_nums.set(k, perm_nums.get(i));
        perm_nums.set(i, temp);
        
        for(int j=k+1; j<n; j++)
        {
            to_reverse.add(perm_nums.get(j));
        }
        
        if(to_reverse.size() > 1)
        {
            int h = to_reverse.size()-1;
            for(int j=k+1; j<n; j++)
            {
                perm_nums.set(j, to_reverse.get(h));
                h--;
            }
        }
        
        return perm_nums;
    }
    
    public static boolean Is_SubString_Primes_Divisible(long n)
    {
        int[] primes = new int[] {2, 3, 5, 7, 11, 13, 17};
        String snum = String.valueOf(n);
        int num;
        
        for(int i=1; i<=7; i++)
        {
            num = Integer.parseInt(String.valueOf(snum.charAt(i)) + String.valueOf(snum.charAt(i+1)) + String.valueOf(snum.charAt(i+2)));
            if(num % primes[i-1] != 0)
                return false;
        }
        
        return true;
    }
    
    public static boolean Is_Pandigital(long n)
    {
        String num = String.valueOf(n);
        
        for(int i=0; i<num.length(); i++)
        {
            if(!num.contains(String.valueOf(i)))
                return false;
        }
        
        return true;
    }
    
    public static void Out(Object obj)
    {
        System.out.println(obj);
    }
    
    
    
    /*
        int[] n = new int[10];
        long c = 0;
        
        for(n[0]=1; n[0]<10; n[0]++)
        {
            Out(c);
            for(n[1]=0; n[1]<10; n[1]++)
            {
                for(n[2]=0; n[2]<10; n[2]++)
                {
                    for(n[3]=0; n[3]<10; n[3]++)
                    {
                        for(n[4]=0; n[4]<10; n[4]++)
                        {
                            
                            for(n[5]=0; n[5]<10; n[5]++)
                            {
                                for(n[6]=0; n[6]<10; n[6]++)
                                {
                                    for(n[7]=0; n[7]<10; n[7]++)
                                    {
                                        for(n[8]=0; n[8]<10; n[8]++)
                                        {
                                            for(n[9]=0; n[9]<10; n[9]++)
                                            {
                                                c++;
                                                
                                                String snum = "";
                                                for(int i=0; i<10; i++)
                                                    snum += String.valueOf(n[i]);
                                                
                                                long num = Long.parseLong(snum);
                                                
                                                if(Is_Pandigital(num))
                                                {
                                                    if(Is_SubString_Primes_Divisible(num))
                                                            sum += num;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }*/
        
        /*
        for(long i=1000000000; i<9999999999L; i++
        {
            if(Is_Pandigital(i))
            {
                if(Is_SubString_Primes_Divisible(i))
                    sum += i;
            }
        }
        */
}