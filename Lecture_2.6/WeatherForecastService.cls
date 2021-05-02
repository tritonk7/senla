public class WeatherForecastService {
    public class  WeatherForecastException extends Exception {}
    
    public static  Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {   
        Http http = new Http();
        HttpResponse response = http.send(WeatherForecastServiceCallouts.createRequest(latitude, longitude));
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        String jsonResponse = response.getBody();
        if (response.getStatusCode() == Constants.RESPONSE_STATUS_CODE_200) { 
            WeatherForecastWrapper jsonData = WeatherForecastWrapper.parse(jsonResponse);
            forecastMap = WeatherForecastServiceCallouts.getForecastsData(jsonData);
        } else {
            throw new WeatherForecastException(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR);
        }                   
        return forecastMap;
    }                         
}