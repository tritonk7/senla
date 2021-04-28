public class WeatherForecastServiceCallouts {
    private static final String REQUEST_PARAM_DATA = 'data';
    private static final String REQUEST_PARAM_DATETIME = 'datetime';
    private static final String REQUEST_PARAM_TEMP = 'temp';    
    
    public static Map<Date, Decimal> getforecastsData(Map<String, Object> jsonMeta) { 
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        List<Object> dataList = (List<Object>) jsonMeta.get(REQUEST_PARAM_DATA);
        
        for (Integer i = 0; i < dataList.size(); i++) {
            Map<String, Object> item = (Map<String, Object>)dataList[i];
            Date getDate = Date.valueOf(String.valueOf(item.get(REQUEST_PARAM_DATETIME)));
            Decimal getTempreture = Decimal.valueOf(String.valueOf(item.get(REQUEST_PARAM_TEMP)));
            forecastMap.put(getDate, getTempreture);                    
        }
        return forecastMap;
    }
    
    public static HttpRequest createRequest(Decimal latitude, Decimal longitude) {
        String apiKey = Constants.WEATHERBIT_IO_API_KEY;
        String requestEndPoint = 'callout:WeatherAPI?key=' + apiKey + '&lon' + longitude +'&lat=' + latitude;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod(Constants.HTTP_METHOD_GET);
        HTTPResponse response = http.send(request);
        return request;
    }
}