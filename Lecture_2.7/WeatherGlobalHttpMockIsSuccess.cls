@IsTest
global class WeatherGlobalHttpMockIsSuccess implements HttpCalloutMock{
	 
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"data":[{"datetime" : "2021-05-11", "temp" : 16.2}, {"datetime" : "2021-06-11", "temp" : 17.2}]}');
        response.setStatusCode(200);
        return response; 
	}
}