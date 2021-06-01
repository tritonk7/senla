public class WeatherDailyForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getSpacePoints() {
        return  [
            SELECT Id,
            Space_Point__c 
            FROM Weather_Daily_Forecast__c 
            WHERE Space_Point__c != null
        ];
    }
}