public class BatchEventTriggerHandler {
    
    public static Boolean isFirstTime = true;
    
    public static void onAfterInsert (List<BatchApexErrorEvent> scope) {
        
        if (scope == null && scope.isEmpty()) return;
            
        Set<Id> asyncApexJobIds = new Set<Id>();
        
        for (BatchApexErrorEvent evt : scope) {
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }   
        Map<Id,AsyncApexJob> jobs = new Map<Id,AsyncApexJob>(
            [
                SELECT id, 
                ApexClass.Name 
                FROM AsyncApexJob 
                WHERE Id IN :asyncApexJobIds
            ]
        ); 
        List<Error_Log__c> records = new List<Error_Log__c>();
        
        for(BatchApexErrorEvent evt : scope){
            
            if (jobs.get(evt.AsyncApexJobId).ApexClass.Name == Constants.BATCH_CLASS_FOR_FLIGHTS) {
                
                for (String item : evt.JobScope.split(',')) {
                    Error_Log__c a = new Error_Log__c(
                        Records__c = (Id)item,
                        JobId__c = evt.AsyncApexJobId,
                        Error__c = evt.ExceptionType
                    );
                    records.add(a);
                }
            }
        }
        update records;
    }
}