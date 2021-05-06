@isTest
private class FlightManagerTest {
    
    @isTest
    static void testGetTouristsNotRegistred() {
        TestDataFactory.createFlight();
        List<Flight__c> flight = FlightManager.getTouristsNotRegistred();
        System.assertEquals(0, flight.size());
    }
    
    @isTest
    static void testGetStatusTourist() {
        TestDataFactory.createFlight();
        List<Tourists__c> tourist = TestDataFactory.getTourists();
        System.assertEquals(1, tourist.size());
        List<Flight__c> flight = FlightManager.getStatusTourist(tourist);
        System.assertEquals(1, flight.size());
        flight = FlightManager.getStatusTourist(null);
        System.assertEquals(0, flight.size());
    }
    
    @isTest
    static void testGetByTouristTripAges() {
        Map<Id, Flight__c> newflightsMap = new Map<Id, Flight__c>(); 
        List<Flight__c> flight = FlightManager.getByTouristTripAges(null);
        System.assertEquals(0, flight.size());
        TestDataFactory.createFlight();
        List<Flight__c> getFlight = TestDataFactory.getFlights();
        for (Flight__c item : getFlight) {
            newflightsMap.put(item.Id,item);
        }
        flight = FlightManager.getByTouristTripAges(newflightsMap);
        System.assertEquals(1, newflightsMap.size());
    }
}