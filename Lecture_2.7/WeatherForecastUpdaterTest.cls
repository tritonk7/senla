@IsTest
private class WeatherForecastUpdaterTest {
    private static List<Weather_Daily_Forecast__c> newWeather;
    
    static {
        newWeather = TestDataFactory.createWeather();
    }
    
    @IsTest
    private static void testUpdateForecastsIsSuccess() {
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsSuccess());
        List<Weather_Daily_Forecast__c> oldWeather = WeatherDailyForecastManager.getSpacePoints();
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertNotEquals(null, result);
        System.assertNotEquals(oldWeather[0].id, result[0].id);
        System.assertEquals(1, result.size());
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