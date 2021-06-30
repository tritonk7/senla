public with sharing clas CustomLookUpController {
    
    @AuraEnabled
    public static List<sObject> fetchLookUpValues(String searchKeyWord, String objectName) {
        String searchKey = searchKeyWord + '%';
        
        List<sObject> returnList = new List<sObject> ();
         
        String sQuery =  'SELECT Id, Name, Tourist_Age__c from ' + ObjectName + ' WHERE Name LIKE: searchKey ORDER BY createdDate DESC limit 10';
        List<sObject> lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        
        return returnList;
    }
}