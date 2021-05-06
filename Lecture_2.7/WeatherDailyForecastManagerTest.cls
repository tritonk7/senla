@isTest
private class WeatherDailyForecastManagerTest {
    
    @isTest
    static void testGetSpacePoints() {
        TestDataFactory.createWeather();
        List<Weather_Daily_Forecast__c> weathers = WeatherDailyForecastManager.getSpacePoints();
        System.assertEquals(1, weathers.size());
    }
    
    @istest
    static void testGetSpacePointsIsNull() {
        List<Weather_Daily_Forecast__c> newWeather = new List<Weather_Daily_Forecast__c>{
            new Weather_Daily_Forecast__c(
                Space_Point__c = null,
                Date__c = Date.newInstance(2022, 06, 02)
            )    
                };
                    insert newWeather;
        List<Weather_Daily_Forecast__c> weathers = WeatherDailyForecastManager.getSpacePoints();
        System.assertEquals(0, weathers.size());
    }
}