public class TouristManager {
    
    public static List<Tourists__c> getByName(String name) {
        
        if (String.isBlank(name)) {
            return new List<Tourists__c>();
        }
        
        return [
            SELECT Name, 
            Tourist_Age__c 
            FROM Tourists__c  
            WHERE Name = :name
        ];
    }
    
    public static List<Tourists__c> getByAges(Set <Integer> ages) {
        Set<Integer> correctAges = new Set<Integer>();
        
        for (Integer i : ages) {
            
            if (i > 0 && i != null && i < 110) {
                correctAges.add(i);
            } 
        }
        
        return [
            SELECT Name, 
            Tourist_Age__c
            FROM Tourists__c
            WHERE Tourist_Age__c =: correctAges
        ];
    }
    
    public static List<Tourists__c> getByFlightDate(Integer year) {
        String lengthInt = string.ValueOf(year);
        
        if (lengthInt.length() < 4 || lengthInt.length() > 4 || year == null) {
            return new List<Tourists__c>();
        } 
        
        return [
            SELECT Name, 
            Tourist_Age__c 
            FROM Tourists__c
            WHERE Id IN (SELECT New_Tourist__c 
                         FROM Flight__c 
                         WHERE CALENDAR_YEAR(Trip__r.Start_Data__c) = :year)
        ];
    }
    
    public static List<Tourists__c> getByTrip() {
        
        return [
            SELECT Name, 
            Tourist_Age__c, 
            (SELECT Trip__r.Name, Trip__r.Start_Data__c FROM Flights__r WHERE Trip__c != null) 
            FROM Tourists__c
        ];
        
    }
    
    public static List<Flight__c> getTouristsNotRegistred() {
        
        return [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c = 0
        ];
    }   
}