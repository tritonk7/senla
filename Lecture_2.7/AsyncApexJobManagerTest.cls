@Istest
private class AsyncApexJobManagerTest {
    private static String chr = '0 0 0 * * ?';
    private static List<Flight__c> newFlights;
    
    static {
        newFlights = TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void testGetById() { 
        Set<Id> jobIds = new Set<Id>();
        FlightDeleteSchedule executeBatch = new FlightDeleteSchedule(); 
        
        Test.StartTest();	
        String jobId = System.schedule('Run procces delete flights', chr, executeBatch);
        Test.stopTest();  
        
        List<AsyncApexJob> asyncApexJobList  = [
            SELECT Id, 
            ApexClass.Name 
            FROM AsyncApexJob 
        ];
        
        for (AsyncApexJob item : asyncApexJobList) {
            jobIds.add(item.Id);
        }    
        List<AsyncApexJob> result = AsyncApexJobManager.getById(jobIds);
        
        System.assertNotEquals(null, result);
        System.assertEquals(2, result.size());
        System.assertEquals('FlightDeleteSchedule', result[0].ApexClass.Name); 
        System.assertEquals('FlightDeleteBatch', result[1].ApexClass.Name);
    }
    
    @IsTest
    private static void testGetByIdIsNegative() {    
        List<AsyncApexJob> result = AsyncApexJobManager.getById(null); 
        
        System.assertEquals(true, result.isEmpty());
        System.assertEquals(0, result.size());  
    }
}