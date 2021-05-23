@IsTest
private class TouristRestServiceTest {
    private static List<Tourists__c> newTourists;
    
    @TestVisible
    private static final String REQUEST_PARAMS_FUZZYNAME = 'fuzzyname';
    private static final String REQUEST_PARAMS_AGE = 'age';
    private static final String REQUEST_URL = '/services/apexrest/Tourist/';
    private static final String TOURIST_AGE_IS_NOT_NUMERIC = 'one';
    private static final String TOURIST_NAME = 'John';
    private static final String TOURIST_EMAIL = 'john@gmail.com';
    private static final String TOURIST_BIRTHDAY = '2021-05-03';
    private static final String HTTP_METHOD_POST = 'post';
    private static final String TOURIST_AGE = '21';
    
    static {
        newTourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetTourist() {
        String name = newTourists[0].Name; 
        String age = TOURIST_AGE;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter(REQUEST_PARAMS_FUZZYNAME, name);
        RestContext.request.addParameter(REQUEST_PARAMS_AGE, age);
        
        Id[] fixedSearchResults = new Id[]{newTourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertNotEquals(null, RestContext.response.responseBody);
        System.assertEquals(true, RestContext.response.responseBody.tostring().contains(newTourists[0].Name));
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTouristWithoutAge() {
        String name = newTourists[0].Name; 
        String age;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter(REQUEST_PARAMS_FUZZYNAME, name);
        RestContext.request.addParameter(REQUEST_PARAMS_AGE, age);
        
        Id[] fixedSearchResults = new Id[]{newTourists[0].Id};
            Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertNotEquals(null, RestContext.response.responseBody);
        System.assertEquals(true, RestContext.response.responseBody.tostring().contains(newTourists[0].Name));
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTouristParametrNameIsBlank() {
        String name; 
        String age = TOURIST_AGE;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter(REQUEST_PARAMS_FUZZYNAME, name);
        RestContext.request.addParameter(REQUEST_PARAMS_AGE, age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_NAME_EMPTY, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testGetTouristParametrAgeIsNotNumeric() {
        String name = newTourists[0].Name;  
        String age = TOURIST_AGE_IS_NOT_NUMERIC;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;
        RestContext.request.addParameter(REQUEST_PARAMS_FUZZYNAME, name);
        RestContext.request.addParameter(REQUEST_PARAMS_AGE, age);
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testCreateTouristGetError() {
        String name = newTourists[0].Name;
        String birthday = TOURIST_BIRTHDAY;
        String email = newTourists[0].Tourist_Email__c;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = HTTP_METHOD_POST;
        
        Test.startTest();
        TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_409, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_DUPLICATE_TOURIST, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testCreateTouristGetStatusOk() {
        String name = TOURIST_NAME;
        String birthday = TOURIST_BIRTHDAY;
        String email = TOURIST_EMAIL;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = REQUEST_URL;
        RestContext.request.httpMethod = HTTP_METHOD_POST;
        
        Test.startTest();
        TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        System.assertNotEquals(null, RestContext.response.responseBody);
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
}