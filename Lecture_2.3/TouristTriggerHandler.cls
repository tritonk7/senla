public class TouristTriggerHandler {
    
    public static void afterUpdate(List<Tourists__c> checkTourist) {
        
        if (!checkTourist.isEmpty() && checkTourist != null){
            List<FlIght__c> changeStatus = FlightManager.getTouristsId();
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
}