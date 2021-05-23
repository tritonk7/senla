@IsTest
private class TouristTriggerTest {
    private static List<Flight__c> newFlights;
    
    static {
        newFlights = TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void testOnAfterInsert() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        
        Test.startTest(); 
        Database.insert(tourists, false);
        Test.stopTest();
        
        List<Tourists__c> touristIsDuplicate = [
            SELECT Id,
            Name,
            Tourist_Email__c
            FROM Tourists__c
            WHERE IsDuplicate__c = true
        ];
        
        System.assertNotEquals(null, touristIsDuplicate);
        System.assertEquals(1, touristIsDuplicate.size());
    }
    
    @IsTest
    private static void testOnAfterUpdate() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        
        Test.startTest();
        Database.update(tourists, false);
        Test.stopTest();
        
        List<Flight__c> flights = TestDataFactory.getFlights();
        
        System.assertNotEquals(null, flights);
        System.assertEquals(2, flights.size());
        System.assertEquals(Constants.FLIGHT_STATUS_DECLINED, flights[0].Status__c);
    }
}