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
    
    public static void selectTouristsByName(String name) {
        List<Tourists__c> newListTourists = [SELECT Name, Tourist_Age__c FROM Tourists__c  WHERE Name = :name];
        
        for (Tourists__c nameTourist: newListTourists) {
            String otpName ='Name - ' + nameTourist.Name + ', Age - ' + nameTourist.Tourist_Age__c;
            System.debug(otpName);
        } 
    }
    
    public static void selectTouristsByAge(List <Integer> age) {
        List<Tourists__c> newListTourists = [SELECT Name, Tourist_Age__c FROM Tourists__c];
        
        for (Tourists__c nameTourist : newListTourists) {
            
            for (Integer i: age) {
                
                if (nameTourist.Tourist_Age__c == i) {
                    String otpName ='Name - ' + nameTourist.Name + ', Age - ' + nameTourist.Tourist_Age__c;
                    System.debug(otpName);
                }
            }
        }
    }
    
    public static void selectTouristsByDate(String sDate) {
        Date dDate = Date.parse(sDate);
        List<Tourists__c> newListTourists = [SELECT Name, Tourist_Age__c, (SELECT Trip__r.Start_Data__c FROM Flights__r WHERE Trip__r.Start_Data__c =: dDate) FROM Tourists__c];
        
        for (Tourists__c nameTourist : newListTourists) {
            String otpName ='Name - ' + nameTourist.Name + ', Age - ' + nameTourist.Tourist_Age__c;
            System.debug(otpName);
        }   
    }
    
    public static void selectOftourists() {
        List<Flight__c> newListTourists = [SELECT Name, Trip__c, New_Tourist__r.Name, New_Tourist__r.Tourist_Age__c, trip__r.Name, trip__r.Start_Data__c FROM Flight__c WHERE Trip__c != null];
        
        for (Flight__c nameTourist : newListTourists) {
            String otpName = 'Name: ' + nameTourist.New_Tourist__r.Name
                + ', Age: ' + nameTourist.New_Tourist__r.Tourist_Age__c 
                + ', Trip Name: ' + nameTourist.trip__r.Name 
                + ', Start Date: '
                + nameTourist.trip__r.Start_Data__c;
            System.debug(otpName);
        } 
    }
    
    public static void selecttouristsByNull() {
        List<Flight__c> newListTourists = [SELECT New_Tourist__r.Name FROM Flight__c WHERE Trip__c = null];
        
        for (Flight__c nameTourist : newListTourists) {
            String otpName = nameTourist.New_Tourist__r.Name;
            System.debug(otpName);
        }   
    }  
}