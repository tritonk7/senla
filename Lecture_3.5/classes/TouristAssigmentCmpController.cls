public inherited sharing class TouristAssignmentCmpController {    
    
    @AuraEnabled
    public static List<Tourists__c> fetchTourist(String touristsId) {
       List<Tourists__c> tourist = TouristManager.getById(touristsId);
        
        return tourist;
    }
    
    @AuraEnabled
    public static List<Trip__c> fetchTrips(String touristsId) {
        List<Flight__c> flights = FlightManager.getByTouristId(touristsId);
        Set<String> tripIds = new Set<String>();
        
        for (Flight__c item : flights) {
            tripIds.add(item.Trip__c);
        }
        
        List<Trip__c> trips = TripManager.tripNotEqualById(tripIds);
        
        return trips;  
    }
    
    @AuraEnabled
    public static List<Flight__c> fetchFlights() {
        return FlightManager.allFlightsForTouristAssignment();
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
        return WeatherDailyForecastManager.getTodayWeather();
    }
}