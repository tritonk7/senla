@IsTest
private class WeatherForecastServiceTest {
    private static List<Space_Point__c> newSpacePoints;
    
    static {
        newSpacePoints = TestDataFactory.createSpacePoints();
    }
    
    @IsTest
    private static void testGetForecasts() {
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsSuccess());
        
        Test.startTest();
        Map<Date, Decimal> result = WeatherForecastService.getForecasts(newSpacePoints[0].Latitude__c, newSpacePoints[0].Longitude__c);
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetForecastsIsNegative() {
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsWrong());
        
        Test.startTest();
        Map<Date, Decimal> checkresult = new Map <Date, Decimal>();
        
        try {
            Map<Date, Decimal> result = WeatherForecastService.getForecasts(newSpacePoints[0].Latitude__c, newSpacePoints[0].Longitude__c);
            checkresult.putAll(result);
        } catch (WeatherForecastService.WeatherForecastException ex) {
            Boolean expectedExceptionThrown = ex.getMessage().contains(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR);
            
            System.AssertEquals(true, expectedExceptionThrown);
        }
        
        Test.stopTest();
        
        System.assertEquals(true, checkresult.isEmpty());
    }
}