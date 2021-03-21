public class SearchTourist {
    
    @InvocableMethod(label='Searching tourists' description='Сreates flights for free a tourists')
    
    public static void searchTourists (List<Trip__c> searchTrip) {
        
        if (!searchTrip.isEmpty() && searchTrip != null) {
            Double minAgeForTrip = searchTrip[0].Mininmum_Age__c;
            List<Tourists__c> tourists = TouristManager.getIdNameAgeCount();
            List<Flight__c> newFlights = new List<Flight__c>();        
            
            for (Tourists__c value : tourists) {
                
                if (value.Tourist_Age__c >= minAgeForTrip && value.Upcoming_Flights_Count__c == 0) {
                    Flight__c newFlight = new Flight__c(
                        New_Tourist__c = value.Id,
                        Trip__c = searchTrip[0].Id,
                        Status__c = 'Accepted'
                    );
                    newFlights.add(newFlight);
                }
                
            }
            insert newFlights; 
        }
    }
}