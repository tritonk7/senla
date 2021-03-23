public class FlightTriggerHandler {
    
    public static void afterInsert (Map<Id, Flight__c> newFlights) {
        
        if (!newFlights.IsEmpty() && newFlights != null){
            List<Flight__c> checkFlights = FlightManager.getFlightByTripAndTourist();
            
            for (Flight__c value :checkFlights) {
                
                if (value.New_Tourist__r.Tourist_Age__c < value.Trip__r.Mininmum_Age__c) {
                    newFlights.get(value.Id).New_Tourist__c.addError('Wrong Age for this flight');
                }
                if (Date.today() > value.Trip__r.Start_Data__c) {
                    newFlights.get(value.Id).Trip__c.addError('This flight departed');
                }
            }
        }
    }
}