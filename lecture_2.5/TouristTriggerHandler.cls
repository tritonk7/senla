public class TouristTriggerHandler {
    
    public static Boolean isFirstTime = true;
    
    public static void onAfterInsert(Map<Id,Tourists__c> newTourists) {
       
        if (newTourists == null || newTourists.isEmpty()) return;
        TouristService.markDuplicates(newTourists.keySet());
    }
    
    public static void onAfterUpdate(List<Tourists__c> newTourists) {
        
        if (newTourists == null || newTourists.isEmpty()) return;
        
        List<FlIght__c> changeStatus = FlightManager.getStatusTourist(newTourists);
        List<FlIght__c> updateStatus = new List<FlIght__c>();
        
        for (Flight__c a :changeStatus) {
            
            if (a.New_Tourist__r.Active__c != true){
                a.Status__c = 'Declined';                  
                updateStatus.add(a);
            }
            
        }
        update updateStatus;
    }
}