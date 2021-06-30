public class WeatherDailyForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getSpacePoints() {
        return  [
            SELECT Id 
            FROM Weather_Daily_Forecast__c 
            
        ];
    }
    
    public static List<Weather_Daily_Forecast__c> getTodayWeather() {
        return [
            SELECT Id,
            Average_Temperature__c,
            Space_Point__r.City__c
            FROM Weather_Daily_Forecast__c
            WHERE Date__c = : Date.today()
        ];
    }
}