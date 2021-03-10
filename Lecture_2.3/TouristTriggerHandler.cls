public class TouristTriggerHandler {
    
    public static void afterUpdate(List<Tourists__c> checkTourist) {
        List<Id> tourists = new List<Id>(); 
        
        for (Tourists__c a : checkTourist) {
            tourists.add(a.id);
        }
        
        List<FlIght__c> changeAppStatus = [
            SELECT Application_Status__c,
            New_Tourist__r.Active__c,
            New_Tourist__r.Id
            FROM Flight__c
            WHERE New_Tourist__r.id =: tourists];
        
        for (Flight__c a :changeAppStatus) {
            
            if (a.New_Tourist__r.Active__c != true){
                a.Application_Status__c = 'Declined';                  
                update changeAppStatus;
                
            } else {
                a.Application_Status__c = '';                  
                update changeAppStatus;
            }
        }
    }
}