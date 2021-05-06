@IsTest
private class FlightDeleteBatchTest {  
 
    @testSetup
    static void setup() {
        Map<Tourists__c, Integer> touristMap = new Map<Tourists__c, Integer>();  
        List<Flight__c> flights = new List<Flight__c> {
            new Flight__c(
                Status__c = 'Accepted',
                New_Tourist__c = 'a0G5g000000PZsREAW'),
                new Flight__c(
                    Status__c = 'Declined',
                    New_Tourist__c = 'a0G5g000000PZsREAW')
                };   
                    for (Flight__c item : flights) {
                        if (touristMap.containsKey(item.New_Tourist__r)) {
                            Integer count = touristMap.get(item.New_Tourist__r);
                            touristMap.put(item.New_Tourist__r, count + 1);
                        } else {
                            touristMap.put(item.New_Tourist__r, 1);
                        }
                    }
        System.assertEquals(1, touristMap.size());
        insert flights; 
    }
    
    @isTest static void test() {
        Test.startTest();
        FlightDeleteBatch MyBatch = new FlightDeleteBatch();
        Id batchId = Database.executeBatch(MyBatch);
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Flight__c WHERE Status__c = 'Accepted']);
        System.assertEquals(0, [SELECT count() FROM Flight__c WHERE Status__c = 'Declined']);
    }
}