@IsTest
private class TouristManagerTest {
    private static List<Tourists__c> newTourists;
    
    static {
        newTourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetByNameSOQL() {
        List<Tourists__c> result = TouristManager.getByNameSOQL(newTourists[0].Name);
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    } 
    
    @IsTest
    private static void testGetByNameSOQLIsNegative() {
        List<Tourists__c> result = TouristManager.getByNameSOQL(null);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByName() {
        Id[] fixedSearchResults = new Id[]{newTourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
            
        List<Tourists__c> result = TouristManager.getByName(newTourists[0].Name);
        
        System.assertNotEquals(null, result);
        System.assertEquals(newTourists[0].Id, result[0].Id, 'Tourist Ids should match');
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetByNameIsNegative() {
        List<Tourists__c> result = TouristManager.getByName(null);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByAges() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Integer> ages = new Set<Integer>();
        
        for (Tourists__c tourist : tourists) {
            Integer age = Integer.valueOf(tourist.Tourist_Age__c);
            ages.add(age);
        }
        List<Tourists__c> result = TouristManager.getByAges(ages);
        
        System.assertNotEquals(null, result);
        System.assertEquals(4, result.size());
    }
    
    @IsTest
    private static void testGetByAgesIsNegative() {
        Set<Integer> ages = new Set<Integer>();
        List<Tourists__c> result = TouristManager.getByAges(ages);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByFlightDate() {
        List<Flight__c> newFlights = TestDataFactory.createFlights();
        Integer year = 2021;
        List<Tourists__c> result = TouristManager.getByFlightDate(year);
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());    
    }
    
    @IsTest
    private static void testGetByFlightDateIsNegative() {
        Integer year = 20213;
        List<Tourists__c> result = TouristManager.getByFlightDate(year);
        
        System.assertEquals(true, result.isEmpty()); 
    }
    
    @IsTest
    private static void testGetByTrip() {
        List<Flight__c> newFlights = TestDataFactory.createFlights();
        List<Tourists__c> result = TouristManager.getByTrip();
        
        System.assertNotEquals(null, result);
        System.assertEquals(newTourists[0].id, result[0].id);
    }
    
    @IsTest
    private static void testGetNameEmailDuplicate() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<String> name = new Set<String>();
        Set<String> email = new Set<String>();
        
        for (Tourists__c item : tourists) {
            name.add(item.Name);
            email.add(item.Tourist_Email__c);
        }
        List<Tourists__c> result = TouristManager.getNameEmailDuplicate(name, email);
        
        System.assertNotEquals(null, result);
        System.assertEquals(3, result.size());
    }
    
    @IsTest
    private static void testGetNameEmailDuplicateIsNegative() {
        Set<String> name = new Set<String>();
        Set<String> email = new Set<String>();
        List<Tourists__c> result = TouristManager.getNameEmailDuplicate(name, email);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetIdNameAgeCount() {
        List<Tourists__c> result = TouristManager.getIdNameAgeCount();
        
        System.assertNotEquals(null, result);
        System.assertEquals(4, result.size());
    }
    
    @IsTest
    private static void testGetByIds() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id>();
        
        for (Tourists__c item : tourists) {
            touristsId.add(item.Id);
        }
        List<Tourists__c> result = TouristManager.getByIds(touristsId);
        
        System.assertNotEquals(null, result);
        System.assertEquals(4, result.size());
    }
    
    @IsTest
    private static void testGetByIdsIsNegative() {
        Set<Id> touristsId = new Set<Id>();
        List<Tourists__c> result = TouristManager.getByIds(touristsId);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetNameById() {
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id>();
        
        for (Tourists__c item : tourists) {
            touristsId.add(item.Id);
        } 
        List<Tourists__c> result = TouristManager.getNameById(touristsId);
        
        System.assertNotEquals(null, result);
        System.assertEquals(4, result.size());
    }
    
    @IsTest
    private static void testGetNameByIdIsNegative() {
        Set<Id> touristsId = new Set<Id>();
        
        List<Tourists__c> result = TouristManager.getNameById(touristsId);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByNameAndAge() {
        Id [] fixedSearchResults = new Id[]{newTourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
            
        Integer age = 21;
        List<Tourists__c> result = TouristManager.getByNameAndAge(newTourists[0].Name, age);
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetByNameAndAgeIsNegative() {
        List<Tourists__c> result = TouristManager.getByNameAndAge(null, null);
        
        System.assertEquals(true, result.isEmpty());
    }
    
    @IsTest
    private static void testGetByNameAndEmail() {
        List<Tourists__c> result = TouristManager.getByNameAndEmail(newTourists[0].Name, newTourists[0].Tourist_Email__c);
        
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());
    }
    
    @IsTest
    private static void testGetByNameAndEmailIsNegative() {
        List<Tourists__c> result = TouristManager.getByNameAndEmail(null, null);
        
        System.assertEquals(true, result.isEmpty());
    } 
}