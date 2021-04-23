public class WeatherForecastUpdater {
    
    @future(callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> spacePointList = SpacePointManager.getSpacePoints();
        List<Weather_Daily_Forecast__c> newDailyForecasts = new List<Weather_Daily_Forecast__c>();
        
        for (Space_Point__c spacePoint : spacePointList) {
            Map<Date, Decimal> forecastMap = WeatherForecastService.getForecasts(spacePoint.Latitude__c, spacePoint.Longitude__c);
            for (Date item : forecastMap.keyset()) {
                Weather_Daily_Forecast__c dailyForecast = new Weather_Daily_Forecast__c();
                dailyForecast.Average_Temperature__c = forecastMap.get(item);
                dailyForecast.Date__c = date.valueOf(item);
                dailyForecast.Space_Point__c = spacePoint.Id;
                newDailyForecasts.add(dailyForecast);
            }      
        }
        List<Weather_Daily_Forecast__c> oldDailyForecasts = WeatherDailyForecastManager.getSpacePoints();
        delete oldDailyForecasts;
        insert newDailyForecasts;
    }
}