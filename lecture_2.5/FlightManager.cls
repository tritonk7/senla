public class FlightManager {
    
    public static List<Flight__c> getTouristsNotRegistred() {
        return [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c =: Constants.NUMB_ZERO
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
            AND New_Tourist__c =: newTourists
            AND Status__c != : Constants.FLIGHT_STATUS_DECLINED
        ];
    }
    
    public static List<Flight__c> getByTouristTripAges(Map<Id, Flight__c> newflightsMap) {
        if (newflightsMap == null || newflightsMap.isEmpty()) {
            return new List<Flight__c> ();
        }
        return [
            SELECT New_Tourist__r.Tourist_Age__c,
            Trip__r.Start_Data__c,
            Trip__r.Mininmum_Age__c
            FROM Flight__c
            WHERE ID IN: newflightsMap.keyset()      
        ];
    }  
}