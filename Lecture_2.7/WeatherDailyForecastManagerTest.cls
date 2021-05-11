@IsTest
private class WeatherDailyForecastManagerTest {
    private static List<Weather_Daily_Forecast__c> newWeather;
    
    static {
        newWeather = TestDataFactory.createWeather();
    }
    
    @IsTest
    private static void testGetSpacePoints() {
        List<Weather_Daily_Forecast__c> result = WeatherDailyForecastManager.getSpacePoints();
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
}