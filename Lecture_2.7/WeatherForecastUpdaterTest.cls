@IsTest
private class WeatherForecastUpdaterTest {
    private static List<Weather_Daily_Forecast__c> newWeather;
    
    static {
        newWeather = TestDataFactory.createWeather();
    }
    
    @IsTest
    private static void testUpdateForecastsIsSuccess() {
        
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsSuccess());
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testUpdateForecastsIsNegative() {
        
        Test.setMock(HttpCalloutMock.class, new  WeatherGlobalHttpMockIsWrong());
        
        Test.startTest();
        
        try{
            WeatherForecastUpdater.updateForecasts();
        } catch (WeatherForecastService.WeatherForecastException ex) {
            Boolean expectedExceptionThrown = ex.getMessage().contains(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR) ? true : false;
            
            System.AssertEquals(true, expectedExceptionThrown); 
        }
        
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertEquals(true, result.isEmpty());
        System.assertEquals(0, result.size());
    }
}