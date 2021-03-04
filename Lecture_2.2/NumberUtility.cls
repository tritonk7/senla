/*Code for Anonymous:
Integer n = 10;
NumberUtility.getSimpleNumbers(n);
NumberUtility.getFibonachiNumbers(n);
NumberUtility.polyndromNumber(n);*/

public class NumberUtility {
    public static void getSimpleNumbers(Integer n) {
        List<Integer> simpleNum = new List<Integer>();
        
        for (Integer i = 2; i < n; i++) {
            Integer k = 0;
            
            for (Integer j = 2; j <= i; j++) {
                if (math.mod(i, j) == 0)
                    k++;
            }
            
            if (k<2) {
                simpleNum.add(i);
            }
        }
        System.debug(simpleNum);
    }
    
    public static void getFibonachiNumbers(Integer n) {
        integer nCurrent = 0;
        integer nPrev = 0;
        List<Integer> num = new List<Integer>();
        
        while (nCurrent <= n) {
            num.add(nCurrent);
            
            if (nCurrent != 0) {
                Integer temp = nCurrent;
                nCurrent = nCurrent + nPrev;
                nPrev = temp;
                
            }else {
                nCurrent = nCurrent + 1;
            }
        }
        System.debug(num);
    }
    
    public static void polyndromNumber(Integer n) {
        String valN = String.valueOf(n);
        Boolean isPolindrom = true;
        Integer index = 0;
        
        while (index < valN.length()) {
            
            if (valN.charAt(index) != valN.charAt(valN.length() - index - 1)) {
                isPolindrom = false;
                break;
            }
            index ++;
        }
        System.debug('Is the number: ' + valN +  ' polyndrom? - '  + isPolindrom);
    }
}