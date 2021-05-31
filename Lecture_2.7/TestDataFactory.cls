@IsTest
public class TestDataFactory {
    
    public static List<Flight__c> getFlights() {
        return [
            SELECT Id,
            New_Tourist__c,
            Trip__c,
            Status__c
            FROM Flight__c
        ];
    }
    
    public static List<Tourists__c> getTourists() {
        return [
            SELECT Id,
            Name,
            Tourist_Age__c,
            Tourist_Email__c,
            IsDuplicate__c,
            Active__c
            FROM Tourists__c
        ];
    }
    
    public static List<Tourists__c> createTourists() {
        List<Tourists__c> newTourists = new List<Tourists__c> {
            new Tourists__c(Name = 'Test1', Tourist_Email__c = 'test1@gmail.com', Birthday__c = Date.newInstance(2000, 01, 01), IsDuplicate__c = false, Active__c = true),
            new Tourists__c(Name = 'Test2', Tourist_Email__c = 'test2@gmail.com', Birthday__c = Date.newInstance(2000, 02, 02), IsDuplicate__c = false, Active__c = false),
            new Tourists__c(Name = 'Test3', Tourist_Email__c = 'test3@gmail.com', Birthday__c = Date.newInstance(2000, 02, 02), IsDuplicate__c = false),
            new Tourists__c(Name = 'Test3', Tourist_Email__c = 'test3@gmail.com', Birthday__c = Date.newInstance(2000, 02, 02), IsDuplicate__c = true)
        };
        insert newTourists;
        
        return newTourists;
    }
    
    public static List<Trip__c> createTrips() {
        List<Trip__c> newTrips = new List<Trip__c> {
            new Trip__c(Name = 'Gomel', Mininmum_Age__c = 5, Start_Data__c = Date.newInstance(2021, 08, 05)),
            new Trip__c(Name = 'Minsk', Mininmum_Age__c = 10, Start_Data__c = Date.newInstance(2022, 08, 05))
        };
        insert newTrips;
        
        return newTrips;
    }
    
    public static List<Flight__c> createFlights() {
        List<Trip__c> newTrips = createTrips();
        List<Tourists__c> newTourists = createTourists();
        List<Flight__c> newFlights = new List<Flight__c> {
            new Flight__c(New_Tourist__c = newTourists[0].Id, Trip__c = newTrips[0].Id, Status__c = Constants.FLIGHT_STATUS_DECLINED),
            new Flight__c(New_Tourist__c = newTourists[1].Id, Trip__c = newTrips[1].Id, Status__c = 'Accepted')
        };
        insert newFlights;
        
        return newFlights;
    }
    
    public static List<Space_Point__c> createSpacePoints() {
        List<Space_Point__c> newSpacePoints = new List<Space_Point__c> {
            new Space_Point__c(Name = 'Belarus Place', Country__c = 'Belarus', City__c = 'Gomel', Latitude__c = 52.43, Longitude__c = 30.97),
            new Space_Point__c(Name = 'Russian Place', Country__c = 'Russia', City__c = 'Unknown', Latitude__c = null, Longitude__c = null)
        };
        insert newSpacePoints;
        
        return newSpacePoints;
    }
    
    public static List<Weather_Daily_Forecast__c> createWeather() {
        List<Space_Point__c> newSpacePoints = createSpacePoints();
        List<Weather_Daily_Forecast__c> newWeather = new List<Weather_Daily_Forecast__c> {
            new Weather_Daily_Forecast__c(Space_Point__c = newSpacePoints[0].Id, Date__c = Date.newInstance(2021, 05, 01)),
            new Weather_Daily_Forecast__c(Space_Point__c = null, Date__c = Date.newInstance(2022, 06, 02))
        };
        insert newWeather;
        
        return newWeather;
    }
    
    public static Flight__c createFlight(Date birthday, Integer minAge, Date startDate) {
        List<Tourists__c> tourists = createTourists();
        Tourists__c newTourist = new Tourists__c(Name = tourists[0].Name, Birthday__c = birthday);
        insert newTourist;
        
        Trip__c newTrip = new Trip__c(Mininmum_Age__c = minAge, Start_Data__c = startDate);
        insert newTrip;
        
        Flight__c newFlight = new Flight__c(New_Tourist__c = newTourist.Id, Trip__c = newTrip.Id);
        
        return newFlight;
    }
}