@IsTest
private class FlightDeleteScheduleTest {
    private static String chr = '0 0 0 4 8 ? 2021';
    
    @IsTest
    private static void testSchedule() {
        FlightDeleteSchedule executeBatch = new FlightDeleteSchedule();
        
        Test.startTest();
        String jobId = System.schedule('Run Flight Delete Process', chr, executeBatch);
        Test.stopTest();
        
        CronTrigger currentCT = [
            SELECT Id, 
            CronExpression,
            TimesTriggered, 
            NextFireTime
            FROM CronTrigger 
            WHERE Id = :jobId
        ];
        
        System.assertEquals(1, [SELECT count() FROM CronTrigger]);
        System.assertEquals(0, currentCT.TimesTriggered);
        System.assertEquals('2021-08-04 00:00:00', String.valueOf(currentCT.NextFireTime));
    }
}