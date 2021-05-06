@IsTest
private class TouristManagerTest {
    
    @IsTest
    static void testGetByNameSOQL() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        String name = tourists[0].Name; 
        List<Tourists__c> touristsByName = TouristManager.getByNameSOQL(name);
        System.assertEquals(1, touristsByName.size());
        String nameIsBlank;
        touristsByName = TouristManager.getByNameSOQL(nameIsBlank);
        System.assertEquals(0, touristsByName.size());
    } 
    
    @IsTest
    static void testGetByName() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Id[] fixedSearchResults = new Id[]{tourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
        List<sObject> resultsIsNull = TouristManager.getByName(null);
        List<sObject> results = TouristManager.getByName(tourists[0].Name);
        System.assertEquals(tourists[0].Id, results[0].Id, 'Tourist Ids should match');
        System.assertEquals(1, results.size());
        System.assertEquals(0, resultsIsNull.size());
    }
        
    @IsTest
    static void testgetByAges() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Integer> ages = new Set<Integer>();
        
        for (Tourists__c tourist : tourists) {
            Integer age = Integer.valueOf(tourist.Tourist_Age__c);
            ages.add(age);
        }
        List<Tourists__c> touristsByAge = TouristManager.getByAges(ages);
        System.assertEquals(4, touristsByAge.size());
        ages = new Set<Integer>();
        touristsByAge = TouristManager.getByAges(ages);
        System.assertEquals(0, touristsByAge.size());
    }
    
    @IsTest
    static void testGetByFlightDate() {
        TestDataFactory.createFlight();
        List<Tourists__c> tourist = TestDataFactory.getTourists();
        Integer year = 2021;
        Integer nextYear = 20221;
        List<Tourists__c> touristsByFlightDate = TouristManager.getByFlightDate(year);
        System.assertEquals(1, touristsByFlightDate.size());
        touristsByFlightDate = TouristManager.getByFlightDate(nextYear);
        System.assertEquals(0, touristsByFlightDate.size());
    }
    
    @IsTest
    static void testGetByTrip() {
        TestDataFactory.createFlight();
        List<Tourists__c> tourist = TestDataFactory.getTourists();
        List<Tourists__c> touristsByTrip = TouristManager.getByTrip();
        System.assertEquals(1, touristsByTrip.size());
    }
    
    @IsTest
    static void testGetNameEmailDuplicate() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<String> name = new Set<String>();
        Set<String> email = new Set<String>();
        
        for (Tourists__c item : tourists) {
            name.add(item.Name);
            email.add(item.Tourist_Email__c);
        }
        List<Tourists__c> touristsDuplicateCheck = TouristManager.getNameEmailDuplicate(name, email);
        System.assertEquals(3, touristsDuplicateCheck.size());
        Set<String> nameCheck = new Set<String>();
        Set<String> emailCheck = new Set<String>();
        touristsDuplicateCheck = TouristManager.getNameEmailDuplicate(nameCheck, emailCheck);
        System.assertEquals(0, touristsDuplicateCheck.size()); 
    }
    
    @IsTest
    static void testGetIdNameAgeCount() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TouristManager.getIdNameAgeCount();
        System.assertEquals(4, tourists.size());
    }
    
    @IsTest
    static void testGetByIds() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id>();
        Set<Id> touristsIdisEmpty = new Set<Id>();
        List<Tourists__c> checkTourists = TouristManager.getByIds(touristsIdisEmpty);
        System.assertEquals(0, checkTourists.size());
        
        for (Tourists__c item : tourists) {
            touristsId.add(item.Id);
        }
        checkTourists = TouristManager.getByIds(touristsId);
        System.assertEquals(4, checkTourists.size());
    }
    
    @IsTest
    static void testGetNameById() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Set<Id> touristsId = new Set<Id>();
        Set<Id> touristsIdisEmpty = new Set<Id>();
        List<Tourists__c> checkTourists = TouristManager.getNameById(touristsIdisEmpty);
        System.assertEquals(0, checkTourists.size());
        
        for (Tourists__c item : tourists) {
            touristsId.add(item.Id);
        }
        checkTourists = TouristManager.getNameById(touristsId);
        System.assertEquals(4, checkTourists.size());
    }
    
    @IsTest
    static void testGetByNameAndAge() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        Id [] fixedSearchResults = new Id[]{tourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
        List<sObject> resultsIsNull = TouristManager.getByNameAndAge(null, null);
        List<sObject> results = TouristManager.getByNameAndAge(tourists[0].Name, 21);
        System.assertEquals(1, results.size());
        System.assertEquals(0, resultsIsNull.size());
    }
    
    @IsTest
    public static void testGetByNameAndEmail() {
        TestDataFactory.createTourists();
        List<Tourists__c> tourists = TestDataFactory.getTourists();
        String name = tourists[0].Name;
        String email = tourists[0].Tourist_Email__c;
        List<Tourists__c> touristsByNameAndEmail = TouristManager.getByNameAndEmail(name, email);
        System.assertEquals(1, touristsByNameAndEmail.size());
        touristsByNameAndEmail = TouristManager.getByNameAndEmail(null,null);
        System.assertEquals(0, touristsByNameAndEmail.size());
    }
}