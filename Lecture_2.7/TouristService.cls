public class TouristService {
    
    @future
    public static void markDuplicates(Set<Id> touristIds) {
        if (touristIds.isEmpty() || touristIds == null) return;
        List<Tourists__c> newTourists = TouristManager.getByIds(touristIds);
        Set<String> names = new Set<String>();
        Set<String> emails = new Set<String>();
        
        for (Tourists__c values : newTourists) {
            names.add(values.Name);
            emails.add(values.Tourist_Email__c);
        }
        List<Tourists__c> dupTourists = TouristManager.getNameEmailDuplicate(names, emails);
        
        for (Tourists__c newTourist : newTourists) {
            for (Tourists__c dupTourist : dupTourists) {
                Boolean isEmail = (newTourist.Tourist_Email__c == dupTourist.Tourist_Email__c);
                Boolean isName = (newTourist.Name == dupTourist.Name);
                Boolean isId = (newTourist.Id == dupTourist.Id);
                if (isEmail && isName && !isId) {
                    newTourist.IsDuplicate__c = true;
                }
            }
        }
        update newTourists;
    }
}