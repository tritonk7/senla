public class TouristService {
    
    public static void markDuplicates(List<Tourists__c> newTourists) {
        newTourists = TouristManager.getNameEmailDuplicate();
        
        if (!newTourists.isEmpty() && newTourists != null) {
            List<Tourists__c> duplicateTourists = new List<Tourists__c> ();
            
            // creates a loop to iterate over tourists who entered the method
            for (Tourists__c oldList: newTourists) {
                Integer count = 0;
                
                // creates a loop to iterate over the second sheet to compare with the first
                for (Tourists__c newList: newTourists) {
                   
                    //if there is a match, the counter jumps to the next value for comparison
                    if (oldList.Tourist_Email__c == newList.Tourist_Email__c && oldList.Name == newList.Name) {
                        count++;
                        
                        //if the number of matches is greater than 1, updates these records with a duplicate flag
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