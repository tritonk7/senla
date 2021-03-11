/*Code for Anonymous:
String name = 'John';
List<Integer> age = new List<Integer>{20,24,30};
String sDate = '01/01/2020';
TouristManager.selectTouristsByName(name);
TouristManager.selectTouristsByAge(age);
TouristManager.selectTouristsByDate(sDate);
TouristManager.selectOftourists();
TouristManager.selecttouristsByNull();*/

public class TouristManager {
    
    public static List<Tourists__c> selectTouristsByName(String name) {
        List<Tourists__c> newListTourists = [
            SELECT Name, Tourist_Age__c 
            FROM Tourists__c  
            WHERE Name = :name
        ];
        
        return newListTourists;
    }
    
    public static List<Tourists__c> selectTouristsByAge(List <Integer> age) {
        List<Tourists__c> sortAge = new List<Tourists__c>();
        List<Tourists__c> newListTourists = [
            SELECT Name, Tourist_Age__c 
            FROM Tourists__c
        ];
        
        for (Tourists__c nameTourist : newListTourists) {
            
            for (Integer i: age) {
                
                if (nameTourist.Tourist_Age__c == i) {
                    sortAge.add(nameTourist);
                }
            }
        }
        return sortAge;
    }
    
    public static List<Tourists__c> selectTouristsByDate(String sDate) {
        Date dDate = Date.parse(sDate);
        List<Tourists__c> newListTourists = [
            SELECT Name, Tourist_Age__c, 
            (SELECT Trip__r.Start_Data__c 
             FROM Flights__r 
             WHERE Trip__r.Start_Data__c =: dDate) 
            FROM Tourists__c
        ];
        
        return newListTourists;
    }
    
    public static List<Flight__c> selectOftourists() {
        List<Flight__c> newListTourists = [
            SELECT Name, Trip__c, New_Tourist__r.Name, New_Tourist__r.Tourist_Age__c, trip__r.Name, trip__r.Start_Data__c 
            FROM Flight__c 
            WHERE Trip__c != null
        ];
        
        return newListTourists;
    }
    
    public static List<Flight__c> selecttouristsByNull() {
        List<Flight__c> newListTourists = [
            SELECT New_Tourist__r.Name 
            FROM Flight__c 
            WHERE New_Tourist__r.Upcoming_Flights_Count__c = 0
        ];
        
        return newListTourists;
    } 
    
}