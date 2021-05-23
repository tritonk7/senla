@IsTest
private class FlightManagerTest {
    private static List<Flight__c> newFlights;
    
    static {
        newFlights = TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void testGetTouristsNotRegistred() {
        List<Flight__c> result = FlightManager.getTouristsNotRegistred();
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetStatusTourist() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();        
        List<Flight__c> result = FlightManager.getStatusTourist(tourists);
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetStatusTouristIsNegative() {       
        List<Flight__c> result = FlightManager.getStatusTourist(null);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByTouristTripAges() {
        Map<Id, Flight__c> newflightsMap = new Map<Id, Flight__c>(); 
        List<Flight__c> getFlights = TestDataFactory.getFlights();
        for (Flight__c item : getFlights) {
            newflightsMap.put(item.Id,item);
        }
        List<Flight__c> result = FlightManager.getByTouristTripAges(newflightsMap);
        
        System.assertNotEquals(null, result);
        System.assertEquals(2, result.size());
    }
    
    @IsTest
    private static void testGetByTouristTripAgesIsNegative() {
        List<Flight__c> result = FlightManager.getByTouristTripAges(null);
        
        System.assertEquals(true, result.isEmpty());
    }  
}