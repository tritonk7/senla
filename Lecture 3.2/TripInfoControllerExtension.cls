public without sharing class TripInfoControllerExtension {
    public Trip__c trip {get; set;}
    public List<Tourists__c> tourists {get; set;}
    
    public TripInfoControllerExtension(ApexPages.StandardController stdController) {
            this.trip = (Trip__c)stdController.getRecord();
            this.tourists = [
                SELECT Name, 
                Upcoming_Flights_Count__c
                FROM Tourists__c
                WHERE Id NOT IN (SELECT New_Tourist__c FROM Flight__c WHERE Trip__c = :trip.Id)
                ORDER BY Upcoming_Flights_Count__c ASC LIMIT 10
            ];
    } 
}