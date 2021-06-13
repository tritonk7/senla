public with sharing class TouristAssignmentCmpController {    
    
    @AuraEnabled
    public static List<Trip__c> fetchTrip(String touristsId) {
        List<Flight__c> flights = [
            SELECT Trip__c
            FROM Flight__c
            WHERE New_Tourist__c = :touristsId
        ];
        Set<String> tripId = new Set<String>();
        
        for (Flight__c item : flights) {
            tripId.add(item.Trip__c);
        }
        
        List<Trip__c> trips = [
            SELECT Id,
            Start_Data__c,
            End_Date__c,
            Departure_Space_Point__r.City__c,
            Name,
            Mininmum_Age__c,
            Seats__c
            FROM Trip__c
            WHERE Id != :tripId
            AND Start_Data__c > :Date.today() 
        ];
        
        return trips;
        
    }
    
    @AuraEnabled
    public static List<Flight__c> fetchFlights() {
        List<Flight__c> flights =  [
            SELECT Trip__c,
            New_Tourist__c
            FROM Flight__c
        ];
        
        return flights;
    }
    
    @AuraEnabled
    public static Flight__c createFlight(Id tripId, Id touristId) {
        Flight__c flight = new Flight__c(
            New_Tourist__c = touristId,
            Trip__c = tripId,
            Status__c = Constants.FLIGHT_STATUS_REQUESTED
        );
        insert flight;
        
        return flight;
    }
    
    @AuraEnabled
    public static List<Weather_Daily_Forecast__c> fetchWeather() {
        return [
            SELECT Id,
            Average_Temperature__c,
            Space_Point__r.City__c
            FROM Weather_Daily_Forecast__c
            WHERE Date__c = : Date.today()
        ];
    }
}