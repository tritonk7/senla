public class WeatherForecastService {
    public class CustomException extends Exception {}
    
    public static  Map<Date, Decimal>  getForecasts(Decimal latitude, Decimal longitude) {   
        if (latitude == null || longitude == null) {
            return new Map<Date, Decimal>();
        }
        String apiKey = Constants.WEATHERBIT_IO_API_KEY;
        String requestEndPoint = Constants.WEATHERBIT_IO_END_POINT;
        requestEndPoint += '?lat=' + latitude;
        requestEndPoint += '&lon=' + longitude;
        requestEndPoint += '&key=' + apiKey;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
        Map<Date, Decimal> forecastMap = new Map<Date, Decimal>();
        
        try {
            if (response.getStatusCode() != Constants.RESPONSE_STATUS_CODE_200) { 
                throw new CustomException(Constants.WEATHER_FORECAST_SERVICE_EXCEPTION_ERROR);
            }
        } catch (CustomException ex) {
            System.debug(ex.getMessage());
        }
        
        if (response.getStatusCode() == Constants.RESPONSE_STATUS_CODE_200) {
            Map<String, Object> jsonMeta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
            List<Object> dataList = (List<Object>) jsonMeta.get('data');
            
            for (Integer i = 0; i < dataList.size(); i++) {
                Map<String, Object> item = (Map<String, Object>)dataList[i]; 
                forecastMap.put(date.valueOf(string.valueOf(item.get('datetime'))), (decimal)(item.get('temp')));                     
            }     
        }
        return forecastMap;
    }                         
}