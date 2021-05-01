public class RestRequestValidationException extends Exception {
    private String errMsg;
    private Integer statusCode;
    
    public RestRequestValidationException(String errMsg, Integer statusCode) {
        this.errMsg = errMsg;
        this.statusCode = statusCode;
    }
    
    public override String getMessage() {
        return errMsg;
    }
    
    public Integer getStatusCode() {
        return statusCode;
    }
}