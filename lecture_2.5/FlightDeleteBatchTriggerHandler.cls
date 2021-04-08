public class FlightDeleteBatchTriggerHandler {
    
    public static void onAfterInsert (List<BatchApexErrorEvent> errorEvents) {
        Set<Id> asyncApexJobIds = new Set<Id>();
        
        for (BatchApexErrorEvent evt : errorEvents) {
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }   
        Map<Id,AsyncApexJob> jobs = new Map<Id,AsyncApexJob>(AsyncApexJobManager.getById(asyncApexJobIds));
        List<Error_Log__c> records = new List<Error_Log__c>();
        
        for(BatchApexErrorEvent evt : errorEvents) {
            if (jobs.get(evt.AsyncApexJobId).ApexClass.Name == 'FlightDeleteBatch') {
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
        insert records;
    }
}