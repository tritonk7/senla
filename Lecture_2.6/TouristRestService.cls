@RestResource(urlMapping='/Tourist')
global with sharing class TouristRestService {
    
    @HttpGet
    global static void getTourist() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        List<Tourists__c> result = new List<Tourists__c>();
        String touristName = request.params.get('name');
        String touristsAgeString = request.params.get('age');
        Integer touristAge;
        if (String.isBlank(touristName)) {
            String errorMessage = Constants.RESPONSE_BODY_NAME_EMPTY;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
            return;        
        }        
        if (String.isBlank(touristsAgeString)) {
            result = TouristManager.getByName(touristName);
            return;
        }
        try {
            touristAge = Integer.valueof(touristsAgeString);
        } catch(Exception ex) {              
            String errorMessage = Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
            return;
        }
        List<Tourists__c> touristList = TouristManager.getByNameAgeParametrs(touristName, touristAge);    
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(touristList));
        return;
    }
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        Tourists__c newTourist = new Tourists__c(
            Name = name,
            Birthday__c = date.valueOf(birthday),
            Tourist_Email__c = email
        );
        List<Tourists__c> touristsList = TouristManager.getByNameEmail(name, email);
        If (!touristsList.isEmpty()) {
            String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_TOURIST;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_409;
            return;   
        }  
        insert newTourist;
        return;
    }    
}