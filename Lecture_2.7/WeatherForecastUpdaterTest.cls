@IsTest
private class WeatherForecastUpdaterTest {
    private static List<Weather_Daily_Forecast__c> newWeather;
    
    static {
        newWeather = TestDataFactory.createWeather();
    }
    
    @IsTest
    private static void testUpdateForecastsIsSuccess() {
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsSuccess());
        List<Weather_Daily_Forecast__c> oldWeatherForecasts = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertEquals(newWeather[0].Id, oldWeatherForecasts[0].Id);
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> checkOldWeatherForecasts = [
            SELECT Id 
            FROM Weather_Daily_Forecast__c 
            WHERE Id = :oldWeatherForecasts[0].Id        
        ];
        
        System.assertEquals(true, checkOldWeatherForecasts.isEmpty());
        
        List<Weather_Daily_Forecast__c> newWeatherForecasts = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertNotEquals(null, newWeatherForecasts);
        System.assertEquals(1, newWeatherForecasts.size());
        System.assertNotEquals(newWeatherForecasts[0].Id, oldWeatherForecasts[0].id);
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