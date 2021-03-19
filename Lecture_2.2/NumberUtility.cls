public class NumberUtility {
    
    public static List<Integer> getPrimeNums(Integer n) {
        if (n == null || n < 0) {
            return new List<Integer>();
        }
        
        List<Integer> primeNums = new List<Integer>();
        
        for (Integer i = 2; i < n; i++) {
            Integer k = 0;
            
            for (Integer j = 2; j <= i; j++) {
                if (math.mod(i, j) == 0)
                    k++;
            }
            
            if (k<2) {
                primeNums.add(i);
            }
        }
        return primeNums;
    }
    
    public static List<Integer> getFibonachiNums(Integer n) {
        if (n == null) {
            return new List<Integer>();
        }
        
        List<Integer> nums = new List<Integer>();
        integer nCurrent = 0;
        integer nPrev = 0;
        
        while (nCurrent <= n) {
            nums.add(nCurrent);
            
            if (nCurrent != 0) {
                Integer temp = nCurrent;
                nCurrent = nCurrent + nPrev;
                nPrev = temp;
                
            }else {
                nCurrent = nCurrent + 1;
            }
        }
        return nums;
    }
    
    public static Boolean isPolindrom(Long n) {
        if (n == null) {
            return false;
        }
        
        String valN = n.format();
        return (valN == valN.reverse());
    }
}