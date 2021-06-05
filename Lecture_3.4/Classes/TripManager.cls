public class TripManager {
    
    public static Trip__c tripById(String tripId) {
        if (tripId == null || String.isBlank(tripId)) {
            return new Trip__c();
        }        
        return [
            SELECT Id,
            Mininmum_Age__c,
            Start_Data__c,
            End_Date__c
            FROM Trip__c
            WHERE Id = :tripId
        ]; 
    }
}