public class FlightTriggerHandler {
    public static Boolean isFirstTime = true;
    
    public static void afterInsert (Map<Id, Flight__c> newFlightsMap) {
        List<Flight__c> checkFlights = FlightManager.getByTouristTripAges(newFlightsMap);
        
        for (Flight__c value :checkFlights) {
            if (value.New_Tourist__r.Tourist_Age__c < value.Trip__r.Mininmum_Age__c) {
                newFlightsMap.get(value.Id).New_Tourist__c.addError(Constants.ERROR_AGE);
            }
            if (Date.today() > value.Trip__r.Start_Data__c) {
                newFlightsMap.get(value.Id).Trip__c.addError(Constants.ERROR_DATE);
            }
        }
    }
}