({
    doInit : function(component, event, helper) {
        helper.fetchFlights(component);
        helper.fetchWeather(component);
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.today", today);
    },
    
    handleSelectTourist: function (component, event, helper) {
        let ids = component.get("v.selectedLookUpRecord");
        let touristId = component.set("v.touristId", ids.Id);
        let touristAge = component.set("v.touristAge", ids.Tourist_Age__c);
    },
    
    selectedTrip: function (component, event, helper) {
        helper. fetchTrips(component);
    },
    
    handleSelect : function(component, event, helper) {
        helper.fetchTripSelectedRows(component, event);
        helper.validationTrip(component);
    },
    
    onChange : function(component, event, helper) {
        helper.validationSubmit(component);
    },
    
    handleConfirmDialog : function(component, event, helper) {
        component.set("v.showConfirmDialog", true);
    },
    
    handleConfirmDialogYes : function(component, event, helper) {
        helper.handleCreateFlight(component, event);
        component.set("v.showConfirmDialog", false);
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set("v.showConfirmDialog", false);
    },
    
    handleClean : function(component, event, helper) {
        $A.get("e.force:refreshView").fire();
        component.set("v.isVisibleMap", false);
        component.set("v.isVisible", false);
    }
})