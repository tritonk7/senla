@IsTest
private class WeatherForecastServiceTest {
    private class MyException  extends Exception {}
    private static List<Space_Point__c> newSpacePoints;
    
    static {
        newSpacePoints = TestDataFactory.createSpacePoints();
    }
    
    @IsTest
    private static void testGetForecasts() {
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMock());
        Map<Date, Decimal> result = WeatherForecastService.getForecasts(newSpacePoints[0].Latitude__c, newSpacePoints[0].Longitude__c);
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetForecastsIsNegative() {
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WeatherGlobalHttpMockIsWrong());
        
        try {
            Map<Date, Decimal> result = WeatherForecastService.getForecasts(newSpacePoints[0].Latitude__c, newSpacePoints[0].Longitude__c);
            throw new MyException(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR);
        } catch (Exception ex) {
            Boolean expectedExceptionThrown = ex.getMessage().contains(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR) ? true : false;
            
            System.AssertEquals(true, expectedExceptionThrown);
        }
        Test.stopTest();
    }
}