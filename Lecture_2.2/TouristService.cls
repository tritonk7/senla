public class TouristService {
    
    public static void markDuplicates(List<Tourists__c> newTourists) {
        newTourists = TouristManager.getNameEmailDuplicate();
        
        if (!newTourists.isEmpty() && newTourists != null) {
            List<Tourists__c> duplicateTourists = new List<Tourists__c> ();
            
            for (Tourists__c oldList: newTourists) {
                Integer count = 0;
                
                for (Tourists__c newList: newTourists) {
                    
                    if (oldList.Tourist_Email__c == newList.Tourist_Email__c && oldList.Name == newList.Name) {
                        count++;
                        
                        if (count > 1 && oldList.Id == newList.Id) {
                            newList.IsDuplicate__c = true;
                            duplicateTourists.add(newList);
                        }
                    }
                }
            }
            update duplicateTourists;
        }
    }
}