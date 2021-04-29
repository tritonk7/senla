@RestResource(urlMapping='/Tourist')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAM_AGE = 'age';
    private static final String REQUEST_PARAM_FUZZYNAME = 'fuzzyname';
    
    @HttpGet
    global static void getTourist() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String touristName = request.params.get(REQUEST_PARAM_FUZZYNAME);
        String touristAgeString = request.params.get(REQUEST_PARAM_AGE);
        TouristRestServiceValidations.nameNullAgeNotNumeric(touristName, touristAgeString);
        TouristRestServiceValidations.nameAndAgeNotNull(touristName, touristAgeString);
    }
      
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        TouristRestServiceValidations.isTouristDuplicate(name, email);
        Tourists__c newTourist = new Tourists__c
            (
                Name = name,
                Birthday__c = Date.valueOf(birthday),
                Tourist_Email__c = email
            );
        insert newTourist;
        response.responseBody = Blob.valueOf(JSON.serializePretty(newTourist));
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
    }
}