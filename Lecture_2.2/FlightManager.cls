public class FlightManager {
    
    public static List<Flight__c> getTouristsNotRegistred() {
        
        return [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c = 0
        ];
    }
    
    public static List<Flight__c> getStatusTourist(List<Tourists__c> newTourists) {
        
        if (newTourists == null || newTourists.isEmpty()) {
            return new List<Flight__c> ();
        }
        return  [
            SELECT Status__c,
            New_Tourist__c,
            New_Tourist__r.Active__c
            FROM Flight__c
            WHERE New_Tourist__r.Active__c = false 
            AND New_Tourist__c = :newTourists
            AND Status__c != 'Declined'
        ];
    }
    
    
    public static List<Flight__c> getByTouristTripId(Map<Id, Flight__c> newflights) {
        
        return [
            SELECT New_Tourist__r.Tourist_Age__c,
            Trip__r.Start_Data__c,
            Trip__r.Mininmum_Age__c
            FROM Flight__c
            WHERE ID IN: newFlights.keyset()      
        ];
    }
    
    public static List<Flight__c> getByCreatedDateAndStatus(List<Flight__c> scope) {
        if (scope == null && scope.isEmpty()) {
            return new List<Flight__c>();
        }
        return  [
            SELECT Id,
            New_Tourist__c
            FROM Flight__c 
            WHERE Id IN : scope 
            AND (Status__c = 'Declined' 
                 OR CreatedDate < LAST_N_DAYS : 29)
        ];
    }
    
}