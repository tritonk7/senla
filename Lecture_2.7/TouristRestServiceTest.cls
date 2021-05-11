@IsTest
private class TouristRestServiceTest {
    private static List<Tourists__c> newTourists;
    
    static {
        newTourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetTourist() {
        String name = newTourists[0].Name; 
        String age = '21';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter('fuzzyname' , name);
        RestContext.request.addParameter('age' , age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTouristWithoutAge() {
        String name = newTourists[0].Name; 
        String age;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter('fuzzyname' , name);
        RestContext.request.addParameter('age' , age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTouristParametrNameIsBlank() {
        String name; 
        String age = '21';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter('fuzzyname' , name);
        RestContext.request.addParameter('age' , age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_NAME_EMPTY, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testGetTouristParametrAgeIsNotNumeric() {
        String name = newTourists[0].Name;  
        String age = 'one';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter('fuzzyname' , name);
        RestContext.request.addParameter('age' , age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testCreateTouristGetError() {
        String name =  newTourists[0].Name;
        String birthday = '2021-05-03';
        String email = newTourists[0].Tourist_Email__c;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = 'POST';
        
        Test.startTest();
        TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_409, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_DUPLICATE_TOURIST, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testCreateTouristGetStatusOk() {
        String name =  'John';
        String birthday = '2021-05-03';
        String email = 'john@gmail.com';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = 'POST';
        
        Test.startTest();
        TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
}