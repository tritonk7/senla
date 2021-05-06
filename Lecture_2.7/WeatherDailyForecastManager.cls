public class WeatherDailyForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getSpacePoints() {
        return  [
            SELECT Space_Point__r.Id 
            FROM Weather_Daily_Forecast__c 
            WHERE Space_Point__r.Id != NULL
        ];
    }
}