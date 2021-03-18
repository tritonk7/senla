/*Code for Anonymous:
String name = 'John';
List<Integer> age = new List<Integer>{20,24,30};
Integer year = 2020;
TouristManager.getTouristsByName(name);
TouristManager.getTouristsByAge(age);
TouristManager.getTouristsByFlightDate(Integer year);
TouristManager.getTouristByTrip();
TouristManager.getTouristsNotRegistred();*/

public class TouristManager {
    
    public static List<Tourists__c> getTouristsByName(String name) {
        if (String.isBlank(name)) {
            return new List<Tourists__c>();
        }
        List<Tourists__c> newListTourists = [
            SELECT Name, 
            Tourist_Age__c 
            FROM Tourists__c  
            WHERE Name = :name
        ];
        return newListTourists;
    }
    
    public static List<Tourists__c> getTouristsByAge(List <Integer> age) {
        List<Integer> correctAge = new List<Integer>();
        
        for (Integer i : age) {
            if (i > 0 && i != null && i < 110) {
                correctAge.add(i);
            } 
        }
        
        List<Tourists__c> sortAge = [
            SELECT Name, 
            Tourist_Age__c
            FROM Tourists__c
            WHERE Tourist_Age__c =: correctAge
        ];
        return sortAge;
    }
    
    public static List<Tourists__c> getTouristsByFlightDate(Integer year) {
        String lengthInt = string.ValueOf(year);
        if (lengthInt.length() < 4 || lengthInt.length() > 4 || year == null) {
            System.debug('Incorrect format year!');
            return new List<Tourists__c>();
        } 
        List<Tourists__c> newListTourists = [
            SELECT Name, 
            Tourist_Age__c 
            FROM Tourists__c
            WHERE Id IN(SELECT New_Tourist__c 
                        FROM Flight__c 
                        WHERE CALENDAR_YEAR(Trip__r.Start_Data__c) = :year)
        ];
        return newListTourists;
    }
    
    public static List<Tourists__c> getTouristByTrip() {
        List<Tourists__c> newListTourists = [
            SELECT Name, 
            Tourist_Age__c, 
            (SELECT Trip__r.Name, Trip__r.Start_Data__c FROM Flights__r WHERE Trip__c != null) 
            FROM Tourists__c
        ];
        return newListTourists;  
    }
    
    public static List<Flight__c> getTouristsNotRegistred() {
        List<Flight__c> newListTourists = [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c = 0
        ];
        return newListTourists;
    }   
}