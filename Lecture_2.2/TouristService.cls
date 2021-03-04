/*Code For Anonymous:
List<Tourists__c> newTourists = new List<Tourists__c>();
Tourists__C newAcct = new Tourists__C();
newAcct.name = 'Stas';
Date mydate = Date.parse('05/11/1985');
newAcct.Birthday__c = mydate;
newAcct.Tourist_Email__c = 'soulbow@tut.by';
insert newAcct;
TouristService.markDuplicates(newTourists);*/

public class TouristService {
    public static void markDuplicates(List<Tourists__c> newTourists) {
        newTourists = [SELECT Name, Tourist_Email__c FROM Tourists__c];      
        List<String> newTouristsName = new List<String>();
        Set<String> checkDuplicatesName = new Set<String>();
        List<String> newTouristsEmail = new List<String>();
        Set<String> checkDuplicatesEmail = new Set<String>();
        List<String> names = new List<String>();
        List<String> emails = new List<String>();
        
        for (Tourists__c value : newTourists) {
            String name = value.Name;
            String email = value.Tourist_Email__c;
            newTouristsName.add(name);
            newTouristsEmail.add(email);  
        }    
        
        for (Integer i = 0; i < newTouristsName.size(); i++) {
            String items = newTouristsName.get(i);
            
            if (!checkDuplicatesName.add(items)) {
                names.add(items);
            }
        }
        
        for (Integer i = 0; i < newTouristsEmail.size(); i++) {
            String items = newTouristsEmail.get(i);
            
            if (!checkDuplicatesEmail.add(items)) {
                checkDuplicatesEmail.add(items);
                emails.add(items);
            }
        } 
        
        List<Tourists__c> duplicateTourists = [SELECT Name, Tourist_Email__c, IsDuplicate__c FROM Tourists__c WHERE Name =: names AND Tourist_Email__c =: emails];
        
        for(Tourists__c i : duplicateTourists) {
            i.IsDuplicate__c = true;
            update duplicateTourists;         
        }
    }
}