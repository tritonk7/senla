public class AsyncApexJobManager {
 
    public static List<AsyncApexJob> getById(Set<Id> asyncApexJobIds) {
        if (asyncApexJobIds == null || asyncApexJobIds.isEmpty()) {
            return new List<AsyncApexJob>();   
        }
        List<AsyncApexJob> asyncApexJobList = [
            SELECT Id, 
            ApexClass.Name 
            FROM AsyncApexJob 
            WHERE Id IN :asyncApexJobIds
            ];
        return asyncApexJobList;
    }
}