public class FlightTriggerHandler {
    
    public static void beforeInsert (List<Flight__c> flight) {
        
        for (Flight__c a: flight) {
 
            Tourists__c tourist = [
                SELECT id, Tourist_Age__c
                FROM Tourists__c
                WHERE id = : a.New_Tourist__c
            ];
            
            Trip__c trip = [
                SELECT id, Mininmum_Age__c, Start_Data__c
                FROM Trip__c
                WHERE id = : a.Trip__c
            ];
            
            if (tourist.Tourist_Age__c < trip.Mininmum_Age__c) {
                a.New_Tourist__c.addError('Wrong Age for this flight');
            } 
            
            if (trip.Start_Data__c < date.today()) {
                a.Trip__c.addError('This flight departed');
                
            }
            
        }
    }
}