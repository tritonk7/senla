public class TouristRestServiceCallouts {
    
    public static void getTouristsByName(String touristName) {
        RestResponse response = RestContext.response;
        List<Tourists__c> tourists = TouristManager.getByName(touristName);
        response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
    }
    
    public static void getTouristsByNameAndAge(String touristName, String touristAgeString) {
        RestResponse response = RestContext.response;
        Integer touristAge = Integer.valueOf(touristAgeString);
        List<Tourists__c> tourists = TouristManager.getByNameAndAge(touristName, touristAge);
        response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
    }
    
    public static void createTourists(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
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