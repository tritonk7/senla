public with sharing clas CustomLookUpController {
    
    @AuraEnabled
    public static List<sObject> fetchLookUpValues(String searchKeyWord, String ObjectName) {
        String searchKey = searchKeyWord + '%';
        
        List<sObject> returnList = new List<sObject> ();
         
        String sQuery =  'select id, Name, Tourist_Age__c from ' + ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 10';
        List<sObject> lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        
        return returnList;
    }
}