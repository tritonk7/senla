public class DeleteFlights implements Database.Batchable<sObject>, Database.Stateful {
    
    public  Map<Id, Integer> tourists = new Map<Id, Integer>();
    
    public  Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator(
            [
                SELECT Id,
                New_Tourist__c
                FROM Flight__c 
                WHERE Status__c = 'Declined'
                OR CreatedDate < LAST_N_DAYS : 29
            ]
        );
    }
    
    public  void execute(Database.BatchableContext bc, List<Flight__c> scope) {
        List<Flight__c> ids = FlightManager.getByCreatedDateAndStatus(scope);
        
        for (Flight__c value : ids) {
            Integer count = 0;
            
            if (tourists.containsKey(value.New_Tourist__c)) {
                count = tourists.get(value.New_Tourist__c) + 1;
                tourists.put(value.New_Tourist__c, count);
                
            } else {
                count++;
                tourists.put(value.New_Tourist__c, count);
                
            }
        }     
        delete ids;   
    }
    
    public  void finish(Database.BatchableContext bc) {  
        Map<Tourists__c, Integer> result = Converter.idToName(tourists);
        List<String> emails = TouristManager.getMetaEmails();
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(Constants.MAIL_SUBJECT);
        email.setToAddresses(emails);
        email.plainTextBody = ' ';
        
        for (Tourists__c tourist : result.keySet()) {
            email.plainTextBody += ' Tourist ' + tourist.Name + ' had  ' + result.get(tourist) + ' remote flights. ';
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }   
}