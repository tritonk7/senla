public without sharing class TripInfoControllerExtension {
    public Trip__c trip {get; set;}
    public List<Tourists__c> tourists {get; set;}
    
    public TripInfoControllerExtension(ApexPages.StandardController stdController) {
            this.trip = (Trip__c)stdController.getRecord();
            this.tourists = TouristManager.getWithoutCurrentTrip(trip.id);
    } 
}