public class TouristRestServiceValidations {
    
    public static void nameisNull(String touristName) {  
        if (String.isBlank(touristName)) {    
            String errMsg = Constants.RESPONSE_BODY_NAME_EMPTY;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(errMsg, statusCode);
        } 
    }
    
    public static void ageIsNotNumeric(String touristAgeString) {
        if (!(String.isBlank(touristAgeString) || touristAgeString.isNumeric())) {
            String errMsg = Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(errMsg, statusCode);
        } 
    }
    
    public static void isTouristDuplicate(String name, String email) {
        List<Tourists__c> tourists = TouristManager.getByNameAndEmail(name, email);
        if (!tourists.isEmpty()) {
            String errMsg = Constants.RESPONSE_BODY_DUPLICATE_TOURIST;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_409;
            throw new RestRequestValidationException(errMsg, statusCode);
        }
    }
}