public class WeatherForecastServiceCallouts {  
    
    public static Map<Date, Decimal> getForecastsData(WeatherForecastWrapper jsonData) { 
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        
        for (WeatherForecastWrapper.data item : jsonData.data) {
            Decimal temp = item.temp;
            Date datetime_x = item.datetime_x;
            forecastMap.put(datetime_x,temp);
        }
        return forecastMap;
    }
    
    public static HttpRequest createRequest(Decimal latitude, Decimal longitude) {
        List<Object> requestParams = new List<Object> {latitude, longitude, Constants.WEATHERBIT_IO_API_KEY};
            String requestEndPoint = Constants.NAMED_CREDENTIALS_WEATHERBIT + String.format('?lat={0}&lon={1}&key={2}', requestParams);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod(Constants.HTTP_METHOD_GET);
        HTTPResponse response = http.send(request);
        return request;
    }
}