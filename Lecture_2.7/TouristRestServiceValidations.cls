public class TouristRestServiceValidations {
    
    public static void requestValidation(String touristName, String touristAgeString) {  
        String errMsg;
        if (String.isBlank(touristName)) {
            errMsg = Constants.RESPONSE_BODY_NAME_EMPTY; 
        }
        if (!String.isBlank(touristAgeString) && !touristAgeString.isNumeric()) {
            errMsg = Constants.RESPONSE_BODY_AGE_NOT_INTEGER_TYPE;
        } 
        if (!String.isEmpty(errMsg)) {
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