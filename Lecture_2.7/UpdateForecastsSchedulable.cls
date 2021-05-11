global class UpdateForecastsSchedulable implements Schedulable {
    
    global void execute(SchedulableContext ctx) {
        WeatherForecastUpdater.updateForecasts();      
    }
}