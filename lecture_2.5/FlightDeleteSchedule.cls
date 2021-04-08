public class FlightDeleteSchedule  implements Schedulable {
    public void execute(SchedulableContext sc) {
        FlightDeleteBatch executeBatch = new FlightDeleteBatch(); 
        database.executebatch(executeBatch);
    }
}