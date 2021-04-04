public class Converter {
    
    public static Map<Tourists__c, Integer> idToName(Map<Id, Integer> tourists) {
        List<Tourists__c> touristNames = TouristManager.getIds(tourists.keySet());
        Map<Tourists__c, integer> result = new Map<Tourists__c, Integer>();
        
        for (Tourists__c tourist : touristNames) {
            result.put(tourist, tourists.get(tourist.id));
        }
        
        return result; 
    }
}