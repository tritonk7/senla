@IsTest
private class UpdateForecastsSchedulableTest {
    private static String chr = '0 0 0 6 6 ? 2021';
    
    @IsTest
    private static void testExecute() {
        UpdateForecastsSchedulable executeSchedulable = new UpdateForecastsSchedulable();
        
        Test.startTest();
        String jobId = System.schedule('Run Forecast Update Process', chr, executeSchedulable);
        Test.stopTest();
        
        CronTrigger currentCR = [
            SELECT Id, 
            CronExpression,
            TimesTriggered, 
            NextFireTime
            FROM CronTrigger 
            WHERE id = :jobId
        ];     
        
        System.assertEquals(chr, currentCR.CronExpression);
        System.assertEquals(0, currentCR.TimesTriggered);
        System.assertEquals('2021-06-06 00:00:00', String.valueOf(currentCR.NextFireTime));
    }
}