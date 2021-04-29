public class TouristRestServiceValidations {
   
    public static void nameNullAgeNotNumeric(String touristName, String touristAgeString) {
        RestResponse response = RestContext.response;  
        List<String> errors = new List<String>();
        List<Tourists__c> tourists = new List<Tourists__c>();
        if (String.isBlank(touristName)) {
            errors.add(Constants.RESPONSE_BODY_NAME_EMPTY);  
        }
        if (String.isBlank(touristAgeString)) {
            tourists = TouristManager.getByName(touristName);
        }
        if (!String.isBlank(touristAgeString) && !touristAgeString.isNumeric()) {
            errors.add(Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE);
        } 
        if (errors.size() > 0) {
            response.responseBody = Blob.valueOf(JSON.serializePretty(errors));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
        } else {
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        }
    }
    
    public static void nameAndAgeNotNull(String touristName, String touristAgeString) {
        RestResponse response = RestContext.response;
        if (!String.isBlank(touristAgeString) && touristAgeString.isNumeric()) {
            Integer touristAge = Integer.valueOf(touristAgeString);
            List<Tourists__c> tourists = TouristManager.getByNameAndAge(touristName, touristAge);
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        }
    }
    
    public static void isTouristDuplicate(String name, String email) {
        List<Tourists__c> tourists = TouristManager.getByNameAndEmail(name, email);
        if (!tourists.isEmpty()) {
            RestResponse response = RestContext.response;
            String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_TOURIST;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_409; 
        }
    }
}