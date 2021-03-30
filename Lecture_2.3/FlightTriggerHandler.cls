public class FlightTriggerHandler {
    
    public static Boolean isFirstTime = true;
    
    public static void afterInsert (Map<Id, Flight__c> newFlights) {
        
        if (newFlights == null || newFlights.isEmpty()) return;
        
        List<Flight__c> checkFlights = FlightManager.getByTouristTripId(newFlights);
        
        for (Flight__c value :checkFlights) {
            
            if (value.New_Tourist__r.Tourist_Age__c < value.Trip__r.Mininmum_Age__c) {
                newFlights.get(value.Id).New_Tourist__c.addError(Constants.ERROR_AGE);
            }
            if (Date.today() > value.Trip__r.Start_Data__c) {
                newFlights.get(value.Id).Trip__c.addError(Constants.ERROR_DATE);
            }
        }
    }
}