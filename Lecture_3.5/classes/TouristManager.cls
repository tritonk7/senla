public class TouristManager {
    
    public static List<Tourists__c> getByNameSOQL(String name) {
        if (String.isBlank(name)) {
            return new List<Tourists__c>();
        }
        return [
            SELECT Name, 
            Tourist_Age__c 
            FROM Tourists__c  
            WHERE Name = : name
        ];
    }
    
    public static List<Tourists__c> getByName(String fuzzyName) {
        if (String.isBlank(fuzzyName)) {
            return new List<Tourists__c>();
        }
        List<List<Tourists__c>> result = [
            FIND :fuzzyName IN Name FIELDS RETURNING Tourists__c(
                Id,
                Name, 
                Tourist_Age__c
            )
        ];
        List<Tourists__c> tourist = result.get(0);
        return tourist;
    }
    
    public static List<Tourists__c> getByAges(Set<Integer> ages) {
        List<Integer> correctAges = new List<Integer>();
        if (ages.isEmpty() || ages == null || ages.contains(null)) {
            return new List<Tourists__c>();
        }
        
        for (Integer i : ages) {
            if (i >= 0 && i != null && i <= 110) {
                correctAges.add(i);
            }
        }
        return [
            SELECT Name, 
            Tourist_Age__c
            FROM Tourists__c
            WHERE Tourist_Age__c IN :correctAges
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
    
    public static List<Tourists__c> getNameEmailDuplicate(Set<String> names, Set<String> emails) {
        if (names.isEmpty() || emails.isEmpty())  {
            return new List<Tourists__c>();
        }
        return  [
            SELECT Id,
            Name, 
            Tourist_EMail__c
            FROM Tourists__c
            WHERE Tourist_EMail__c IN : emails
            AND Name IN : names
            AND IsDuplicate__c = false
        ]; 
    }
    
    public static List<Tourists__c> getIdNameAgeCount() {
        return [
            SELECT Id,
            Name,
            Tourist_Age__c,
            Upcoming_Flights_Count__c
            FROM Tourists__c
        ];
    }
    
    public static List<Tourists__c> getByIds(Set<Id> touristIds) {
        if (touristIds.isEmpty()  || touristIds == null) {
            return new List<Tourists__c>();
        }
        return  [
            SELECT Id,
            Name, 
            Tourist_Email__c
            FROM Tourists__c
            WHERE Id IN : touristIds
        ]; 
    }
    
    public static List<Tourists__c> getNameById(Set<Id> touristsId) {
        if (touristsId.isEmpty()  || touristsId == null) {
            return new List<Tourists__c>();
        }
        return  [
            SELECT Name
            FROM Tourists__c
            WHERE Id IN : touristsId
        ]; 
    }
    
    public static List<Tourists__c> getByNameAndAge(String fuzzyName, Integer age) {
        if (String.isBlank(fuzzyName) || age == null) {
            return new List<Tourists__c>();
        }
        List<List<Tourists__c>> result = [
            FIND :fuzzyName IN Name FIELDS RETURNING Tourists__c(
                Id,
                Name, 
                Tourist_Age__c 
                WHERE Tourist_Age__c = :age)
        ];
        List<Tourists__c> tourist = result.get(0);
        return tourist;
    } 
    
    public static List<Tourists__c> getByNameAndEmail(String name, String email) {
        if (String.isBlank(name) || String.isBlank(email)) {
            return new List<Tourists__c>();
        }
        return [
            SELECT Name, 
            Birthday__c, 
            Tourist_Email__c 
            FROM Tourists__c
            WHERE Name = :name 
            AND Tourist_Email__c = :email
        ];
    }
    
    public static List<Tourists__c> getWithoutCurrentTrip(Id trip) {
        if (trip == null) {
            return new List<Tourists__c>();
        }
        return [
            SELECT Name, 
            Upcoming_Flights_Count__c
            FROM Tourists__c
            WHERE Id NOT IN (
                SELECT New_Tourist__c 
                FROM Flight__c 
                WHERE Trip__c = :trip
            )
            ORDER BY Upcoming_Flights_Count__c ASC 
            LIMIT 10
        ];
    }
    
    public static List<Tourists__c> getByNotMatchId(List<String> touristsId, Decimal tripAge) {
        return [
            SELECT Id,
            Name,
            Tourist_Age__c,
            Tourist_Email__c,
            Gender__c
            FROM Tourists__c
            WHERE Active__c = TRUE
            AND Id NOT IN :touristsId
            AND Tourist_Age__c >= :tripAge
        ];
    }
    
    public static List<Tourists__c> getByIdsForAura(List<String> touristIds) {
        if (touristIds.isEmpty()  || touristIds == null) {
            return new List<Tourists__c>();
        }
        return  [
            SELECT Id
            FROM Tourists__c
            WHERE Id = :touristIds
        ]; 
    }
    
    public static List<Tourists__c> getById(String touristId) {
        if (touristId == null) {
            return new List<Tourists__c>();
        }
        return  [
            SELECT Id,
            Name,
            Tourist_Age__c
            FROM Tourists__c
            WHERE Id = :touristId
        ]; 
    }
}