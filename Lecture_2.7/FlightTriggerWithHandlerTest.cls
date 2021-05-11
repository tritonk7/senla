@IsTest
private class FlightTriggerWithHandlerTest {
    
    @IsTest
    private static void testOnBeforeInsert() { 
        Date birthday = Date.newInstance(2010, 01, 01);
        Integer minAge = 5;
        Date startDate = Date.newInstance(2021, 08, 08);
        Flight__c flight = TestDataFactory.createFlight(birthday, minAge, startDate);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(true, result.isSuccess());
        System.assertEquals(0, result.getErrors().size());
    } 
    
    @IsTest
    private static void testOnBeforeInsertDateError() { 
        Date birthday = Date.newInstance(2010, 01, 01);
        Integer minAge = 5;
        Date startDate = Date.newInstance(2010, 01, 01);
        Flight__c flight = TestDataFactory.createFlight(birthday, minAge, startDate);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(false, result.isSuccess());
        System.assertEquals(1, result.getErrors().size());
        System.assertEquals(Constants.ERROR_DATE, result.getErrors()[0].getMessage());
    }
    
    @IsTest
    private static void testOnBeforeInsertAgeError() {
        Date birthday = Date.newInstance(2010, 01, 01);
        Integer minAge = 20;
        Date startDate = Date.newInstance(2021, 06, 06);
        Flight__c flight = TestDataFactory.createFlight(birthday, minAge, startDate);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(false, result.isSuccess());
        System.assertEquals(1, result.getErrors().size());
        System.assertEquals(Constants.ERROR_AGE, result.getErrors()[0].getMessage());
    }
}