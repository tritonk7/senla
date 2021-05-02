public class WeatherForecastWrapper {
    private static final String JSON_FIELD_NAME_DATETIME = '"datetime":';
    private static final String JSON_FIELD_NAME_DATETIME_X = '"datetime_x":';    
    public List<Data> data;
    
    public class Data {
        public Date datetime_x;
        public Decimal temp;
    }
    
    public static WeatherForecastWrapper parse(String json) {
        return (WeatherForecastWrapper) System.JSON.deserialize(json.replace(JSON_FIELD_NAME_DATETIME, JSON_FIELD_NAME_DATETIME_X), WeatherForecastWrapper.class);
    }
}