public class SearchTourist {
    @InvocableMethod(label='Searching tourists' description='Сreates flights for free a tourists')
    
    public static void searchTourists (List<Trip__c> searchTrip) {
        Date compareDate = searchTrip[0].Start_Data__c;
        Double compareAge = searchTrip[0].Mininmum_Age__c;
        
        List<Tourists__c> tourists = [
            SELECT Id, Name 
            FROM Tourists__c 
            WHERE Tourist_Age__c >= :compareAge 
            AND Upcoming_Flights_Count__c = 0 
            AND ID 
            NOT IN (
                SELECT New_Tourist__c 
                FROM Flight__c 
                WHERE Trip__r.Start_Data__c = :compareDate)];
        
        List<Flight__c> newFlights = new List<Flight__c>();        
        
        for (Integer i = 0; i < tourists.size(); i++) {
            Id idTourist = tourists[i].Id;
            Flight__c newFlight = new Flight__c(
                New_Tourist__c = idTourist,
                Trip__c = searchTrip[0].Id
            );
            newFlights.add(newFlight);
        }
        insert newFlights; 
    }
}