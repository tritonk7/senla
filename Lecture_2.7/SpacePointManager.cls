public class SpacePointManager {
    
    public static List<Space_Point__c> getSpacePoints() {
        return [
            SELECT Id, 
            City__c, 
            Latitude__c, 
            Longitude__c 
            FROM Space_Point__c
            WHERE Latitude__c != null
            AND Longitude__c  != null
        ];
    }
}