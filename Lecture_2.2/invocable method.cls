public class NewInvoiceble {
    
    @InvocableMethod
    public static void invokeThisMethod(List<Flight__c> tourist) {
        tourist = [SELECT id, Trip__r.Mininmum_Age__c,New_Tourist__r.Tourist_Age__c, Trip__c FROM Flight__c WHERE Trip__c = null];
        List<Integer> touristAge = new List<Integer>();
        String tripId;
        system.debug(tourist);
        
        for (Flight__c s : tourist) {
            Integer m = integer.valueOf(s.New_Tourist__r.Tourist_Age__c);
            touristAge.add(m);
        }
        
        List<Flight__c>tourist1 = [SELECT Trip__r.Name, Trip__r.Mininmum_Age__c, Trip__c FROM Flight__c WHERE Trip__r.Mininmum_Age__c <=: touristAge limit 1];
        
        for (Flight__c s:tourist1) {
            tripId = s.Trip__r.Id;
        }
        
        List<Flight__c>tourist2 = [SELECT id, Trip__r.Mininmum_Age__c,New_Tourist__r.Tourist_Age__c, Trip__c FROM Flight__c where Trip__c = null];
        
        for (Flight__c s: tourist2) {
            s.Trip__c = tripId;
            upsert tourist2;
        }
    }
}