public class FlightManager {
    
    public static List<Flight__c> getTouristsNotRegistred() {
        
        return [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c = 0
        ];
    }
    
    public static List<Flight__c> getTouristsId() {
        
        return [
            SELECT New_Tourist__r.Active__c,
            New_Tourist__r.Id,
            Status__c
            FROM Flight__c
        ];
    }
    
    public static List<Flight__c> getFlightByTripAndTourist() {
        
        return [
            SELECT New_Tourist__r.Tourist_Age__c, 
            Trip__r.Start_Data__c, 
            Trip__r.Mininmum_Age__c
            FROM Flight__c
        ];
    }
    
}