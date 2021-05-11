public class TouristTriggerHandler {
    public static Boolean isFirstTime = true;
    
    public static void onAfterInsert(Map<Id,Tourists__c> newTouristMap) {
        TouristService.markDuplicates(newTouristMap.keySet());
    }
    
    public static void onAfterUpdate(List<Tourists__c> newTourists) {        
        List<Flight__c> changeStatus = FlightManager.getStatusTourist(newTourists);
        List<Flight__c> updateStatus = new List<FlIght__c>();
        
        for (Flight__c flight :changeStatus) {
            flight.Status__c = Constants.FLIGHT_STATUS_DECLINED;                  
            updateStatus.add(flight);
        }
        update updateStatus;
    } 
}