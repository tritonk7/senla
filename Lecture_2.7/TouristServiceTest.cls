@IsTest
private class TouristServiceTest {
    private static List<Tourists__c> newTourists;
    
    static {
        newTourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testMarkDuplicates() {
        Map<Id, Tourists__c> newTouristsMap = new Map<Id, Tourists__c> (newTourists);
        
        Test.startTest ();
        TouristService.markDuplicates(newTouristsMap.keyset());
        Test.stopTest ();
        
        List<Tourists__c> touristIsDuplicate = [
            SELECT IsDuplicate__c
            FROM Tourists__c
            WHERE IsDuplicate__c = true
        ];
        
        System.assertNotEquals(null, touristIsDuplicate);
        System.assertEquals(1, touristIsDuplicate.size());
    }
    
    @IsTest
    private static void testMarkDuplicatesIsNegative() {
        List<Tourists__c> tourists = new List<Tourists__c>();
        Map<Id, Tourists__c> newTouristsMap = new Map<Id, Tourists__c>(tourists);
        
        Test.startTest ();
        TouristService.markDuplicates(newTouristsMap.keyset());
        Test.stopTest ();
        
        List<Tourists__c> touristIsDuplicate = [
            SELECT IsDuplicate__c
            FROM Tourists__c
            WHERE Id = :tourists
            AND IsDuplicate__c = true
        ];
        
        System.assertEquals(true, touristIsDuplicate.isEmpty());
    }
}