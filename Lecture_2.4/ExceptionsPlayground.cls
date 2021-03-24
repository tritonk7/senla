public class ExceptionsPlayground {
    public class CustomException extends Exception {}
    
    //For Anonymous Code
    //ExceptionHw.createCustomException();
    public static void createCustomException() {
        try { 
            Tourists__c acc = new Tourists__c();
            acc.Birthday__c = Date.today();
            if (acc.Name == null) {
                throw new CustomException('The Name not inserted!');
            } else {
                insert acc;
            }  
        } catch(CustomException cEx) {
            throw cEx;
        }
    }
    
    //For Anonymous Code
    //ExceptionHw.createDmlException();
    public static void createDmlException() {   
        try {
            Tourists__c acc = new Tourists__c();
            acc.Name = 'Simba';
            insert acc;
        } catch (DmlException dEx) {
            throw dEx;
            
        }
    }
    
    //For Anonymous Code
    //ExceptionHw.createDmlException();    
    public static void createOverwhelmingException() {
        try {
            ExceptionsPlayground.createCustomException();
            ExceptionsPlayground.createDmlException();
        } catch(Exception ex) {
            Tourists__c acc = new Tourists__c(Name = 'New User', Birthday__c = Date.today());
            insert acc;
            System.debug('Tourist with name: '+ acc.name + ' and Date Birthday: ' + acc.Birthday__c + ' was inserted!');
        }
    }
}