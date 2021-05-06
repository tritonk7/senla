public class MetaDataManager {
    
    public static Set<String> getMetaEmails() {
        List<Email__mdt> meta = [
            SELECT Email__c
            FROM Email__mdt
        ];
        Set<String> email = new Set<String>();
        
        for (Email__mdt item : meta){
            email.add(item.Email__c);
        }
        return email;
    }   
}