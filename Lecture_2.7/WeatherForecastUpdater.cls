public class WeatherForecastUpdater {
    
    @future(callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> spacePoints = SpacePointManager.getSpacePoints();
        List<Weather_Daily_Forecast__c> newDailyForecasts = new List<Weather_Daily_Forecast__c>();
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        
        for (Space_Point__c spacePoint : spacePoints) {
            try {
                forecastMap = WeatherForecastService.getForecasts(spacePoint.Latitude__c, spacePoint.Longitude__c);
                
                for (Date item : forecastMap.keyset()) {
                    Weather_Daily_Forecast__c dailyForecast = new Weather_Daily_Forecast__c (
                        Average_Temperature__c = forecastMap.get(item),
                        Date__c = date.valueOf(item),
                        Space_Point__c = spacePoint.Id
                    );
                    newDailyForecasts.add(dailyForecast);
                }      
            } catch (WeatherForecastService.WeatherForecastException ex) {
                System.debug(LoggingLevel.ERROR, ex.getMessage());
            }
        }
        List<Weather_Daily_Forecast__c> oldDailyForecasts = WeatherDailyForecastManager.getSpacePoints();
        delete oldDailyForecasts;
        insert newDailyForecasts;
    }
}