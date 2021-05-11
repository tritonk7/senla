@IsTest
global class WeatherGlobalHttpMockIsWrong implements HttpCalloutMock{
	 
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('');
        response.setStatusCode(404);
        return response; 
	}
}