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
            IsDuplicate__c
            FROM Tourists__c
        ]; 
    }
    
    public static List<Space_Point__c> getSpacePoints() {
        return [
            SELECT Id, 
            City__c, 
            Latitude__c, 
            Longitude__c 
            FROM Space_Point__c
        ];
    }
    
    public static List<Trip__c> getTrips() {
        return [
            SELECT Id,
            Name,
            Mininmum_Age__c,
            Start_Data__c
            FROM Trip__c
        ];
    }
    public static void createTourist() {
        List<Tourists__c> newTourist = new List<Tourists__c> {
            new Tourists__c(
                Name = 'Test1', 
                IsDuplicate__c = false, 
                Tourist_Email__c = 'test1@gmail.com',
                Active__c = false, 
                Birthday__c = Date.newInstance(2000, 01, 01)
            )
                }; 
                    insert newTourist;
    }
    
    public static void createTourists(){
        List<Tourists__c> newTourists = new List<Tourists__c> {
            new Tourists__c(
                Name = 'Test1',
                Tourist_Email__c = 'test1@gmail.com',
                Birthday__c = Date.newInstance(2000, 01, 01)
            ),
                new Tourists__c(
                    Name = 'Test2',
                    Tourist_Email__c = 'test2@gmail.com',
                    Birthday__c = Date.newInstance(2000, 02, 02)
                ),
                new Tourists__c(
                    Name = 'Test3',
                    Tourist_Email__c = 'test3@gmail.com',
                    Birthday__c = Date.newInstance(2000, 02, 02)
                ),
                new Tourists__c(
                    Name = 'Test3',
                    IsDuplicate__c = true,
                    Tourist_Email__c = 'test3@gmail.com',
                    Birthday__c = Date.newInstance(2000, 02, 02)
                )
                };  
                    insert newTourists;
    }
    
    public static void createTrip() {
        List<Trip__c> newTrip = new List<Trip__c> {
            new Trip__c(
                Name = 'Gomel',
                Mininmum_Age__c = 5,
                Start_Data__c = Date.newInstance(2022, 08, 05)
            )
                };
                    insert newTrip;
    }
    
    public static void createFlight() {
        createTourist();
        createTrip();
        List<Tourists__c> tourist = getTourists();
        List<Trip__c> trip = getTrips();
        List<Flight__c> flights = new List<Flight__c> ();
        
        for (Integer i = 0; i < tourist.size(); i++){
            Flight__c flight = new Flight__c(
                New_Tourist__c = tourist[i].Id,
                Trip__c = trip[i].Id,
                Status__c = 'Accepted'
            );
            
            flights.add(flight);
        }
        
        insert flights;
    }
    
    public static void createSpacePoint() {
        List<Space_Point__c> newSpacePoint = new List<Space_Point__c> {
            new Space_Point__c(
                Name = 'Russian Place',
                Country__c = 'Russia',
                City__c = 'Moscow',
                Latitude__c = 55,
                Longitude__c = 40
            ),
                new Space_Point__c(
                    Name = 'Russian Place',
                    Country__c = 'Russia',
                    City__c = 'Unknown',
                    Latitude__c = null,
                    Longitude__c = null
                )              
                };
                    insert newSpacePoint;
    }
    
    public static void createWeather() {
        List<Weather_Daily_Forecast__c> newWeather = new List<Weather_Daily_Forecast__c>{
            new Weather_Daily_Forecast__c(
                Space_Point__c = 'a025g000002v6U2AAI',
                Date__c = Date.newInstance(2021, 05, 01)),
                new Weather_Daily_Forecast__c(
                    Space_Point__c = null,
                    Date__c = Date.newInstance(2022, 06, 02))    
                };
                    insert newWeather;
    }
}