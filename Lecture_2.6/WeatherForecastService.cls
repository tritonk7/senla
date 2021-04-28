public class WeatherForecastService {
    public class  WeatherForecastException extends Exception {}
    
    public static  Map<Date, Decimal>  getForecasts(Decimal latitude, Decimal longitude) {   
        Http http = new Http();
        HttpResponse response = http.send(WeatherForecastServiceCallouts.createRequest(latitude, longitude));
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        if (response.getStatusCode() == Constants.RESPONSE_STATUS_CODE_200) { 
            Map<String, Object> jsonMeta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            forecastMap = WeatherForecastServiceCallouts.getForecastsData(jsonMeta);
        } else {
            throw new WeatherForecastException(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR);
        }                   
        return forecastMap;
    }                         
}