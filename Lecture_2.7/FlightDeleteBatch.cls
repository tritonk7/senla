public class FlightDeleteBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {
    private Map<Tourists__c, Integer> touristMap = new Map<Tourists__c, Integer>();
    
    public  Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Status__c, New_Tourist__r.Name ' +
            'FROM Flight__c ' +
            'WHERE Status__c = \'' + Constants.FLIGHT_STATUS_DECLINED + '\'' +  
            'OR CreatedDate < LAST_N_DAYS:' + Constants.DELETE_FLIGH_DAYS + ''
        );
    }
    
    public  void execute(Database.BatchableContext bc, List<Flight__c> scope) {
        
        for (Flight__c item : scope) {
            if (touristMap.containsKey(item.New_Tourist__r)) {
                Integer count = touristMap.get(item.New_Tourist__r);
                touristMap.put(item.New_Tourist__r, count + 1);
            } else {
                touristMap.put(item.New_Tourist__r, 1);
            }
        }
        delete scope;
    }
    
    public  void finish(Database.BatchableContext bc) {  
        EmailService.sendEmailMessage(touristMap);
    }   
}