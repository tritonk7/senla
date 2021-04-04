public class ScheduledBatch  implements Schedulable {
    public void execute(SchedulableContext sc) {
        DeleteFlights b = new DeleteFlights(); 
        database.executebatch(b);
    }
}