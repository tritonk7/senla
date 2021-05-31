@IsTest
private class WeatherForecastUpdaterTest {
    private static List<Weather_Daily_Forecast__c> newWeather;
    
    static {
        newWeather = TestDataFactory.createWeather();
    }
    
    @IsTest
    private static void testUpdateForecastsIsSuccess() {
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsSuccess());
        List<Weather_Daily_Forecast__c> weatherFromDB = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertEquals(newWeather[0].Id, weatherFromDB[0].Id);
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> checkOldWeather = [
            SELECT Space_Point__r.Id 
            FROM Weather_Daily_Forecast__c 
            WHERE Space_Point__r.Id = :weatherFromDB[0].Id
        ];
        
        System.assertEquals(true, checkOldWeather.isEmpty());
        
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
        System.assertNotEquals(newWeather[0].Id, result[0].id);
    }
    
    @IsTest
    private static void testUpdateForecastsIsNegative() {
        Test.setMock(HttpCalloutMock.class, new  WeatherGlobalHttpMockIsWrong());
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertEquals(true, result.isEmpty());
    }
}