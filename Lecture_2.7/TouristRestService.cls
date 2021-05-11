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
        try {
            TouristRestServiceValidations.requestValidation(touristName, touristAgeString);
            if (String.isBlank(touristAgeString)) {
                TouristRestServiceCallouts.getTouristsByName(touristName);
            } else {
                TouristRestServiceCallouts.getTouristsByNameAndAge(touristName, touristAgeString);  
            }  
        } catch(RestRequestValidationException ex) {
            response.responseBody = Blob.valueOf(ex.getMessage());
            response.statusCode = ex.getStatusCode();
        }
    }
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        try{
            TouristRestServiceValidations.isTouristDuplicate(name, email);
            TouristRestServiceCallouts.createTourists(name, birthday, email);
        } catch (RestRequestValidationException ex) {
            response.responseBody = Blob.valueOf(ex.getMessage());
            response.statusCode = ex.getStatusCode();
        }
    }
}