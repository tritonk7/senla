public class TripManager {
    
    public static Trip__c tripById(String tripId) {
        if (tripId == null || String.isBlank(tripId)) {
            return new Trip__c();
        }        
        return [
            SELECT Id,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id = :tripId
        ]; 
    }
    
    public static List<Trip__c> tripNotEqualById(Set<String> tripIds) {
        return [
            SELECT Id,
            Start_Data__c,
            End_Date__c,
            Departure_Space_Point__r.City__c,
            Name,
            Mininmum_Age__c,
            Seats__c
            FROM Trip__c
            WHERE Id != :tripIds
            AND Start_Data__c > :Date.today() 
        ];
    }
}