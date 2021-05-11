@IsTest
private class FlightDeleteBatchTest {
    private static List<Flight__c> newFlights;
    
    static{
        newFlights = TestDataFactory.createFlights();
    }
    
    @IsTest 
    private static void testExecuteBatch() {
        FlightDeleteBatch executeBatch = new FlightDeleteBatch();
        
        Test.startTest();
        Database.executeBatch(executeBatch);
        Test.stopTest();
        
        List<Flight__c> result = TestDataFactory.getFlights();
        
        System.assertEquals(1, result.size());
        System.assertEquals(1, [SELECT count() FROM Flight__c WHERE Status__c = 'Accepted']);
        System.assertEquals(0, [SELECT count() FROM Flight__c WHERE Status__c = :Constants.FLIGHT_STATUS_DECLINED]);
    }
}